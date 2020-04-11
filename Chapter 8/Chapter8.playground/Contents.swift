import Cocoa

/**
                       Using Protocols and Protocol Extensions
                                  Chapter 8
*/

/**
    With protocol extensions, we are able to provide method and property implementations to any type that conform to a protocol. While
    classes, structures, and enumerations can all conform to protocols in Swift, for this chapter we be focusing on classes and structures.
    Enumerations are used when we need to represent a finite number of cases, and while there are valid use cases where we would
    have an enumeration conform to a protocol, they are very rare. Just remember that anywhere we refer to a class or structure, we
    can also use an enumeration.
 
    Even though no functionality is implemented in a protocol, they are still considered a fully fledged type in the Swift programming
    language and can be used like any other type. This means we can use protocols as a parameter type or as a return type in a
    function. We can also use them as the type for variables, constants, and collections. Let's take a look at some examples:
 */

protocol PersonProtocol {
    var firstName: String { get set }
    var lastName: String { get set }
    var birthDate: Date { get set }
    var profession: String { get }
    init(firstName: String, lastName: String, birthDate: Date, profession: String)
}

class SwiftProgrammer: PersonProtocol
{
    var firstName: String
    var lastName: String
    var birthDate: Date
    var profession: String
    
    required init(firstName: String, lastName: String, birthDate: Date, profession: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.profession = profession
    }
    
    
}

class FootballPlayer: PersonProtocol
{
    var firstName: String
    var lastName: String
    var birthDate: Date
    var profession: String
    
    required init(firstName: String, lastName: String, birthDate: Date, profession: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.profession = profession
    }
    
    
}

/// EX 1: A protocol is used as a parameter type and as a return type for a function
func updatePerson(person: PersonProtocol) -> PersonProtocol {
   // Code to update person goes here return person
    return person
}

/// EX 2: A protocol can be used as a type for constants, variables, or properties
var myPerson: PersonProtocol

/// EX 3: Protocols can be used as the item type for storing a collection, such as arrays, dictionaries, or sets
var people: [PersonProtocol] = []

/**
    Even though the PersonProtocol protocol does not implement any functionality, we can still use protocols when we need to
    specify a type. However, a protocol cannot be instantiated in the same way as a class or a structure. This is because no
    functionality is implemented in a protocol.
    We can use the instance of any type that conforms to our protocol whereever the protocol type is required. As an example, if
    we've defined a variable to be of the PersonProtocol protocol type, we can then populate that variable with any class or structure
    that conforms to this protocol.
 */

var myPerson1: PersonProtocol

myPerson1 = SwiftProgrammer(firstName: "Jon", lastName: "Hoffman", birthDate: Date(), profession: "Developer")
people.append(myPerson1)
print("\(myPerson1.firstName) \(myPerson1.lastName)")

myPerson1 = FootballPlayer(firstName: "Dan", lastName: "Marino", birthDate:Date(), profession: "Athlete")
people.append(myPerson1)
print("\(myPerson1.firstName) \(myPerson1.lastName)")

/**
    One thing to note is that Swift does not care whether the instance is a class or structure. The only thing that matters is that the type
    conforms to the PersonProtcol protocol type. We can use the PersonProtocol as the type for an array, which means that we can
    populate the array with instances of any type that conforms to the protocol.
 
    Using protocols allows us to effectively use polymorphism to select any type of object that conforms to a protocol, and be able to
    use the items defined in the protocol regardless of the object type. However, if we need to access any property or method that is
    specific to an individual type, we need to cast the instance to that type.
 */


/**
    Typecasting is a way to check the type of the instance and/or to treat the instance as a specified type. In Swift, we use the is
    keyword to check whether an instance is a specific type, and the as keyword to treat the instance as a specific type. Notice how
    we use optional binding to perform the cast.
 */

for person in people {
    if let p = person as? SwiftProgrammer {
        print("\(p.firstName) is a Swift Programmer")
    }
}

/**
    For multiple cases, it is more effective to use a switch statement as follows:
 */

for person in people {
    switch person {
        case is SwiftProgrammer:
            print("\(person.firstName) is a Swift Programmer")
        case is FootballPlayer:
            print("\(person.firstName) is a Football Player")
        default:
            print("\(person.firstName) is an unknown type")
    }
}

/**
    In Chapter 5, we saw how to filter conditional statements with the where statement. We can also use the where statement with
    the is keyword to filter the array:
 */

for person in people where person is SwiftProgrammer {
    print("\(person.firstName) is a Swift Programmer")
}

/**
    Lets look at how we can cast an instance of a class or structure to a specific type. To do this, we would use the as keyword. Since
    the cast can fail if the instance is not of the specified type, the as keyword comes in two forms: as? and as!. With the as? form, if
    the casting fails, it returns a nil, and with the as! form, if the casting fails, we get a runtime error. Therefore, it is recommendted to
    use the as? for unless we are absolutely sure of the instance type or we perform a check to the instance type prior to doing
    the cast.
    It is highly recommended to not use the as! form in code because it can cause a runtime error.
 */

/**
    Protocol extensions allow us to extend a protocol to provide method and property implementations to conforming types.They also
    allow us to provide common implementations to all the conforming types, eliminating the need to provide an implementation in each
    individual type or the need to create a class hierarchy. While protocol extensions may not seem too exciting, they are really powerful
    cand will transform the way you think about and write code.
 */

protocol Dog {
    var name: String { get set }
    var color: String { get set }
}

struct JackRussel: Dog {
    var name: String
    var color: String
}

class WhiteLab: Dog {
    var name: String
    var color: String
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
}

struct Mutt: Dog {
    var name: String
    var color: String
}

/**
    Above we have our protocol, and structs and classes conforming to the protocol, this will allow us to see the differences between
    how the two types are set up, and to illustrate how they are treated the same when it comes to protocols and protocol extensions.
    The biggest difference we can see so far is that structure types provide a default initializer, but in the class we must provide the
    initializer to populate the properties.
 
    Now lets say we want to provide a method named speak to each type that confroms to the protocol. Prior to protocol extensions, we
    would have started by adding the method definition to the protocol and adding an implementation to each type that conforms to
    that protocol. While this works, it is not very efficient.
    
    With protocol extensions, we could take the speak() method definition out of the protocol itself and define it with the default behavior
    in the protocol extension. If we are implementing a method in a protocol extension, we are not required to define it in the protocol.
    We would use protocol extension for the method speak() as so:
 */

extension Dog {
    func speak() -> String {
        return "Woof Woof"
    }
}

/**
    We create a protocol extension that extends the previous Dog protocol and contains the default implementation of the speak()
    method.
 */

let dash = JackRussel(name: "Dash", color: "Brown and White")
let lily = WhiteLab(name: "Lily", color: "White")
let maple = Mutt(name: "Buddy", color: "Brown")

let dSpeak = dash.speak()
let lSpeak = lily.speak()
let bSpeak = maple.speak()


/**
    Lets look at a real world example, but define what would be done prior to protocol extensions:
 */

protocol TextValidating {
    var regExMatchingString:  String { get }
    var regExFindMatchString: String { get }
    var validationMessage: String { get }
    func validateString(str: String) -> Bool
    func getMatchingString(str: String) -> String?
}

/**
    The Swift API design guidelines state that protocols that describe what something is should be named as a noun, while protocols
    the describe a capability should be named with a suffix of -able, -ible, or -ing.
    
    In our protocol, we defined the following 3 properties:
    regExMatchingString: is a regex string used to verify that the input string contains only valid characters.
    regExFindMatchString: is a regex string used to retrieve a new string from the input string that contains only valid chars. Generally
    used when we need to validate the input in real-time sa the user enters information, because it will find the longest matching
    prefix of the input string.
    validationMessage: This is an error message to display if the input string contains non-valid characters.
 
    The two methods for this protocol are as follows:
    validateString: returns true if the input string contains only valid chars. The regExMatchingString property will be used in this.
    getMatchingString: Will return a new string that contains only valid chars. We will use the regExFindMatchString property in this
    method to retrieve the new string.
 */

struct AlphaValidation1: TextValidating {
    static let sharedInstance = AlphaValidation1()
    private init() {}
    let regExFindMatchString = "^[a-zA-Z]{0,10}"
    let validationMessage = "Can only contain Alpha characters"
    var regExMatchingString: String {
        get {
            return regExFindMatchString + "$"
        }
    }
    func validateString(str: String) -> Bool {
        if let _ = str.range(of: regExMatchingString, options: .regularExpression) {
            return true
        }
        else {
            return false
        }
    }
    func getMatchingString(str: String) -> String? {
        if let newMatch = str.range(of: regExFindMatchString, options: .regularExpression) {
            return String(str[newMatch])
        }
        else {
            return nil
        }
    }
}

/**
    Normally, we would have several different types that conform to the protocol, where each one would validate a different type of
    input. As we can see from the above struct, there is a bit of code involved with each validation type. A lot of the code would also
    be duplicated in each type. The code for both methods and the regExMatchingString property would probably be duplicated in
    every validation class. This is not ideal, but if we want to avoid creating a class hierarchy with a superclass that contains the
    duplicate code (it is recommended that we prefer value types over reference types), prior to protocol extensions, we have no
    other choice.
 
    Now let's see how we would implement this using protocol extensions:
    With protocol extensions, we need to think about the code a little differently. The big difference is that we neither need nor want
    to define everything in the protocol. With standard protocols, all the methods and properties that you would want to access using
    a protocol interface would have to be defined within the protocol. With protocol extensions, it is preferable for us to not define a
    property or method in the protocol if we are going to be defining it within the protocol extension. Therefore, when we rewrite our
    text validation types with protocol extensions, TextValidating would be simplified to look like this:
 */

protocol TextValidating2 {
    var regExFindMatchString: String { get }
    var validationMessage: String { get }
}

extension TextValidating2 {
    var regExMatchingString: String {
        get {
            return regExFindMatchString + "$"
        }
    }
    func validateString(str: String) -> Bool {
        if let _ = str.range(of:regExMatchingString, options: .regularExpression) {
            return true
        }
        else {
            return false
        }
    }
    func getMatchingString(str: String) -> String? {
        if let newMatch = str.range(of: regExFindMatchString, options: .regularExpression) {
            return String(str[newMatch])
        }
        else {
            return nil
        }
    }
}

/**
    In the TextValidating protocol extension,  we define the two methods and the property that were defined in the original TextValidating
    protocol but were not defined in the new one. Now that we have created the protocol and protocol extension, we are able to define
    our new text validation types.
 */

struct AlphaValidation: TextValidating2 {
    static let sharedInstance = AlphaValidation()
    private init(){}
    let regExFindMatchString = "^[a-zA-Z]{0,10}"
    let validationMessage = "Can only contain Alpha characters"
}

struct AlphaNumericValidation: TextValidating2 {
    static let sharedInstance = AlphaNumericValidation()
    private init(){}
    let regExFindMatchString = "^[a-zA-Z0-9]{0,15}"
    let validationMessage = "Can only contain Alpha Numeric characters"
}

struct DisplayNameValidation: TextValidating2 {
    static let sharedInstance = DisplayNameValidation()
    private init(){}
    let regExFindMatchString = "^[\\s?[a-zA-Z0-9\\-_\\s]]{0,15}"
    let validationMessage = "Can only contain Alphanumeric characters"
}

/**
    In each of the text-validation structures, we create a static constant and a private initializer so that we can use the structure as a
    singleton. After we define the singleton pattern, all we do in each type is set the values for the regExFindMatchString and
    validationMessage properties. Now we have virtually no duplicate code. The only code that is duplicated is the code for the singleton
    pattern and that is not something we would want to put in the protocol extension because we would not want to force the singleton
    pattern on all the conforming types.
 */

var testString = "abc123"
var testString1 = "abc"
var alpha = AlphaValidation.sharedInstance
alpha.getMatchingString(str: testString)
alpha.validateString(str: testString)
alpha.validateString(str: testString1)

/**
    In the previous code, a new string is created to validate and get the shared instance of the AlphaValidation type. Then
    getMatchingString() is used to retrieve the longest matching prefix of the test string, which will be abc. Then, the validateString()
    method is used to validate the test string, but since the test string contains numbers, the method returns false.
 */

/**
    The Swift standard library defines a base layer of functionality for writing Swift applications. Everything we have used thus far is
    from the Swift standard library. It defines the fundamental data types, collections, optional, global functions, and all the protocols
    that these types conform to.
 */
