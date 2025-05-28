![](https://img.shields.io/badge/iOS-v16+-blue) 

# Getting Started with Ai Chatbot

## Chatbot support for native iOS apps

Dialpad's `Ai Chatbot` is supported in the native iOS apps via [`WKWebView`](https://developer.apple.com/documentation/webkit/wkwebview). This repo comes with a simple Swift package that can be embedded directly in the native iOS app.

## Key Features

* **Bi-directional Communication:**
    * Your iOS app can send commands to the chatbot using `NotificationCenter`.
    * The chatbot can send events to your iOS app using `NotificationCenter`.

* **WKWebView-based Implementation:** Leverages `WKWebView` for rendering the chatbot interface.
* **Compose Support:** The Package includes a `DialpadChatbotView` View for easy integration with your SwiftUI.

### Supported `NotificationCenter` Events

* Chatbot session started <br />

```swift
NotificationCenter.default.publisher(for: NSNotification.Name.chatbotSessionStarted)
```

* Chatbot session ended <br />

```swift
NotificationCenter.default.publisher(for: NSNotification.Name.chatbotSessionEnded)
```

* End chatbot session <br />

```swift
NotificationCenter.default.post(
    name: Notification.Name.endChatbotSession,
    object: nil
)
```


## Usage

### Installation guide

Visit the official Xcode doc in [this page](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app#Add-a-package-dependency) for more information. Use the GitHub repo for [dx-ios-clients](https://github.com/dialpad/dx-ios-clients) to add it as a dependency to your project.

### Integrating the `DialpadChatbotView`

Use the `DialpadChatbotView` View to display the chatbot within your app.

```swift
import DialpadChatbot

struct ContentView: View {
    let url: String
    var body: some View {
        VStack(
            alignment: .trailing, 
            spacing: 0,
            content: {
                DialpadChatbotView(url: url)
            })
    }
}
```

#### Parameters:
- `url`: The URL of the Chatbot to be loaded in the WebView.


## Known Issues and Unsupported features

&#9744; Chatbot experience in landscope mode. <br />
&#9744; Network interruptions. <br />
&#9744; Handling app sent to background. <br />
&#9744; Handling app brought from the background. <br />
