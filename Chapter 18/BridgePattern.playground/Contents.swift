import Cocoa

/**
                       Adopting Design Patterns in Swift:
                              Bridge Pattern
                               Chapter 18
*/

/**
    The bridge pattern decouples the abstraction from the implementation so that they can both vary independently. The bridge pattern
    can also be thought of as a two-layer abstraction.
 */

/// Understanding the problem

/**
    The bridge pattern is designed to solve a couple of problems, but the one we are going to focus on here tends to arise over time as
    new requirements come in with new features. At some point as these come in, we will need to change how the features interact.
    Eventually this will require us to refactor the code.
    In object-oriented programming, this is known as an exploding class hierarchy, but it can also happen in protocol-oriented
    programming.
 */

/// Understanding the solution

/**
    The bridge pattern solves this problem by taking the interacting features and separating the functionality that is specific to each
    feature from the functionality that is shared between them. A bridge type can then be created, which will encapsulate the shared
    functionality, bringing them together.
 */

/// Implementing the bridge pattern

/**
    To demonstrate how we would use the bridge pattern, we will create two features. The first feature is a message feature that will store
    and prepare a message that we wish to send out. The second feature is the sender feature that will send the message through a
    specific channel, such as email or SMS messaging.
    Let's start off by creating two protocols named Message and Sender. The Message protocol will define the requirements for types that
    are used to create messages. The Sender protocol will be used to define the requirements for types that are used to send the
    messages through the specific channels. The following code shows how we define these two protocols:
 */

protocol Message {
    var messageString: String { get set }
    init(messageString: String)
    func prepareMessage()
}
protocol Sender {
    func sendMessage(message: Message)
}

/**
    The Message protocol defines a single property named messageString of the String type. This property will contain the text of the
    message and cannot be nil. We also define one initiator and a method named prepareMessage(). The initializer will be used to set the
    messageString property and anything else required by the message type. The prepareMessage() method will be used to prepare the
    message prior to sending it. This method can be used to encrypt the message, add formatting, or do anything else to the message
    prior to sending it.
    The Sender protocol defines a method named sendMessage(). This method will send the message through the channel defined by
    conforming types. In this function, we will need to ensure that the prepareMessage() method from the message type is called prior to
    sending the message.
 */

class PlainTextMessage: Message {
    var messageString: String
    required init(messageString: String) {
        self.messageString = messageString
    }
    func prepareMessage() {
         //Nothing to do
    }
}
class DESEncryptedMessage: Message {
    var messageString: String
    required init(messageString: String) {
        self.messageString = messageString
    }
    func prepareMessage() {
        // Encrypt message here
        self.messageString = "DES: " + self.messageString
    }
}

/**
    Each of these types contains the required functionality to conform to the Message protocol. The only real difference between these
    types is in the prepareMessage() methods. In the PlainTextMessage class, the prepareMessage() method is empty because we do
    not need to do anything to the message prior to sending it. The prepareMessage() method of the DESEncryptionMessage class
    would normally contain the logic to encrypt the message, but for the example we will just prepend a DES tag to the beginning of the
    message, letting us know that this method was called.
    Now let's create two types that will conform to the Sender protocol. These types would typically handle sending the message
    through a specific channel; however, in the example, we will simply print a message to the console:
 */

class EmailSender: Sender {
    func sendMessage(message: Message) {
        print("Sending through E-Mail:")
        print("\(message.messageString)")
    }
}
class SMSSender: Sender {
    func sendMessage(message: Message) {
        print("Sending through SMS:")
        print("\(message.messageString)")
    }
}

/**
    Both the EmailSender and the SMSSender types conform to the Sender protocol by implementing the sendMessage() function.
    We can now use these two features, as shown in the following code:
 */

var myMessage = PlainTextMessage(messageString: "Plain Text Message")
myMessage.prepareMessage()
var sender = SMSSender()
sender.sendMessage(message: myMessage)

/**
    This will work well, and we could add code similar to this anywhere we need to create and send a message. Now let's say that, one
    day in the near future, we get a requirement to add a new functionality to verify the message prior to sending it to make sure it meets
    the requirements of the channel we are sending the message through. To do this, we would start off by changing the Sender protocol
    to add the verify functionality.
    The new sender protocol would look as follows:
 */

//protocol Sender {
//    var message: Message? { get set }
//    func sendMessage()
//    func verifyMessage()
//}

/**
    To the Sender protocol, we added a method named verifyMessage() and added a property named message. We also changed the
    definition of the sendMessage() method. The original Sender protocol was designed to simply send the message, but now we need to
    verify the message prior to calling the sendMessage() function; therefore, we couldn't simply pass the message to it, as we did in the
    previous definition.
    Now we will need to change the types that conform to the Sender protocol to make them conform to this new protocol. The following
    code shows how we would make these changes:
 */

//class EmailSender: Sender {
//    var message: Message?
//    func sendMessage() {
//        print("Sending through E-Mail:")
//        print("\(message!.messageString)")
//    }
//    func verifyMessage() {
//        print("Verifying E-Mail message")
//    }
//}
//class SMSSender: Sender {
//    var message: Message?
//    func sendMessage() {
//        print("Sending through SMS:")
//        print("\(message!.messageString)")
//    }
//   func verifyMessage() {
//        print("Verifying SMS message")
//    }
//}

/**
    With the changes that we made to the types that conform to the Sender protocol, we will need to change how the code uses these
    types. The following example shows how we can now use them:
 */

//var myMessage = PlainTextMessage(messageString: "Plain Text Message") myMessage.prepareMessage()
//var sender = SMSSender() sender.message = myMessage
//sender.verifyMessage() sender.sendMessage()

/**
    These changes are not that hard to make; however, without the bridge pattern, we would need to refactor the entire code base and
    make the change everywhere that we are sending messages. The bridge pattern tells us that when we have two hierarchies that
    closely interact together like this, we should put this interaction logic into a bridge type that will encapsulate the logic in one spot. This
    way, when we receive new requirements or enhancements, we can make the change in one spot, thereby limiting the refactoring that
    we must do. We could make a bridge type for the message and sender hierarchies, as shown in the following example:
 */

//struct MessagingBridge {
//    static func sendMessage(message: Message, sender: Sender) {
//        var sender = sender
//        message.prepareMessage()
//        sender.message = message
//        sender.verifyMessage()
//        sender.sendMessage()
//    }
//}

/**
    The logic of how the messaging and sender hierarchies interact is now encapsulated into the MessagingBridge structure. Now, when
    the logic needs to change we only need to make the change to this one structure rather than having to refactor the entire code base.
    The bridge pattern is a very good pattern to remember and use. There have been (and still are) times that I have regretted not using
    the bridge pattern in my code because, as we all know, requirements change frequently, and being able to make the changes in one
    spot rather than throughout the code base can save us a lot of time in the future.
 */
