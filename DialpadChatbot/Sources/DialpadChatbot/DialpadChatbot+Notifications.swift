import NotificationCenter

/**
 * @public
 * @documentation: a subset of Message Bus events supported by the native iOS app.
 *  supported events are:
 *  - incoming event CHATBOT_SESSION_STARTED
 *  - incoming event CHATBOT_SESSION_ENDED
 *  - outgoing event END_CHATBOT_SESSION
 */
extension Notification.Name {
    //  @incoming: a chatbot session has started
    public static let chatbotSessionStarted = Notification.Name("CHATBOT_SESSION_STARTED")
    
    //  @incoming: the chatbot session has ended, but the Vue app instance is alive
    public static let chatbotSessionEnded = Notification.Name("CHATBOT_SESSION_ENDED")
    
    //  @outgoing: end the chatbot session, but keep the Vue app instance alive
    public static let endChatbotSession = Notification.Name("END_CHATBOT_SESSION")
}
