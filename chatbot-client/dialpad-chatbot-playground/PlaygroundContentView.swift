import SwiftUI

fileprivate class PlaygroundViewModel: NSObject, ObservableObject {
    @Published var isOpen = false
    func close() {
        isOpen = false
    }
    func open() {
        isOpen = true
    }
}

struct PlaygroundContentView: View {
    let url: String
    let fabIconUrl: String
    
    @StateObject fileprivate var viewModel = PlaygroundViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if !viewModel.isOpen {
                Button(action: {
                    viewModel.open()
                }) {
                    AsyncImage(url: URL(string: fabIconUrl))
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                .disabled(viewModel.isOpen)
            }
            if viewModel.isOpen {
                DialpadChatbot(url: url)
                    .overlay(alignment: .topTrailing, content: {
                        Button(action: {
                            NotificationCenter.default.post(name: Notification.Name.endChatbotSession, object: nil)
                        }){
                            Image(systemName: "xmark")
                                .frame(width: 58, height: 58)
                                .foregroundColor(Color.black)
                                .background(Color(red: 249/255, green: 249/255, blue: 249/255))
                                .clipShape(Circle())
                        }.buttonStyle(PlainButtonStyle())
                    })
            }
        }
    }
}

// 172.124.238.34

#Preview {
    PlaygroundContentView(
        url:
            "http://localhost:8001/public/index.html?channelid=3f3fd91bc5bf4e9ab56e53c516933337&provemail=5646620347596800@dialpad.com&site=lighthouse&env=local&native=ios",
        fabIconUrl: "http://localhost:8001/src/localdev/assets/chatbot.png"
    )
}
