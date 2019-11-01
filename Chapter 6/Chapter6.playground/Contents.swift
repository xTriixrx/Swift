import Cocoa

/**
                        Functions
                        Chapter 6
 */

/**
    The syntax that's used to define a function in Swift is very flexible. This flexibility makes it easy for us to define simple C-style
    functions, or more complex functions, with local and external parameter names, which we will see later in this playground. The
    following example accepts one parameter and does not return any value back to the code that called it:
 */
func sayHello(name: String) -> Void {
    let retString = "Hello " + name
    print(retString)
}

@discardableResult func sayHello2(name: String) -> String {
    let retString = "Hello " + name
    return retString
}

/**
    the -> string defines the return type of a function. Calling a Swift function is similar to other languages such as C or Java.
 */
sayHello(name: "Vinny")
var message = sayHello2(name: "Vinny")
print(message)

/**
    If you do not specify a variable for the return value to go into, the value is dropped. You can use the underscore to tell the compiler
    that the programmer is aware but this is not needed. Using the @discardableResult attribute when declaring a function will also
    silence any warnings regarding this:
 */
_ = sayHello2(name: "Vinny")

func sayHello3(name: String, greeting: String) {
    print("\(greeting) \(name)")
}

sayHello3(name: "Vinny", greeting: "Hello")

func sayHello4(name: String, greeting: String = "Hello") {
    print("\(greeting) \(name)")
}

sayHello4(name: "Vinny")
sayHello4(name: "Vinny", greeting: "Bonjour")

/**
    We can declare multiple parameters with default values and override only the ones we want by using the parameter names.
 */

func sayHello5(name: String = "Bob", name2: String = "Kim", greeting: String = "Bonjour") {
    print("\(greeting) \(name) and \(name2)")
}
sayHello5(name: "Vinny", greeting: "Hello")

/**
    There are a couple of ways to return multiple values from a Swift function. One of the most common ways is to put the values into
    a collection type (an array or dictionary) and then return the collection.
 */

func getNames() -> [String] {
    let retArray = ["Jon", "Kim", "Kailey", "Kara"]
    return retArray
}
var names = getNames()

/**
    In the preceding example, our array could only return string types. If we needed to return numbers with our strings, we could return
    an array of the Any type and then use typecasting to specify the object type. However, this would not be a good design for our
    application as it would be prone to errors. A better way to return values of different types would be to use a tuple type.
    When we return a tuple from a function, it is recommended that we use a named tuple to allow us to use the dot syntax to access
    the returned values. 
 */

func getTeam() -> (team:String, wins:Int, percent:Double) {
    let retTuple = ("Red Sox", 99, 0.611)
    return retTuple
}
var t = getTeam()
print("\(t.team) had \(t.wins) wins")

/**
    In prevous sections, we returned non-nil values from our function; however, that is not always what we need our code to do. What
    happens if we need to return a nil value from a function? If there is a reason to return nil, we need to define the return type as an
    optional type to let the code calling it know that the value may be nil.
 */
func getName() -> String? {
    return nil
}

/**
    We can also set a tuple as an optional type, or any value within a tuple as an optional type:
 */

func getTeam2(id : Int) -> (team:String, wins:Int, precent:Double)? {
    if id == 1 {
        return ("Red Sox", 99, 0.611)
    }
    return nil
}

/**
    In the following example, we could return a tuple as it was defined within our function definition  or nil; either option is valid. If we
    needed an individual value within our tuple to be nil, we would need to add an optional type within our tuple.
 */

func getTeam3() -> (team:String, wins:Int, precent:Double?) {
    let retTuple: (String, Int, Double?) = ("Red Sox", 99, nil)
    return retTuple;
}

/**
    In the previous examples, we defined the parameters' names and value types in the same way we would define parameters
    in C code. In Swift, we are not limited to this syntax as we can also use external parameter names.
    External parameter names are used to indicate the purpose of each parameter when we call a function. An external parameter name
    for each parameter needs to be defined in conjunction with its local parameter name. The external parameter name is added
    before the local parameter name in the function definition. The external and local parameter names are separated by a space.
    Let's look at how to use external parameter names but lets show an example to modify with the redefine using external parameter
    names:
 */

func winPercentage(team: String, wins: Int, loses: Int) -> Double {
    return Double(wins) / Double(wins + loses)
}
var per = winPercentage(team: "Red Sox", wins: 99, loses: 63)

func winPercentage2(baseballTeam team: String, withWins wins: Int, andLosses losses: Int)
    -> Double {
        return Double(wins) / Double(wins + losses)
}

/**
    In the redefinition, we have the same three parameters team, wins, and losses. The difference is how we define the parameters; when
    using external parameters, we define each parameter with both an external and local parameter name separated by a space. When
    we call a function with external parameter names, we need to include the external parameter names in the function call:
 */
var per2 = winPercentage2(baseballTeam: "Red Sox", withWins: 99, andLosses: 63)

/**
    While using external parameter names requires more typing, it does make your code easier to read.
    A variadic parameter is one that accepts zero or more values of a specified type. Within the function's definition, we define a
    variadic parameter by appending three periods to the parameter's type name. The values of a variadic parameter are made available
    to the func tion as an array of the specified type.
 */

func sayHello6(greeting: String, names: String...) {
    for name in names {
        print("\(greeting) \(name)")
    }
}
sayHello6(greeting: "Hello", names: "Vinny", "Kim", "Carly")

/**
    If we want to change the value of a parameter and we want those changes to persist once the function ends, we need to define the
    parameter as an inout parameter. Any changes made to an inout parameter are passed back to the variable that was used in the
    function call. Inout parameters cannot have default values and they cannot be variadic parameters.
 */

func reverse(first: inout String, second: inout String) {
    let tmp = first
    first = second
    second = tmp
}

/**
    When we make the function call, we put an ampersand & in front of the variable name, indicating the function can modify its value.
 */

var one = "One"
var two = "Two"
reverse(first: &one, second: &two)
print("one: \(one) two: \(two)")

/**
    A variadic parameter cannot be an inout parameter and an inout parameter cannot have a default value.
    All of the functions in this chapter have used labels when passing arguments into the functions. If we do not want to use a label,
    we can omit it by using an underscore.
 */

func sayHello7(_ name: String, greeting: String) {
    print("\(greeting) \(name)")
}
sayHello7("Vinny", greeting: "Hello")

func isValidIP(ipAddr: String?) -> Bool {
    guard let ipAddr = ipAddr else { return false } // using optional binding
    
    let octets = ipAddr.split { $0 == "." }.map{String($0)}
    guard octets.count == 4 else { return false }
    
    for octet in octets {
        guard validOctet(octet: octet) else {
            return false
        }
    }
    return true
}

func validOctet(octet: String) -> Bool {
    guard let num = Int(octet), num >= 0 && num < 256 else {return false}
    return true
}

isValidIP(ipAddr: nil)
isValidIP(ipAddr: "10.20")
isValidIP(ipAddr: "10.0.1.250")
