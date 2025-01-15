
# Getting Started with Ai Chatbot

## Chatbot support for native mobile apps

### iOS

`chatbot-client` is supported in the native iOS apps via `WKWebView`. We also provide an iOS sample app, which can be downloaded from our help pages. The sample app comes with a ready-to-use `SwiftUI` code that can be used as-is in some iOS versions.

![Native iOS app - Ai Chatbot web app](./src/localdev/assets/native.ios.support.jpg)

#### Supported features

&#9745; Launching chatbot in a `WKWebView`. <br />
&#9745; Chatbot experience in portrait mode. <br />
&#9745; Sending selected events from the chatbot to the containing app. <br />

- Chatbot session started <br />

```swift
NotificationCenter.addObserver(
    self,
    selector: #selector(YOUR_SELECTOR_FUNC),
    name: Notification.Name.chatbotSessionStarted,
    object: nil
)
```

- Chatbot session ended <br />

```swift
NotificationCenter.addObserver(
    self,
    selector: #selector(YOUR_SELECTOR_FUNC),
    name: Notification.Name.chatbotSessionEnded,
    object: nil
)
```

&#9745; Sending selected events from the the containing app to the chatbot. <br />

- End chatbot session <br />

```swift
NotificationCenter.default.post(
    name: Notification.Name.endChatbotSession,
    object: nil
)
```

#### Known Issues and Unsupported features

&#9744; Chatbot experience in landscope mode. <br />
&#9744; Network interruptions. <br />
&#9744; Handling app sent to background. <br />
&#9744; Handling app brought to background. <br />

#### Getting started with iOS integration

1. Get the companion code from `dx-native-clients` repo or Dialpad help pages.
2. Open or unzip the project named `dialpad-chatbot-playground` in a Xcode editor.
3. Locate the subdirectory named `DialpadChatbot`. It should contain the following two `Swift` files -

- `DCWebView.swift`
- `DCNotificationCenter.swift`

4. Copy and paste the `DialpadChatbot` directory and its contents into your app project.
5. Add your own presentation logic to launch the chatbot.

```swift
DialpadChatbot(
    url: "http://localhost:8001/public/index.html?channelid=3f3fd91bc5bf4e9ab56e53c516933337&provemail=5646620347596800@dialpad.com&site=lighthouse&env=local&native=ios"
)
```

### Android

TODO

#### Supported features in Android

&#9745; TODO. <br />

#### Known Issues and Unsupported features in Android

&#9744; TODO. <br />

#### Getting started with Android integration

1. Get the companion code from `dx-native-clients` repo or Dialpad help pages.
2. TODO
