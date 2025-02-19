import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            /**
             * @docummentation: https://light...dialpad.com/dxclient/dist/...native=ios
             * in the #Preview is a beta env URL, which may not work without Dialpad VPN. You may replace it
             * with your production URL, which can be obtained from the Digital Experience admin pages.
             * Alternatively, you can reach out to the professional services team to get your production URL.
             */
            ContentView(url: "https://lighthouse.dx.dialpad.com/dxclient/dist/?provemail=3340&channelid=1b6db43e5ecf4354a9e41ccd2621b05c&native=ios")
        }
    }
}
