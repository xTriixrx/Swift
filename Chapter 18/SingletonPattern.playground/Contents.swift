import Cocoa

/**
                       Adopting Design Patterns in Swift:
                            Singleton Pattern
                               Chapter 18
*/

/**
    The use of the singleton pattern is a fairly controversial subject among certain corners of the development community. One of the
    main reasons for this is that the singleton pattern is probably the most overused and misused pattern. Another reason this pattern is
    controversial is because the singleton pattern introduces a global state into an application, which provides the ability to change the
    object at any point within the application. The singleton pattern can also introduce hidden dependencies and tight compiling. My
    personal opinion is that, if the singleton pattern is used correctly, there is nothing wrong with using it. However, we do need to be
    careful not to misuse it.
    
    The singleton pattern restricts the instantiation of a class to a single instance for the lifetime of an application. This pattern is very
    effective when we need exactly one object to coordinate actions within the application. An example of a good use of a singleton is if
    the application communicates with a remote device over Bluetooth and we also want to maintain that connection throughout the
    application. Some would say that we could pass the instance of the connection class from one page to the next, which is essentially
    what a singleton is. In my opinion, the singleton pattern, in this instance, is a much cleaner solution, because with the singleton
    pattern any page that needs the connection can get it without forcing every page to maintain the instance. This also allows us to
    maintain the connection without having to reconnect each time we go to another page.
 */

/// Understanding the problem

/**

    The problem that the singleton pattern is designed to address is when we need one and only one instance of a type for the lifetime of
    the application. The singleton pattern is usually used when we need centralized management of an internal or external resource, and
    a single global point of access. Another popular use of the singleton pattern is when we want to consolidate a set of related activities
    needed throughout the application that do not maintain a state in one place.
    In Chapter 7, Classes, Structures, and Protocols, we used the singleton pattern in the text validation example because we only
    needed one instance of the text validation types throughout the lifetime of the application. In this example, we used the singleton
    pattern for the text validation types because we wanted to create a single instance of the types that could then be used by all the
    components of the application without requiring us to create new instances of the types. These text validation types did not have a
    state that could be changed. They only had methods that performed the validation on the text and constants that defined how to
    validate the text. While some may disagree with me, I believe types like these are excellent candidates for the singleton pattern
    because there is no reason to create multiple instances of these types.
 */

/// Understanding the solution

/**
    There are several ways to implement the singleton pattern in Swift. In the method that we use here, a single instance of the class is
    created the first time the class constant is accessed. We will then use the class constant to gain access to this instance throughout
    the lifetime of the application. We will also create a private initializer that will prevent external code from creating additional instances
    of the class.
 */

/// Implementing the singleton pattern

class MySingleton {
    static let sharedInstance = MySingleton()
    var number = 0
    private init() {}
}

/**
    We can see that within the MySingleton class, we create a static constant named sharedInstance, which contains an instance of
    the MySingleton class. A static constant can be called without having to instantiate the class. Since we declared the sharedInstance
    constant static, only one instance will exist throughout the lifecycle of the application, thereby creating the singleton pattern.
    We also created the private initializer, which cannot be accessed outside of the class, which will restrict other code from creating
    additional instances of the MySingleton class.
 */

var singleA = MySingleton.sharedInstance
var singleB = MySingleton.sharedInstance
var singleC = MySingleton.sharedInstance

singleB.number = 2
print(singleA.number)
print(singleB.number)
print(singleC.number)

singleC.number = 3
print(singleA.number)
print(singleB.number)
print(singleC.number)

/**
    In this example, we implemented the singleton pattern using a reference (class) type because we wanted to ensure that only one
    instance of the type existed throughout the application. If we implemented this pattern with a value type, such as a structure or an
    enumeration, we would run the risk of there being multiple instances of the type.
    If you recall, each time we pass an instance of a value type, we are actually passing a copy of that instance, which means that, if we
    implemented the singleton pattern with a value type, each time we called the sharedInstance property we would receive a new copy,
    which would effectively break the singleton pattern.
    The singleton pattern can be very useful when we need to maintain the state of an object throughout the application; however, be
    careful not to overuse it. The singleton pattern should not be used unless there is a specific requirement (requirement is the keyword
    here) for having one, and only one, instance of the class throughout the lifecycle of the application. If we are using the singleton
    pattern simply for convenience, then we are probably misusing it.
    Keep in mind that, while Apple recommends that we prefer value types to reference types, there are still plenty of examples, such as
    the singleton pattern, where we need to use reference types. When we continuously tell ourselves to prefer value types to reference
    types, it can be very easy to forget that there are times where a reference type is needed. Don't forget to use reference types with this
    pattern.
 */
