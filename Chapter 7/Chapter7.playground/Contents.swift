import Cocoa

/**
                       Classes, Structures, and Protocols
                                Chapter 7
*/

/**
    In Swift, classes and structures are very similar. If we really want to master Swift, it is very important to not only understand what
    makes classes and structures so similar, but to also understand what sets them apart, because they are the building blocks of our
    applications.
    Apple describes them as follows:
    Classes and structures are general-purpose, flexible constructs that become the building blocks of your program's code. You define
    properties and methods to add functionality to your classes and structures by using the already familiar syntax of constants, variables
    and functions.
 */

///         Similarities between Classes and Structures

/**
    Properties: These are used to store information in our classes and structures
    Methods: These provide functionality for our classes and structures
    Initalizers: These are used when initalizing instances of our classes and structures
    Subscripts: These provide access to values using the subscript syntax
    Extensions: These help extend both classes and structures
 */

///         Differences between Classes and Structures

/**
    Type: A structure is a value type, while a class is a reference type
    Inheritance: A structure cannot inherit from other types, while a class can
    Deinitalizers: Structures cannot have custom deinitializers, while a class can
 */

///         Value versus Reference types

/**
    Structures are value types. When we pass instances of a structure within our application, we pass a copy of the structure and not
    the original structure. Classes are reference types; therefore, when we pass an instance of a class within our application, a reference
    to the original instance is passed. When we pass structures within our application, we are passing copies of the structures and not
    the original structures. Since the function gets its own copy of the structure, it can change it as needed without affecting the original
    instance of the structure. When we pass an instance of a class within our application, any changes made within the function will
    remain once the function exits.
 */

//// class MyClass {
    
////  }

//// s truct MyStruct {
    
////  }

/**
    There are two types of properties: stored and computed properties. Stored properties will store variables or constant values as part
    of an instance of a class or structure. Stored properties can also have property observers that can monitor the property for changes
    and respond with custom actions when the value of the property changes. Computed properties do not store a value themselves but
    instead retrieve and possibly set other properties. The value returned by a computed property can also be calculated when it is
    requested.
 */

struct MyStruct {
    let c = 5
    var v = ""
}

class MyClass {
    let c = 5
    var v = ""
}

/**
    The following code creates an instance of the structure MyStruct and the class MyClass
 */

var myStruct = MyStruct()
var myClass = MyClass()

/**
    One of the differences between structures and classes is that, by default, a structure creates an initalizer that lets us populate
    the stored properties when we create an instance of the structure.
 */

var myStruct1 = MyStruct(v: "Hello")

/**
    In the preceding example, the initializer is used to set the v variable, adn the c constant will contain the number 5. If we did not
    give the constant an initial value, as shown in the following example, the default initalier would be used to set the constant as well:
 */

/// myStruct = MyStruct(c: 10 v: "Hello")

/**
    This allows us to define a constant where we set the value when we initialize the class or structure at runtime, rather than
    hardcoding the value of the constant within the type. The order in which the paraemters appear in the initalizer is the order
    in which they are defined. To set or read a stored property, we use the standard dot syntax:
 */
var x = myClass.c
myClass.v = "Howdy"


class EmployeeClass {
    var firstName = ""
    var lastName = ""
    var salaryYear = 0.0
}

struct EmployeeStruct {
    var firstName = ""
    var lastName = ""
    var salaryYear = 0.0
}

/**
    Within the structure and class, we can access these properties by using the name of the property and the self keyword. Every
    instance of a structure or class has a property named self. This property refers to the instance itself; therefore, we can use it
    to access the properties within the instance.
    self.firstName
    self.lastName
 */

/**
    Computed properties are properties that do not have a backend variable, which are used to store the values associated with
    the property. The values of a computed property are usually computed when code requests it. You can think of a computed
    property as a function disguised as a property. Let's look at a read-only computed property:
 */

////    var salaryWeek: Double {
////        get {
////            return self.salaryYear/52
////        }
////    }

/**
    To create a read-only computed property, we begin by defining it as if it were a normal variable with the var keyword, followed
    by the varaible name, colon, and the variable type. Next we add a curly bracket at the end of the declaration and then define
    a getter method, which is called when the value of our computed property is requested. In this example, the getter method divides
    the current value of the salaryYear property by 52 to get the employee's weekly salary. We can simplify the definition of the
    read-only computed property by removing the get keyword:
 */

//// var salaryWeek: Double {
////     return self.salaryYear/52
//// }

/**
    Computed properties are not limited to being read-only; we can also write to them. To enable the salaryWeek property to be
    writeable, we will add a setter method that will set the salaryYear property, based on the value being passed into the salaryWeek
    property:
 */

//// var salaryWeek: Double {
////     get {
////         return self.salaryYear/52
////     }
////     set(newSalaryWeek) {
////         self.salaryYear = newSalaryWeek*52
////     }
//// }

/**
    We can simplify the setter definition by not defining a name for the new value. In this case, the value will be assigned to a default
    variable named newValue, as shown:
 */

//// var salaryWeek: Double {
////     get {
////         return self.salaryYear/52
////     }
////     set {
////         self.salaryYear = newValue*52
////     }
//// }

class EmployeeClass1 {
    var firstName = ""
    var lastName = ""
    var salaryYear = 0.0
    
    var salaryWeek: Double {
        get {
            return salaryYear/52
        }
        set {
            salaryYear = newValue*52
        }
    }
}

struct EmployeeStruct1 {
    var firstName = ""
    var lastName = ""
    var salaryYear = 0.0
    
    var salaryWeek: Double {
        get {
            return salaryYear/52
        }
        set {
            salaryYear = newValue*52
        }
    }
}

/**
    As we can see, the class and structure definitions are the same so far, except for the initial class or struct keywords. We read and
    write to a computed property exactly as we would to a stored property. Code that is external to the class or structure should not
    be aware that the property is a computed property:
 */

var f1 = EmployeeStruct1(firstName: "Vinny", lastName: "Nigro", salaryYear: 39_000)
print(f1.salaryWeek) // prints 750.00 to the console
f1.salaryWeek = 1000
print(f1.salaryWeek) // prints 1000.00 to the console
print(f1.salaryYear) // prints 52000.00 to the console

/**
    Property obervers are called every time the value of the property is set. We can add property observers to any non-lazy stored
    property. We can also add property observers to any inherited stored or computed property by overriding the property in the subclass,
    which we will look at the Overriding properties section. There are two property observers that we can set in Swift: willSet and didSet.
    The willSet observer is called right before the property is set, and the didSet observer is called right after the property is set. One thing
    to note about property observers is that they are not called when the value is set during initialization.
 */

class EmployeeClass2 {
    var firstName = ""
    var lastName = ""
    var salaryYear: Double = 0.0 {
        willSet(newSalary) {
            print("About to set salaryYear to \(newSalary)")
        }
        didSet {
            if salaryWeek > oldValue {
                print("\(firstName) got a raise.")
            } else {
                print("\(firstName) did not get a raise.")
            }
        }
    }
    
    var salaryWeek: Double {
        get {
            return salaryYear/52
        }
        set {
            salaryYear = newValue*52
        }
    }
}

struct EmployeeStruct2 {
    var firstName = ""
    var lastName = ""
    var salaryYear: Double = 0.0 {
        willSet(newSalary) {
            print("About to set salaryYear to \(newSalary)")
        }
        didSet {
            if salaryWeek > oldValue {
                print("\(firstName) got a raise.")
            } else {
                print("\(firstName) did not get a raise.")
            }
        }
    }
    
    var salaryWeek: Double {
        get {
            return salaryYear/52
        }
        set {
            salaryYear = newValue*52
        }
    }
}

/**
    When we add a property observer to a stored property, we need to include the type of the value being stored within the definition
    of the property.
 */

/**
    Everything that was learned previously about functions will apply to methods, methods are just functions that are associated
    with an instance of a class or structure. To access a method, we use the same dot syntax we used to access properties.
 */

class EmployeeClass3 {
    var firstName = ""
    var lastName = ""
    var salaryYear: Double = 0.0 {
        willSet(newSalary) {
            print("About to set salaryYear to \(newSalary)")
        }
        didSet {
            if salaryWeek > oldValue {
                print("\(firstName) got a raise.")
            } else {
                print("\(firstName) did not get a raise.")
            }
        }
    }
    
    var salaryWeek: Double {
        get {
            return salaryYear/52
        }
        set {
            salaryYear = newValue*52
        }
    }
    
    func getFullName() -> String {
        return firstName + " " + lastName
    }
}

struct EmployeeStruct3 {
    var firstName = ""
    var lastName = ""
    var salaryYear: Double = 0.0 {
        willSet(newSalary) {
            print("About to set salaryYear to \(newSalary)")
        }
        didSet {
            if salaryWeek > oldValue {
                print("\(firstName) got a raise.")
            } else {
                print("\(firstName) did not get a raise.")
            }
        }
    }
    
    var salaryWeek: Double {
        get {
            return salaryYear/52
        }
        set {
            salaryYear = newValue*52
        }
    }
    
    func getFullName() -> String {
        return firstName + " " + lastName
    }
}


var e = EmployeeClass3()
var f = EmployeeStruct3(firstName: "Vinny", lastName: "Nigro", salaryYear: 50000)

e.firstName = "Vinny"
e.lastName = "Nigro"
e.salaryYear =  50000.00

print(e.getFullName())
print(f.getFullName())

/**
    This example shows how to show read-only information from a class and structure and how the definitions do not differ, however
    there is a difference in how we define methods for classes and structures that need to update property values.
    If we were to copy and past the giveRaise function from the class employee definition in the following definitions and paste it into
    the structure employee definition, we would recieve a syntax error saying that the left side of mutating operator is not mutable: self
    is mutable. By default, we are not allowed to update property values within a method of a structure. If we want to modify a property
    we can mutate the behavior for that method by adding the mutating keyword before the func keyword.
 */

class EmployeeClass4 {
    var firstName = ""
    var lastName = ""
    var salaryYear: Double = 0.0 {
        willSet(newSalary) {
            print("About to set salaryYear to \(newSalary)")
        }
        didSet {
            if salaryWeek > oldValue {
                print("\(firstName) got a raise.")
            } else {
                print("\(firstName) did not get a raise.")
            }
        }
    }
    
    var salaryWeek: Double {
        get {
            return salaryYear/52
        }
        set {
            salaryYear = newValue*52
        }
    }
    
    func getFullName() -> String {
        return firstName + " " + lastName
    }
    
    func giveRaise(amount: Double) {
        self.salaryYear += amount
    }
}

struct EmployeeStruct4 {
    var firstName = ""
    var lastName = ""
    var salaryYear: Double = 0.0 {
        willSet(newSalary) {
            print("About to set salaryYear to \(newSalary)")
        }
        didSet {
            if salaryWeek > oldValue {
                print("\(firstName) got a raise.")
            } else {
                print("\(firstName) did not get a raise.")
            }
        }
    }
    
    var salaryWeek: Double {
        get {
            return salaryYear/52
        }
        set {
            salaryYear = newValue*52
        }
    }
    
    func getFullName() -> String {
        return firstName + " " + lastName
    }
    
    mutating func giveRaise(amount: Double) {
        salaryYear += amount
    }
}

/**
    The self property is used to refer to the current instance of the type within the instance itself; the self property should only be used
    when necessary. The self property is mainly used to distinguish between local and instance variables that have the same name:
 */

class EmployeeClass5 {
    var firstName = ""
    var lastName = ""
    var salaryYear: Double = 0.0 {
        willSet(newSalary) {
            print("About to set salaryYear to \(newSalary)")
        }
        didSet {
            if salaryWeek > oldValue {
                print("\(firstName) got a raise.")
            } else {
                print("\(firstName) did not get a raise.")
            }
        }
    }
    
    var salaryWeek: Double {
        get {
            return salaryYear/52
        }
        set {
            salaryYear = newValue*52
        }
    }
    
    func getFullName() -> String {
        return firstName + " " + lastName
    }
    
    func giveRaise(amount: Double) {
        self.salaryYear += amount
    }
    
    func isEqualFirstName(firstName: String) -> Bool {
        return self.firstName == firstName
    }
}

struct EmployeeStruct5 {
    var firstName = ""
    var lastName = ""
    var salaryYear: Double = 0.0 {
        willSet(newSalary) {
            print("About to set salaryYear to \(newSalary)")
        }
        didSet {
            if salaryWeek > oldValue {
                print("\(firstName) got a raise.")
            } else {
                print("\(firstName) did not get a raise.")
            }
        }
    }
    
    var salaryWeek: Double {
        get {
            return salaryYear/52
        }
        set {
            salaryYear = newValue*52
        }
    }
    
    func getFullName() -> String {
        return firstName + " " + lastName
    }
    
    mutating func giveRaise(amount: Double) {
        salaryYear += amount
    }
    
    func isEqualFirstName(firstName: String) -> Bool {
        return self.firstName == firstName
    }
}

/**
    There are times when we want to initialize properties or perform some business logic when a class or structure is first initalized; for
    this we will use an initializer. Initializers are called when we initalize a new instance of a type (class or structure). Initialization is the
    process of preparing an instance for use. The process can include setting initial values for stored properties, verify that external
    resources are available, or setting up the UI properly. Initializers are generally used to ensure that the instance of the class or structure
    is properly initalized prior to first use. We define initializers similarly to other methods, but we must use the init keyword as the name
    of the initializer to tell the compiler that this method is such. In its simpliest form it does not accept any arguments:
 */

////    init() {
////        perform initialization here
////    }

/**
    This format works for both classes and structures. By default, all classes and structures have an empty default initializer that can
    be overridden. We used these defaults in the previous definitions of the Employee (class and structure). Structures also have an
    additional default initializer, which we saw with the EmployeeStruct structure, that accepts a value for each stored property and
    initializes them to those values.
 */

class EmployeeClass6 {
    var firstName = ""
    var lastName = ""
    var salaryYear: Double = 0.0 {
        willSet(newSalary) {
            print("About to set salaryYear to \(newSalary)")
        }
        didSet {
            if salaryWeek > oldValue {
                print("\(firstName) got a raise.")
            } else {
                print("\(firstName) did not get a raise.")
            }
        }
    }
    
    var salaryWeek: Double {
        get {
            return salaryYear/52
        }
        set {
            salaryYear = newValue*52
        }
    }
    
    init() {
        firstName = ""
        lastName = ""
        salaryYear = 0.0
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        salaryYear = 0.0
    }
    
    init(firstName: String, lastName: String, salaryYear: Double) {
        self.firstName = firstName
        self.lastName = lastName
        self.salaryYear = salaryYear
    }
    
    func getFullName() -> String {
        return firstName + " " + lastName
    }
    
    func giveRaise(amount: Double) {
        self.salaryYear += amount
    }
    
    func isEqualFirstName(firstName: String) -> Bool {
        return self.firstName == firstName
    }
}

struct EmployeeStruct6 {
    var firstName = ""
    var lastName = ""
    var salaryYear: Double = 0.0 {
        willSet(newSalary) {
            print("About to set salaryYear to \(newSalary)")
        }
        didSet {
            if salaryWeek > oldValue {
                print("\(firstName) got a raise.")
            } else {
                print("\(firstName) did not get a raise.")
            }
        }
    }
    
    var salaryWeek: Double {
        get {
            return salaryYear/52
        }
        set {
            salaryYear = newValue*52
        }
    }
    
    init() {
        firstName = ""
        lastName = ""
        salaryYear = 0.0
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        salaryYear = 0.0
    }
    
    init(firstName: String, lastName: String, salaryYear: Double) {
        self.firstName = firstName
        self.lastName = lastName
        self.salaryYear = salaryYear
    }
    
    func getFullName() -> String {
        return firstName + " " + lastName
    }
    
    mutating func giveRaise(amount: Double) {
        salaryYear += amount
    }
    
    func isEqualFirstName(firstName: String) -> Bool {
        return self.firstName == firstName
    }
}

/**
    We can see that in Swift, an initializer does not have an explicit return value, but it does return an instance of the type. This means
    that we do not define a return type for the initializer or have a return statement within the initializer.
    A class, unlike a structure, can have a deinitializer. A deinitializer is called just before an instance of the class is destroyed and
    removed from memory. We will look into deinitializers later in the book in Chapter 16: Memory Management.
 */


/**
    Just like functions, the parameters associated with an initializer can have separate internal and external names. If we do not
    supply external parameter names for our parameters, Swift will automatically generate them for us. Since in our previous examples
    we did not include external parameter names in the definitions, Swift created them for us using the internal parameter name as
    the external parameter name.
 */

////    init(employeeWithFirstName firstName: String, lastName lastName: String, andSalary salary: Double) {
////        self.firstName = firstName
////        self.lastName = lastName
////        self.salaryYear = salaryYear
////    }


/**
    So what will happen if our initializer fails? For example, what if our class relies on a specific resource, such as a web service that
    is not currently available? This is where failable initializers come in.
    A failable initializer is an initializer that may fail to initialize the resources needed for a class or structure, thereby rendering the
    instance unusable. When using a failable initializer, the result of the initializer is an optional type, containing either a valid instance
    of the type or nil. An initializer can be made failable by adding a question mark after the init keyword.
 */

////    init?(firstName: String, lastName: String, salaryYear: Double) {
////        self.firstName = firstName
////        self.lastName = lastName
////        self.salaryYear = salaryYear
////        if self.salaryYear < 20_000 {
////        return nil
////   }
//// }

/**
    In the previous examples we did not include a return statement within the initializer because Swift does not need to return the
    initialized instance; however, in a failable initalizer, if the initialization fails, it must return nil. If the initializer successfully initializes
    the instance, we do not need to return anything.
 */

/**
    Access controls enable us to hide implementation details and only expose the interfaces we want to expose. This feature is handled
    with access controls. We can assign specific access levels to both classes and structures. We can also assign specific access levels
    to properties, methods, and initializers that belong to our classes and structures. In Swift, there are 5 access levels:
        Open: This is the most visible access control level. It allows us to use the property, method, class and so on anywhere we want
        to import the module. Basically, anything can use an item that has this access control level. Anything that is marked open can be
        subclassed or overridden by any item within the module they are defined in and any module that imports the module it is defined
        in. This level is primarily used by frameworks to expose the framework's public API. The open-access control is only available
        to classes and members of a class.
        Public: This access level allows us to use the property, method, class and so on anywhere we want to import the module.
        Basically, anything can be use an item that has this access control level. Anything marked public can be subclassed or
        overridden only by an item within the module they are defined in. This level is primarily used by frameworks to expose the
        framework's public API.
        Internal: This is the default access level. This level allows us to use the property, method, class, and so on in the module
        the item is defined in. If this level is used in a framework, it lets other parts of the framework use the item but code outside
        the framework will be unable to access it.
        Fileprivate: This access control allows access to the properties and methods from any code within the same source file
        that the item is defined in.
        Private: This is the least visible access-control level. It only allows us to use the property, method, class, and so on, within
        extensions of the declaration defined in the source file that defines it.
 */

/**
    When developing frameworks, the access controls really become useful. We will need to mark the public-facing interfaces as
    public or open so that other modules, such as applications that import the framework, can use them. We will then use the internal
    and private access-control levels to mark the interfaces that we want to use internally to the framework and the source file,
    respectively.
    There are some limitations with access controls, but these limitations are there to ensure that access levels in Swift follow a simple
    guided principle: no entity can be defined in terms of another entity that has a lower (more restrictive) access level. This means that
    we cannot assign a higher (less restrictive) access level to an entity when it relies on another entity that has a lower (more restrictive)
    access level. The following examples demonstrate this principle:
        We cannot mark a method as being public when one of the arguments or the return type has an access level of private, because
        external code would not have access to the private type.
        We cannot set the access level of a method or property to public when the class or structure has an access level of private,
        because external code would not be able to access the constructor when the class is private.
 */

/**
    In Swift a class can have only one parent class; this is known as single inheritance. Inheritance is one of the fundamental
    differences that separates classes from structures. Classes can be derived from a parent or superclass but a structure cannot.
 */

class Plant {
    var height = 0.0
    var age = 0
    func growHeight(inches: Double) {
        height += inches
    }
}

class Tree: Plant {
    var limbs = 0
    func limbGrow() {
        limbs += 1
    }
    func limbFall() {
        limbs -= 1
    }
}

class PineTree: Tree {
    var needles = 0
}

class OakTree: Tree {
    var leaves = 0
}

var tree = Tree()
tree.age = 5
tree.height = 4
tree.limbGrow()
tree.limbGrow()
tree.growHeight(inches: 2)
print("Limbs: \(tree.limbs) Height: \(tree.height) Age: \(tree.age)")

/**
    It is important to keep in mind that in Swift, a class can have multiple subclasses; however a class can only have one superclass.
    There are times when a subclass needs to provide its own implementation of a method or property that it inherited from its superclass;
    this is known as overriding.
    To override a method, property, or subscript, we need to prefix the definition with the override keyword. This tells the compiler that we
    intend to override something in the superclass, and that we did not make a duplicate definition by mistake. The override keyword
    prompts the Swift compiler to verify that the superclass (or one of its parents) has a matching declaration that can be overridden. If it
    cannot find a matching declaration in the superclass, an error will be thrown.
 */

class Plant1 {
    var height = 0.0
    var age = 0
    
    func growHeight(inches: Double) {
        height += inches
    }
    
    func getDetails() -> String {
        return "Plant Details"
    }
}

class Tree1: Plant1 {
    private var limbs = 0
    func limbGrow() {
        limbs += 1
    }
    func limbFall() {
        limbs -= 1
    }
    override func getDetails() -> String {
        return "Tree Details"
    }
}

var plant1 = Plant1()
var tree1 = Tree1()
print("Plant: \(plant1.getDetails())")
print("Tree: \(tree1.getDetails())")


/**
    Inside the Tree class, we can still call the getDetails() method of the superclass by using the super prefix:
 */

class Plant2 {
    var height = 0.0
    var age = 0
    
    func growHeight(inches: Double) {
        height += inches
    }
    
    func getDetails() -> String {
        return "Height:\(height) Age:\(age)"
    }
}

class Tree2: Plant2 {
    private var limbs = 0
    func limbGrow() {
        limbs += 1
    }
    func limbFall() {
        limbs -= 1
    }
    override func getDetails() -> String {
        let details = super.getDetails()
        return "\(details) Limbs:\(limbs)"
    }
}

var plant2 = Plant2()
var tree2 = Tree2()
print("Plant: \(plant2.getDetails())")
print("Tree: \(tree2.getDetails())")

/**
    We can provide custom getter and setters to override an inherited property. When we override a property, we must provide the
    name and the type of the property we are overriding so that the compiler can verify that one of the classes in the class hierarchy
    has a matching property to override.
 */

////    var description: String {
////        return "Base class is Plant."
////    }

/**
    The description property is a basic read-only property. Now lets override this property by adding the following property to Tree:
 */

////    override var description: String {
////        return "\(super.description) I am a Tree class."
////    }

/**
    To prevent overrides or subclassing, we can use the final keyword. To use  the final keyword, we add it before the items definition.
    Such as final func, final var, final class. Any attempt to override an item marked with this keyword will result in a compile-time error.
 */

/**
    There are times when we would like to describe the implementations (methods, properties, and other requirements) of a type without
    actually providing any implementation. For this, we use protocols. Protocols define a blueprint of methods, properties, and other
    requirements for a class or a structure. A class or structure can then provide an implementation that conforms to those requirements.
    The class or structure that provides the implementation is said to conform to the protocol.
    The syntax to define a protocol is very similar to how we define a class or a structure.
 */

////    protocol MyProtocol {
////        definition here
////    }

/**
    We state that a class or structure conforms to a protocol by placing the name of the protocol after the type's name, separated by
    a colon.
 */

////    struct MyStruct: MyProtocol {
////        implemented here
////    }

/**
    A type can conform to multiple protocols. We list the protocols that the type conforms to by separating them with commas.
 */

////    struct MyStruct: MyProtocol, AnotherProtocol, ThirdProtocol {
////        implemented here
////    }

/**
    If we need to both inherit from a superclass and implement a protocol, we ilst the superclass first, followed by protocols.
 */

////    class MyClass: MySuperClass, MyProtocol, MyProtocol2 {
////        implemented here
////    }

/**
    A protocol can require that the conforming type provides certain properties with a specified name and type. The protocol does not
    say whether the property should be stored or computed property because the implementation details are left up to the conforming
    type. When defining a property within a protocol, we must specify whether the property is a read-only or read-write property by using
    the get and set keywords.
 */

protocol FullName {
    var firstName: String { get set }
    var lastName: String { get set }
}

/**
    The FullName protocol defines two properties, which any type that conforms to the protocol must implement. Both are read-write
    properties; if we wanted to specify read only we would only define it with the get keyword.
    The class defined below, if had forgotten to include either required properties, we would receive an error message letting us know
    the property was left out. We will also recieve an error message if a type doesn't match what it is initialized to.
 */

class Scientist: FullName {
    var firstName = ""
    var lastName = ""
}

/**
    A protocol can require that the conforming class or structure provides certain methods. We define a method within a protocol exactly
    as we do within a class or structure, except without the method body.
 */

protocol FullName1 {
    var firstName: String { get set }
    var lastName: String { get set }
    func getFullName() -> String
}

class Scientist1: FullName1 {
    var firstName = ""
    var lastName = ""
    var field = ""
    
    func getFullName() -> String {
        return "\(firstName) \(lastName) studies \(field)"
    }
}

class FootballPlayer1: FullName1 {
    var firstName = ""
    var lastName = ""
    var number = 0
    
    func getFullName() -> String {
        return "\(firstName) \(lastName) has the number \(number)"
    }
}

/**
    When a class or structure conforms to a Swift protocol, we can be sure that it has implemented the required properties and methods.
    This can be very useful when we want to ensure that certain properties or methods are implemented over various classes. Protocols
    are also very useful when we want to decouple our code from requiring specific types. The following shows how we would decouple
    code using the FullName protocol:
 */

var scientist = Scientist1()
scientist.firstName = "Kara"
scientist.lastName = "Hoffman"
scientist.field = "Physics"

var player = FootballPlayer1()
player.firstName = "Dan"
player.lastName = "Marino"
player.number = 13

var person: FullName1

person = scientist
print(person.getFullName())
person = player
print(person.getFullName())

/**
    In the code above, we create a person variaable that is of the FullName protocol type and set it to the scientist instance that we
    created. We then call getFullName() to retrieve our desciption. We then set the person variable equal to the player instance and call
    the getFullName() method again. The person variable does not care what the actual implementation type is. Since we defined the
    person variable to be of the FullName type, we can set the variable to an instance of any type that conforms to the FullName protocol;
    this is called polymorphism.
 */

/**
    With extensions, we can add new properties, methods, initializers, and subscripts, or make an existing type conform to a protocol
    without modifying the source code for the type. One thing to note is that extensions cannot override the existing functionality. To
    define an extension, we use the extension keyword, followed by the type we are extending.
 */

////    extension String {
////        new functionality here
////    }

/**
    Lets see how extensions work by adding a reverse() method and a firstLetter property to Swift's standard string class.
 */

extension String {
    var firstLetter: Character? {
        get {
            return first
        }
    }
    func reverse() -> String {
        var reverse = ""
        for letter in self {
            reverse = "\(letter)" + reverse
        }
        return reverse
    }
}

var myString = "Learning Swift is Fun"
print(myString.reverse())
print(myString.firstLetter!)
/**
    When we extend an existing type, we define properties methods, initializers, subscripts, and protocols in exactly the same way
    as we would normally define them in a standard class or structure. Extensions are very useful for adding extra functionality to an
    existing type from external frameworks, even for Apple's frameworks. It is preferred to use extensions to add extra functionality
    to types from external frameworks rather than subclassing, because it allows us to continue to use the type throughout our code
    rather than changing the type to the subclass.
 */

/**
    Optional binding allows us to unwrap one optional at a time, but what would happen if we had optional types embedded within
    other optional types? This would force us to have optional binding statements embedded within other optional binding statements.
    There is a better way to handle this: by using optional chaining. Lets first look at how this would work with optional binding:
 */

class Collar {
    var color: String
    init(color: String) {
        self.color = color
    }
}

class Pet {
    var name: String
    var collar: Collar?
    init(name: String) {
        self.name = name
    }
}

class Person {
    var name: String
    var pet: Pet?
    init(name: String) {
        self.name = name
    }
}

var jon = Person(name: "Jon")
var buddy = Pet(name: "Buddy")
jon.pet = buddy
var collar = Collar(color: "red")
buddy.collar = collar

/**
    Lets say we want to get the color of the collar for a person's pet; however the person may not have a pet or the pet
    may not have a collar; we would use optional binding to drill down through each later as shown:
 */

if let tmpPet = jon.pet, let tmpCollar = tmpPet.collar {
    print("The color of the collar is \(tmpCollar.color)")
} else {
    print("Cannot retrieve color")
}

/**
    While this is a valid example, the code is messy and hard to follow because we have multiple optional binding statements on
    the same line, where the second optional binding is dependant on the first one. Optional chaining allows us to drill down through
    multiple optional type layers of properties, methods, and subscripts in one line of code. These layers can be chained together
    and if any layer returns nil, the entire chain gracefully fails and returns nil. If none of the values return nil, the last value of the chain
    is returned. Since the results of optional chaining may be a nil value, the results are always returned as an optional type, even
    if the final value we are retrieving is a non-optional type. To specify optional chaining, we place a question mark after each of the
    optional values within the chain.
 */

if let color = jon.pet?.collar?.color {
    print("The color of the collar is \(color)")
} else {
    print("Cannot retrieve color")
}

/**
    In this example, we put a question mark after the pet and and collar properties to signify that they are of the optional type and that,
    if either value is nil, the whole chain will return nil. This is much easier to read rather than the previous example because it clearly
    shows us what optionals we are dependent on.
 */
