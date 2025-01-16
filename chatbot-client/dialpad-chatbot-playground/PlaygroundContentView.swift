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
    
    let chatbotSessionEnded = NotificationCenter.default.publisher(for: NSNotification.Name.chatbotSessionEnded)
    
    var body: some View {
        ZStack(alignment: .top) {
            if !viewModel.isOpen {
                Button(action: {
                    viewModel.open()
                }) {
                    VStack(alignment: .trailing) {
                        Image("m.help.dialpad.com")
                            .scaledToFit()
                            .overlay(content: {
                                AsyncImage(url: URL(string: fabIconUrl))
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            })
                    }
                }
                .disabled(viewModel.isOpen)
            }
            if viewModel.isOpen {
                VStack(content: {
                    Button(action: {
                        NotificationCenter.default.post(name: Notification.Name.endChatbotSession, object: nil)
                    }){
                        HStack(alignment: .lastTextBaseline, content: {
                            Spacer()
                            Capsule()
                                .fill(Color.black)
                                .frame(width: 96, height: 36, alignment: .center)
                                .overlay(
                                    Text("End chat")
                                        .foregroundColor(.white)
                                )
                                .padding([.trailing], 4)
                        })
                    }.buttonStyle(PlainButtonStyle())
                    DialpadChatbot(url: url)
                })
            }
        }
        .onReceive(chatbotSessionEnded) {
            _ in
            viewModel.isOpen = false
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
