import SwiftUI

@main
struct PlaygroundApp: App {
    var body: some Scene {
        WindowGroup {
            PlaygroundContentView(
                url:                    "http://localhost:8001/public/index.html?channelid=3f3fd91bc5bf4e9ab56e53c516933337&provemail=5646620347596800@dialpad.com&site=lighthouse&env=local&native=ios",
                fabIconUrl: "http://localhost:8001/src/localdev/assets/chatbot.png"
            )
            
        }
    }
}
