import SwiftUI

/**
 * @public
 * @documentation: a SwiftUI representation of the DialpadChatbotView
 */
public struct DialpadChatbotView: View {
    let url: String
    
    public init (url: String) {
        self.url = url
    }
    
    public var body: some View {
        DialpadChatbotUIView(url: URL(string: url)!)
    }
}

/**
 * @docummentation: replace url in the #Preview with your WebChat channel URL.
 */
#Preview {
    DialpadChatbotView(url: "https://lighthouse.dx.dialpad.com/dxclient/dist/?provemail=3340&channelid=c4f4da7a350a478cb723441b3cc4c738&native=ios")
}
