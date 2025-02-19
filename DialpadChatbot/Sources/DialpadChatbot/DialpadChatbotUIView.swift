import UIKit
import SwiftUI
import WebKit

/**
 * @public
 * @documentation: a custom UIViewRepresentable that implements the crux of native
 *  app and webview loading and communications. Note that this code must be implemented
 *  by the customer's native app for any cross-context communications.
 */
public struct DialpadChatbotUIView: UIViewRepresentable {
    let url: URL
    
    public class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var webView: WKWebView?
        let notificationCenter = NotificationCenter.default
        
        init(webView: WKWebView? = nil) {
            super.init()
            self.webView = webView
            self.subscribeEvents()
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.webView = webView
        }
        
        //  web client → iOS client
        //  STEP 1 of 2: receive events from the WKWebView that contains the chatbot script
        public func userContentController(
            _ userContentController: WKUserContentController,
            didReceive message: WKScriptMessage
        ) {
            if let messageBodyString = message.body as? String {
                let messageBodyData = Data(messageBodyString.utf8)
                do {
                    if let messageBodyJSON = try JSONSerialization.jsonObject(with: messageBodyData, options: []) as? [String: Any] {
                        if let event = messageBodyJSON["event"] as? String {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.publishEvents(event: event)
                            }
                        }
                    }
                } catch let error as NSError {
                    print("@dx-native-client::error::\(error.localizedDescription)")
                }
            }
        }
        
        //  STEP 2 of 2: event name is parsed and published to the containing iOS app
        func publishEvents(event: String) {
            switch event {
            case Notification.Name.chatbotSessionStarted.rawValue:
                notificationCenter.post(name: Notification.Name.chatbotSessionStarted, object: nil)
            case Notification.Name.chatbotSessionEnded.rawValue:
                notificationCenter.post(name: Notification.Name.chatbotSessionEnded, object: nil)
            default:
                return
            }
        }
        
        //  iOS client → web client
        //  STEP 1 of 3: subscribe the events that needs to be sent from the
        //  containing iOS app to the WKWebView chatbot
        func subscribeEvents() {
            //  @event: END_CHATBOT_SESSION
            notificationCenter.addObserver(
                self,
                selector: #selector(endChatbotSession),
                name: Notification.Name.endChatbotSession,
                object: nil)
            
            //  @event: OTHER SUPPORTED EVENTS
        }
        
        //  STEP 2 of 3: selector for NotificationCenter event
        @objc func endChatbotSession() {
            self.postMessageToWebView(messageDict: ["command": "END_CHATBOT_SESSION"])
        }
        
        //  STEP 3 of 3: execute the global function available on the
        //  chatbot script. this function is named "window.dxbot.publish"
        func postMessageToWebView(messageDict: [String: String]) {
            let messageData = try? JSONSerialization.data(withJSONObject: messageDict, options: [])
            let messageString = String(data: messageData!, encoding: .utf8)
            let script = "window.dxbot.publish(\"BRIDGE_IOS_NOTIFICATION\",\(messageString ?? "[]"))"
            
            self.webView?.evaluateJavaScript(script) { (result, error) in
                if result != nil {
                    // no-op
                } else if let error = error {
                    print("dx-native-client::error::\(error)")
                }
            }
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let coordinator = makeCoordinator()
        let userContentController = WKUserContentController()
        userContentController.add(coordinator, name: "dxbridge")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        let wkWebView = WKWebView(frame: .zero, configuration: configuration)
        wkWebView.navigationDelegate = coordinator
        wkWebView.load(URLRequest(url: url))
        
        return wkWebView
    }
    
    public func updateUIView(_ webView: WKWebView, context: Context) {
        // NOTE: WKWebView will load page from an URL using load(URLRequest(url: url))
        // no-op
    }
}
