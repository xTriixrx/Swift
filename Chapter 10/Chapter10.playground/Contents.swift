import Cocoa

/**
                                 Generics
                                Chapter 10
*/

/**
    The concept of generics has been around for a while, so it should not be a new concept to developers coming from languages such
    as Java or C#. The Swift implementation of generics is very similar to these languages.
    Generics allow us to write very flexible and reusable code that avoids duplication. With a type-safe language, such as Swift, we often
    need to write functions, classes, and structures that are valid for multiple types. Without generics, we would need to write separate
    functions for each type we wish to support; however with generics, we can write one generic function to provide the functionality for
    multiple types. Generics allow us to tella  function or type I know Swift is type-safe, but I do not know the type that will be needed yet.
    I will give you a placeholder for now and will let you know what type to enforce later.
    
    In Swift, we hae the ability to define both generic functions and generic types.
 */

/**
    A common problem where generics apply is a swapping problem, instead of making multiple separate swapping functions for
    each type, the function can be generalized into a single generic function:
 */

func swapGeneric<T>(a: inout T, b: inout T) {
    let tmp = a
    a = b
    b = tmp
}

/**
    The capital T is a placeholder type, and tells Swift that we will be defining the type later. To define a generic function, we include
    the placeholder type between two angular brackets (<T>) after the functions name. We can then use the placeholder type in
    place of any type definition within the parameter definitions, the return type, or the function itself. The big thing to keep in mind is that
    once the placeholder is defined as a type, all the other placeholders assume that type. Therefore, any variable or constant defined
    with that placeholder must conform to that type.
    
    There is nothing special about the capital T; we could use any valid identifier in place of T. We can also use descriptive names, such
    as key and value, as the Swift languages does with dictionaries:
 */

func swapGeneric1<G>(a: inout G, b: inout G) { }
func swapGeneric2<xyz>(a: inout xyz, b: inout xyz) { }

/**
    In most documentation, generic  placeholders are defined with either T for type, or E for element. The key is to be consistent. If
    we need to use multiple generic types, we can create multiple placeholders by separating them with commas. The following example
    shows how to define multiple placeholders for a single function:
 */

func testGeneric<T,E>(a: T, b: E) {
    print("\(a)\(b)")
}


var a = 5
var b = 10
swapGeneric(a: &a, b: &b)
print("a:\(a) b:\(b)")

var c = "My String 1"
var d = "My String 2"
swapGeneric(a: &c, b: &d)
print("c:\(c) d:\(d)")

/// The following code will result in an error:
var a1 = 5
var c1 = "My String 1"
//swapGeneric(a: &a1, b: &c1)

/**
    Lets look at testGeneric: This function would accept parameters of different types; however since they are of different types, we
    would not unable to swap the values because they are different. There are also other limitations to generics. For example, we may
    think the following generic function would be valid however we would recieve an error:
 */

func genericEqual<T>(a: T, b: T) -> Bool {
   // return a == b
    return true
}

/**
    The error is due to the fact that == cannot be applied to two T operands. Since the type of the arguments is unknown at the time the
    code is compiled, Swift does not know whether it is able to use the equal operator on the types, and therefore an error is thrown.
    We might think that this is a limit that will make generics hard to use; however, we have a way to tell Swift that we expect the type
    represented by the placeholder, will have a certain functionality. This is done with type constraints.
 
    A type constraint specifies that a generic type must inherit from a specific class or conform to a particular protocol. This allows us to
    use the methods or properties defined by the parent class or protocol within the generic function.
 */

func testGenericComparable<T: Comparable>(a: T, b: T) -> Bool {
    return a == b
}

/**
    To specify the type constraint, we put the class or protocol constraint after the generic placeholder, where the generic placeholder
    and constraint are separated by a colon. We can declare multiple constraint just like we declare multiple generic types.
 */

func testFunction<T: NSButton, E: Comparable>(a: T, b: E) {
    /// T must inherit from NSButton class, and E must conform to Comparable protocol.
}

/// Generic type

/**
    A generic type is a class, structure, or enumeration, that can work with any type, just like the weay Swift arrays and dictionaries work.
    As we recall, Swift arrays and dictionaries are written so that they can contain any type. The catch is that we cannot mix and match
    different types within an array or dictionary. When we create an instance of our generic type, we define the type that the instance
    will work with. After we define that type, we cannot change the type for that instance.
    To demonstrate, we will create a simple List class. This class will use a Swift array as the backend storage for the list, and will
    let us add items to the list or retrieve values from the list.
 */

class List<T> {
    
}

/**
    To create an instance of this type, we would need to define the type of items that our list will hold:
 */
var stringList = List<String>()
var intList = List<Int>()
var customList = List<NSButton>()

/**
    We can also define structures and enumerations as generics:
 */

struct GenericStruct<T> { }
enum GenericEnum<T> { }

/**
    Now lets add the backend storage to our list class and other functions to our list class:
 */

class List1<T> {
    var items = [T]()
    
    func add(item: T) {
        items.append(item)
    }
    
    func getItemAtIndex(index: Int) -> T? {
        if items.count > index {
            return items[index]
        } else {
            return nil
        }
    }
}

var list = List1<String>()
list.add(item: "Hello")
list.add(item: "World")
print(list.getItemAtIndex(index: 1))

/**
    We can also define our generic types with multiple placeholder types:
 */
class MyClass<T,E> {
    
}

var mc = MyClass<String, Int>()

/**
    We can also use type constraints with generic types:
 */

class MyClass1<T: Comparable>{}

/**
    We can add extensions to a generic type conditionally if the type conforms to a protocol. For example, if we want to add a sum()
    method to our generic List type only if the type for T conforms to the numeric protocol, we could do this as follows:
 */

extension List1 where T: Numeric {
    func sum () -> T {
        return items.reduce(0, +)
    }
}

/**
    This extension  will add the sum() method to any List instance where the T type conforms to the numeric protocol.
 */
var list2 =  List1<Int>()
list2.add(item: 2)
list2.add(item: 4)
list2.add(item: 6)
print(list2.sum())

/**
    Conditional conformance allows a generic type to conform to a protocol ony if the type meets certain conditions. For example, if
    we want our List type to conform to the equitable protocol only if the type stored in the list also conformed to the equitable protocol:
 */

//extension List1: Equatable where T: Equatable {
//   static func ==(l1: List1, l2: List1) -> Bool {
//       if l1.items.count != l2.items.count {
//           return false
//       }
//       for(e1, e2) in zip(l1.items, l2.items) {
//            if e1 != e2 {
//               return false
//           }
//       }
//       return true
//   }
//}

/**
    This code will add conformance to the Equitable protocol to any instance of the List type where the type that is stored in the list
    also conforms to the Equitable protocol.
 
    Note: Zip() is a function that will loop through two sequences, in our case arrays, simultaneously and create pairs (e1 and e2) that
    we can compare.
 */

/**
    Prior to Swift 4, if we wanted to use generics with a subscript, we had to define the subscript at the class or structure level. This
    forced us to make generic methods when it felt like we should be using subscripts. Starting with Swift 4, we can create generic
    subscripts, where either the subscript's return type or its parameters may be generic. In the first example, we will create a subscript
    that will accept one generic parameter:
 */
extension List1 {
    subscript<T: Hashable>(item: T) -> Int {
        return item.hashValue
    }
}
/**
    When we create a generic subscript, we define the placeholder type after the subscript keyword. We can also use generics for the
    return type of a subscript:
 */
extension List1 {
    subscript<T>(key: Int) -> T? {
        //return items[key] as? T
        return items as? T
    }
}

/**
    An associated type declares a placeholder name that can be used instead of a type within a protocol. The actual type to be used
    is not specified until the protocol is adopted. When creating generic functions and types, we use a very similar syntax. Defining
    associated types for a protocol, however is very different. We specify an associated type using the associatedtype keyword.
 
    Let's see how to use associated types when we define a protocol. In this example, we will define the QueueProtocol protocol, which
    defines the capabilities that need to be implemented by the queue that implements it:

 */

protocol QueueProtocol {
    associatedtype QueueType
    mutating func add(item: QueueType)
    mutating func getItem() -> QueueType?
    func count() -> Int
}

/**
    In this protocol, we defined one associated type, named QueueType. We then used this associated type twice within the protocol:
    once as a parameter and once when defining an optional return type. Any type that implements the QueueProtocol must be able
    to specify the type to use for the QueueType placeholder, and must also ensure that only items of that type are used where the
    protocol uses the QueueType placeholder.
 
    IntQueue will implement QueueProtocol using the Integer type:
 */

class IntQueue: QueueProtocol {
    var items = [Int]()
    func add(item: Int) {
        items.append(item)
    }
    func getItem() -> Int? {
        return items.count > 0 ? items.remove(at: 0) : nil
    }
    func count() -> Int {
        return items.count
    }
}

/**
    In the IntQueue class, we begin by defining our backend storage mechanism as an array of integer types. We then implement each
    of the methods defined in the QueueProtocol, replacing the QueueType placeholder defined in the protocol with the Integer type.
 */

var intQ = IntQueue()
intQ.add(item: 2)
intQ.add(item: 4)
print(intQ.getItem()!)
intQ.add(item: 6)

/**
    We can also implement QueueProtocol with a generic type:
 */

class GenericQueue<T>: QueueProtocol {
    var items = [T]()
    func add(item: T) {
        items.append(item)
    }
    func getItem() -> T? {
        return items.count > 0 ? items.remove(at: 0) : nil
    }
    func count() -> Int {
        return items.count
    }
}

var intQ2 = GenericQueue<Int>()
intQ2.add(item: 2)
intQ2.add(item: 4)
print(intQ2.getItem()!)
intQ2.add(item: 6)

/**
    We can also use type constraints with associated types. When the protocol is adapted, the type defined for the associated type
    must inherit from the class or confrom to the protocol defined by the type constraint. The following line defines and associated
    type with a type constraint:
 
    associatedtype QueueType: Hashable
 */
