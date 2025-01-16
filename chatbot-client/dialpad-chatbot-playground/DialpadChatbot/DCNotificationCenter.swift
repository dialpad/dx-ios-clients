import SwiftUI

/**
 * @public
 * @documentation: a subset of message bus events supported by the native iOS app.
 */
extension Notification.Name {
    //  @incoming: a chatbot session has started
    static let chatbotSessionStarted = Notification.Name("CHATBOT_SESSION_STARTED")

    //  @incoming: the chatbot session has ended, but the Vue app instance is alive
    static let chatbotSessionEnded = Notification.Name("CHATBOT_SESSION_ENDED")

    //  @outgoing: end the chatbot session, but keep the Vue app instance alive
    static let endChatbotSession = Notification.Name("END_CHATBOT_SESSION")
}
