import Cocoa

/**
                               Custom Types
                                Chapter 15
*/

/**
    In most traditional object-oriented programming languages, we create classes (which are reference types) as blueprints for our
    objects. In Swift, unlike other object-oriented languages, structures have much of the same functionality as classes, however, they
    are value types. Apple has said that we should prefer value types, such as structures, to reference types, but what are the differences
    between a reference type and a value type?
 */

/// Value types and reference types

/**
    Structures are value types; when we pass instances of a structure in our app, we pass a copy of the structure not the original
    structure. Classes are reference types; therefore when we pass an instance of a class within our application, a reference to the
    original instance is also passed.
 
    When we pass structs in our app we are passing copies of the structs not the original structs. This means that the function gets
    its own copy of the structure, which it can change as needed without affecting the original instance of the structure.
 
    When we pass an instance of a class in our app we are passing a reference to the original instance. Since we're passing the
    instance of the class to the function, the function is getting a reference to the original instance; therefore any changes made
    within the function will remain once the function exits.
 
    When we pass an instance of a value type, if we are actually passing a copy of the instance, you may be wondering about
    the performance of large value types when they are passed from one part of our code to another. For structures that have
    the possibility of becoming too large, we can use copy-on-write.
 */

struct MyValueType {
    var name: String
    var assignment: String
    var grade: Int
}

class MyReferenceType {
    var name: String
    var assignment: String
    var grade: Int
    
    init(name: String, assignment: String, grade: Int) {
        self.name = name
        self.assignment = assignment
        self.grade = grade
    }
}

/**
    We need to define an initializer for the reference type but not the value type; structures provide a default initializer that will
    initalize all the properties that need to be initalized if we do not provide a default initializer.
 */

var ref = MyReferenceType(name: "Vinny", assignment: "Math Test 1", grade: 90)
var val = MyValueType(name: "Vinny", assignment: "Math Test 1", grade: 90)

func extraCreditReferenceType(ref: MyReferenceType, extraCredit: Int) {
    ref.grade += extraCredit
}

// Left side of mutating operator isn't mutable: val is a let constant
//func extraCreditValueType(val: MyValueType, extraCredit: Int) {
//    val.grade += extraCredit
//}

/**
    Each of these functions takes an instance of one of our types and an extra credit amount. Within the function, we will add the extra
    credit amount to the grade. If we try to use this code we will receive an error in the extraCreditValueType() function telling us that the
    left-side of the mutable operation is not mutable. The reason for this is that a value type parameter, by default, is immutable because
    the function is receiving an immutable copy of the parameter.
    
    Using a value type like this protects us from making accidental changes to the instances; this is because the instances are scoped to
    the function or type in which they are created. Value types also protect us from having multiple references to the same instance.
    Therefore, they are, by default, thread (concurrency) safe because each thread will have its own version of the value type. If we
    absolutely need to change an instance of a value type outside of its scope, we could use an inout parameter.
    
    We define an inout parameter by placing the inout keyword at the start of the parameter's definition. An inout parameter has a value
    that is passed into the function. This value is then modified by the function and is passed back out of the function to replace the
    original value.
 
    Let's explore how we can use an inout parameter. We will begin by creating a function that is designed to retrieve the grade for an
    assignment from a data store. However, to simplify our example, we will simply generate a random score.
 */

func getGradeForAssignment(assignment: inout MyValueType) {
    // Code to get grade from DB
    // Random code here to illustrate issue
    let num = Int(arc4random_uniform(20) + 80)
    assignment.grade = num
    print("Grade for \(assignment.name) is \(num)")
}

/**
    This function is designed to retrieve the grade for the assignment that is defined in the MyValueType instance and is then passed
    into the function. Once the grade is retrieved, we will use it to set the grade property of the MyValueType instance.
 */

var mathGrades = [MyValueType]()
var students = ["Vinny", "Carly", "Kailey", "Kara"]
var mathAssignment = MyValueType(name: "", assignment: "Math Assignment", grade: 0)

for student in students {
    mathAssignment.name = student
    getGradeForAssignment(assignment: &mathAssignment)
    mathGrades.append(mathAssignment)
}

for assignment in mathGrades {
    print("\(assignment.name): grade \(assignment.grade)")
}

/**
    There are some things we cannot do with value types that we can do with reference (or class) types.
 */

/// Recursive data types for reference types

/**
    A recursive data type is a type that contains other values of the same type as a property for the type. Recursive data types are used
    when we want to define dynamic data structures, such as lists and trees. The size of these dynamic data structures can grow or
    shrink depending on our runtime requirements. Linked lists are perfect examples of a dynamic data structure that we can implement
    using a recursive data type. A linked list is a group of nodes that are linked together and where, in its simplest form, each node
    maintains a link to the next node in the list.
    
    Each node in the list contains some value or data, and it also contains the link to the next node in the list. If one of the nodes in the list
    loses the reference to the next node, then the remainder of the list will be lost because each node is only aware of the next node.
    Some linked lists maintain a link to both the previous nodes and the following nodes to allow us to move both forward and backward
    through the list.
 */

class LinkedListReferenceType {
    var value: String
    var next: LinkedListReferenceType?
    init(value: String) {
        self.value = value
    }
}

/**
    If we try to implement this linked list as a value type, the code will be similar:
 */

// Value type 'LinkedListValueType' cannot have a stored property that recursively contains it
//struct LinkedListValueType {
//    var value: String
//    var next: LinkedListValueType?
//}

/**
    When we add this code to a playground, we receive the following error: Recursive value type LinkedListValueType is not allowed.
    This tells us that Swift does not allow recursive value types. If you think about it, recursive value types are a really bad idea because
    of how value types function. Let's examine this for a minute, because it will really stress the difference between value types and
    reference types. It will also help you to understand why we need reference types.
 
    Let's say we are able to create the LinkedListValueType structure without any errors. Now lets create 3 nodes for our list:
 
    var  one  =  LinkedListValueType(value:  "One",next:  nil)
    var  two  =  LinkedListValueType  (value:  "Two",next:  nil)
    var  three  =  LinkedListValueType  (value:  "Three",next:  nil)
 
    one.next = two
    two.next = three
 
    Do you see the problem with this code? If not, think about how a value type is passed. In the first line, one.next = two, we are
    not actually setting the next property to the original two instance; in fact, we are actually setting it to a copy
    of the two instance. This means that inthe next line, two.next = three, we are setting the next property of the original two
    instance to the three instance copy.
 */

/// Inheritance for reference types

/**
    In object-oriented programming, inheritance refers to one class (known as a sub or child class) being derived from another class
    known as a super or parent class. The subclass will inherit methods, properties, and other characteristics from the superclass.
    With inheritance, we can also create a class hierarchy where we can have multiple layers of inheritance.
 */

class Animal {
    var numberOfLegs = 0
    func sleeps() {
        print("ZZZ...")
    }
    func walking() {
        print("Walking on \(numberOfLegs) legs")
    }
    func speaking() {
        print("No sound")
    }
}

class Biped: Animal {
    override init() {
        super.init()
        numberOfLegs = 2
    }
}

class Quadruped: Animal {
    override init() {
        super.init()
        numberOfLegs = 4
    }
}

class Dog: Quadruped {
    override func speaking() {
        print("Barking")
    }
}

/**
    Class hierarchies can get very complex. However, as you just saw, they can eliminate a lot of duplicate code because our
    subclasses inherit methods, properties, and other characteristics from their superclasses. Therefore, we do not need to recreate
    them in all of the subclasses. The biggest drawback of a class hierarchy is the complexity. When we have a complex hierarchy,
    it is easy to make a change and not realize how it is going to affect all of the subclasses. If you consider the dog and cat classes,
    for example, we may want to add a furColor property to our Quadruped class so that we can set the color of the animal's fur.
    However, horses do not have fur; they have hair. So, before we can make any changes to a class in our hierarchy, we need to
    understand how it will affect all the subclasses in the hierarchy.
 
    In Swift, it is best to avoid using complex class hierarchies (as shown in this example), and instead use a protocol-oriented design,
    unless, of course, there are specific reasons to use them.
 */

/// Dynamic dispatch

/**

    In the previous section, we learned how to use inheritance with classes in order to inherit and override the functionality defined in a
    super class. You may be wondering how and when the appropriate implementation is chosen. The process of choosing which
    implementation to call is performed at runtime and is known as dynamic dispatch.
    
    One of the key points to understand from the last paragraph is that the implementation is chosen at runtime. What this means is
    that a certain amount of runtime overhead is associated with using class inheritance, as shown in the Inheritance for reference
    types section. For most applications, this overhead is not a concern; however, for performance-sensitive applications such as
    games this overhead can be costly.
    
    One of the ways that we can reduce the overhead associated with dynamic dispatch is to use the final keyword. The final keyword
    puts a restriction on the class, method, or function to indicate that it cannot be overridden, in the case of a method or function, or
    subclasses, in the case of a class.
 */

/// final func myFunc() {}
/// final var myProperty = 0
/// final class MyClass {}

/**
    This change allows the application, at runtime, to make a direct call to the walking() method rather than an indirect call that gives the
    application a slight performance increase. If you must use a class hierarchy, it is good practice to use the final keyword wherever
    possible; however, it is better to use a protocol- oriented design, with value types to avoid this.
 */

/// Copy-on-write

/**
    Normally, when we pass an instance of a value type, such as a structure, a new copy of the instance is created. This means that if we
    have a large data structure that contains 100,000 elements, then every time we pass that instance we will have to copy all 100,000
    elements. This can have a detrimental impact on the performance of our applications, especially if we pass the instance to numerous
    functions. To solve this issue, Apple has implemented the copy-on-write feature for all the data structures (such as Array, Dictionary,
    and Set) in the Swift standard library. With copy-on-write, Swift does not make a second copy of the data structure until a change is
    made to that data structure. Therefore, if we pass an array of 50,000 elements to another part of our code, and that code does not
    make any changes to the array, we will avoid the runtime overhead of copying all the elements. This is a very useful feature and can
    greatly increase the performance of our applications. However, our custom value types do not automatically get this feature by
    default. In this section, we will explore how we can use reference types and value types together to implement the copy-on-write
    feature for our custom value types. To do this, we will create a very basic queue type.
 */

/**
    We use the fileprivate access level to prevent the use of this type outside of the defining source file, because it should only be
    used to implement the copy-on-write feature for our main queue type. We now need to add a couple of extra items to the
    BackendQueue type so that we can use it to implement the copy-on-write feature for the main queue type. The first thing that we
    will add is a public default initializer and a private initializer that can be used to create a new instance of the BackendQueue type.
 
    The public initializer will be used to create an instance of the BackendQueue type without any items in the queue. The private
    initializer will be used internally to create a copy of itself that contains any items that are currently in the queue. Now we will need to
    create a method that will use the private initializer to create a copy of itself when required.
 
    It could be very easy to make the private initializer public and then let the main queue type call that initializer to create the copy;
    however, it is good practice to keep the logic needed to create the new copy within the type itself. The reason why you should do this
    is because if you need to make changes to the type, that may affect how the type is copied. Instead, the logic that you need to change
    the type is embedded within the type itself and is easy to find. Additionally, if you use the BackendQueue type as the backend storage
    for multiple types, you will only need to make the changes to the copy logic in one place if it changes.
 */

fileprivate class BackendQueue<T> {
    private var items = [T]()
    
    public init() {}
    private init(_ items: [T]) {
        self.items = items
    }
    public func addItem(item: T) {
        items.append(item)
    }
    
    public func getItem() -> T? {
        if items.count > 0 {
            return items.remove(at: 0)
        }
        else {
            return nil
        }
    }
    
    public func count() -> Int {
        return items.count
    }
    
    public func copy() -> BackendQueue<T> {
        return BackendQueue<T>(items)
    }
}

/**
    Now let's create our Queue type, which will use the BackendQueue type to implement the copy-on-write feature:
    
    The Queue type is implemented as a value type. This type has one private property of the BackendQueue type, which will be
    used to store the data. This type contains three methods to add items to the queue, retrieve an item from the queue, and to
    return the number of items in the queue. Now let's explore how we can add the copy-on-write feature to the Queue type.
 
    Swift has a global function named isKnownUniquelyReferenced(). This function will return true if there is only one reference
    to an instance of a reference type, or false if there is more than one reference. We will begin by adding a function to check
    whether there is a unique reference to the internalQueue instance. This will be a private function named
    checkUniquelyReferencedInternalQueue.
 
    In this method, we check to see whether there are multiple references to the internalQueue instances. If there are multiple
    references, then we know that we have multiple copies of the Queue instance and, therefore, we can create a new copy.
 

    The Queue type itself is a value type; therefore, when we pass an instance of the Queue type within our code, the code that we
    pass the instance to receives a new copy of that instance. The BackendQueue type, which the Queue type is using, is a
    reference type. Therefore, when a copy is made of a Queue instance, then that new copy receives a reference to the original
    Queue's BackendQueue instance and not a new copy. This means that each instance of the Queue type has a reference to the
    same internalQueue instance. Consider the following code as an example; both queue1 and queue2 have references to the
    same internalQueue instance:
 
    var queue1 = Queue()
    var queue2 = queue1
 
    In the Queue type we know that both the addItem() and getItem() methods change the internalQueue instance. Therefore, before
    we make these changes we will want to call the checkUniquelyReferencedInternalQueue() method to create a new copy of
    the internalQueue instance.
 
    With this code, when either the addItem() or getItem() methods are called - which will change the data in the internalQueue
    instance - we use the checkUniquelyReferencedInternalQueue() method to create a new instance of the data structure.
    Let's add one additional method to the Queue type, which will allow us to see whether there is a unique reference to the
    internalQueue instance or not.
 
    
 */

struct Queue {
    private var internalQueue = BackendQueue<Int>()
    
    private mutating func checkUniquelyReferencedInternalQueue() {
        if !isKnownUniquelyReferenced(&internalQueue) {
            internalQueue = internalQueue.copy()
            print("Making a copy of internalQueue")
        }
        else {
            print("Not making a copy of internalQueue")
        }
    }
    
    public mutating func addItem(item: Int) {
        checkUniquelyReferencedInternalQueue()
        internalQueue.addItem(item: item)
    }
    public mutating func getItem() -> Int? {
        checkUniquelyReferencedInternalQueue()
        return internalQueue.getItem()
    }
    public func count() -> Int {
        return internalQueue.count()
    }
    mutating public func uniquelyReferenced() -> Bool {
        return isKnownUniquelyReferenced(&internalQueue)
    }
}

/**
    Now let's examine how the copy-on-write functionality works with the Queue type:
 */

var queue = Queue()
queue.addItem(item: 1)
print(queue.uniquelyReferenced())

/**
 When we add the item to the queue, the following messages will be printed to the console. This tells us that within the
    checkUniquelyReferencedInternalQueue() method, it was determined that there was only one reference to the internalQueue
    instance. We can verify this by printing the results of the uniquelyReference() method to the console.
 */

var queue1 = queue
print(queue.uniquelyReferenced())
print(queue1.uniquelyReferenced())

/**
    This code will print two false messages to the console, letting us know that neither instance has a unique reference to their
    internalQueue instances. Now let's add an item to either one of the queues.
 */
queue.addItem(item: 2)

/**
    When we add the item to the queue, we will see the following message printed to the console: Making a copy of internalQueue.
    This message tells us that when we add the new item to the queue, a new copy of the internalQueue instance is created. In order
    to verify this, we can print the results of the uniquelyReferenced() methods to the console again. If you do check this, you will see
    two true messages printed to the console this time rather than two false methods. We can now add additional items to the queues
    and we will see that we are not creating new instances of the internalQueue instance because each instance of the Queue type
    now has its own copy.
 
    If you are planning on creating your own data structure that may contain a large number of items, it is recommended that you
    implement it with the copy-on-write feature as described here.
 
    If you are comparing your custom types, it is also recommended that you implement the equatable protocol within these custom
    types. This will enable you to compare two instances of the type using the equal to (==) and not equal to (!=) operators.
 */

/// Implementing the equatable protocol

/**
    In this section, we will demonstrate how we can conform to the Equatable protocol using extensions. When a type conforms to the
    Equatable protocol, we can use the equal-to (==) operator to compare for equality and the not-equal-to (!=) operator to compare for
    inequality. If you will be comparing instances of a custom type, then it is a good idea to have that type conform to the Equatable
    protocol because it makes comparing instances very easy.
 */

struct Place {
    let id: String
    let latitude: Double
    let longitude: Double
}

/**
    To implement the Equatable protocol, we can create a global function, however, that is not the recommended solution for
    protocol-oriented programming. We could also add a static function to the Place type itself, but sometimes it is better to pull the
    functionality needed to conform to a protocol out of the implementation itself. The following code will make the Place type conform to
    the Equatable protocol:
 */

extension Place: Equatable {
    static func ==(lhs: Place, rhs: Place) -> Bool {
        return lhs.id == rhs.id &&
            lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
}

var placeOne = Place(id: "Fenway Park", latitude: 42.3467, longitude: -71.0972)
var placeTwo = Place(id: "Wrigley Field", latitude: 41.9484, longitude: -87.6553)
print(placeOne == placeTwo)

/**
    You may be wondering why we said that it may be better to pull the functionality needed to conform to a protocol out of the
    implementation itself. Well, think about some of the larger types that you have created in the past. Personally speaking, I have seen
    types that had several hundred lines of code and conformed to numerous protocols. By pulling the code that is needed to conform to
    a protocol out of the type's implementation and putting it in its own extension, we are making our code much easier to read and
    maintain in the future because the implementation code is isolated in its own extension.
 */
