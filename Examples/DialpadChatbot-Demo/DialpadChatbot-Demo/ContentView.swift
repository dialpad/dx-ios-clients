import DialpadChatbot
import SwiftUI

private class ViewModel: NSObject, ObservableObject {
    @Published var isOpen = false

    func close() {
        isOpen = false
    }

    func open() {
        isOpen = true
    }
}

struct ContentView: View {
    let url: String
    let chatbotSessionEnded = NotificationCenter.default.publisher(
        for: NSNotification.Name.chatbotSessionEnded)

    @StateObject fileprivate var viewModel = ViewModel()

    var backgroundColor: Color {
        if self.viewModel.isOpen {
            Color.white
        } else {
            Color(.sRGB, red: 124 / 255, green: 82 / 255, blue: 255 / 255, opacity: 1.0)
        }
    }

    var body: some View {
        VStack {
            VStack {
                Spacer()
                HStack(
                    alignment: .firstTextBaseline, spacing: 0,
                    content: {
                        Text("ACME Inc.")
                            .foregroundStyle(.white)
                            .font(.system(size: 90))
                            .fontWeight(.heavy)
                        Spacer()
                    }
                )
                //.background(Color.brown)
                .padding([.leading], 16)
            }
            //.background(Color.yellow)

            Divider()
                .frame(height: 1)
                .overlay(Color.white)
                //.background(Color.cyan)
                .padding(.horizontal, 16)

            VStack(
                alignment: .leading, spacing: 0,
                content: {
                    HStack(
                        alignment: .firstTextBaseline, spacing: 0,
                        content: {
                            Text("Customer Care")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                    )
                    //.background(Color.brown)
                    .padding([.leading], 16)
                    Button(action: {
                        self.viewModel.isOpen.toggle()
                    }) {
                        Text("Chat with us")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    .background(
                        Color(.sRGB, red: 241 / 255, green: 22 / 255, blue: 147 / 255, opacity: 1.0)
                    )
                    .buttonStyle(.bordered)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .controlSize(.regular)
                    .padding([.leading], 16)
                    Spacer()
                })
            //.background(Color.red)
        }
        .background(self.backgroundColor)
        //.containerRelativeFrame(
        //    [.horizontal, .vertical],
        //    alignment: .topLeading
        //)
        .overlay(content: {
            if viewModel.isOpen {
                VStack(
                    alignment: .trailing, spacing: 0,
                    content: {
                        Button(action: {
                            NotificationCenter.default.post(
                                name: Notification.Name.endChatbotSession, object: nil)
                        }) {
                            Text("End chat")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                        .background(
                            Color(
                                .sRGB, red: 241 / 255, green: 22 / 255, blue: 147 / 255,
                                opacity: 1.0)
                        )
                        .buttonStyle(.bordered)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                        .controlSize(.regular)
                        .padding([.trailing, .bottom], 16)
                        DialpadChatbotView(url: url)
                    })
            }

        })
        .onReceive(chatbotSessionEnded) {
            _ in
            self.viewModel.isOpen.toggle()
        }

    }
}

/**
 * @docummentation: https://light...dialpad.com/dxclient/dist/...native=ios
 * in the #Preview is a beta env URL, which may not work without Dialpad VPN. You may replace it
 * with your production URL, which can be obtained from the Digital Experience admin pages.
 * Alternatively, you can reach out to the professional services team to get your production URL.
 */
#Preview {
    ContentView(
        url:
            "https://lighthouse.dx.dialpad.com/dxclient/dist/?provemail=3340&channelid=1b6db43e5ecf4354a9e41ccd2621b05c&native=ios"
    )
}
