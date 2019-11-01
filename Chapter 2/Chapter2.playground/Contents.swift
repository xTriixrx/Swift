import Cocoa

/**
                    Learning about Variables, Constants, Strings, and Operators
                                    Chapter 2
 */

// Constants
let freezingTemperatureOfWaterCelsius = 0

// Swift allows developers to insert arbitrary underscores in numerical literals for readability.
let speedOfLightKmSec = 300_000

// Variables
var currentTemperature = 22
var currentSpeed = 55

/**
    Swift uses type inference to determine the value of variables. This allows programmers to omit declaring the type
    when declaring the variable. If one trys to change the variable that is inferred as one type to a value of a different type,
    the compiler will generate an error. For example:
            var integerVar = 10
            integerVar = "Some String" // Will cause an assignment error
    
    However, sometimes a programmer would like to explicitly define a variables' type (Such as using a float rather than a double).
    We can explicitly define a variable type such as this as:
            var x:Float = 3.14
    The variable identifier is followed by a colon and then the  explicit type that the variable must be.
    We will need to explicitly define the variable type if we are not setting an initial value; for example this declaration would look like:
            var x: Int
 */

/**
    In Swift, integer type and other numerical types are actually named types, and are all implemented in the Swift standard library
    using structures. This gives developers a consistent mechanism for memory management for all data types, as well as properties
    that we can access.
    For example, min/max are properties of the integer types as seen below:
 */
print("UInt8 max \(UInt8.max)")
print("UInt8 min \(UInt8.min)")

print("UInt16 max \(UInt16.max)")
print("UInt16 min \(UInt16.min)")

print("UInt32 max \(UInt32.max)")
print("UInt32 min \(UInt32.min)")

print("UInt64 max \(UInt64.max)")
print("UInt64 min \(UInt64.min)")

print("UInt max \(UInt.max)")
print("UInt min \(UInt.min)")

print("Int8 max \(Int8.max)")
print("Int8 min \(Int8.min)")

print("Int16 max \(Int16.max)")
print("Int16 min \(Int16.min)")

print("Int32 max \(Int32.max)")
print("Int32 min \(Int32.min)")

print("Int64 max \(Int64.max)")
print("Int64 min \(Int64.min)")

print("Int max \(Int.max)")
print("Int min \(Int.min)")

/**
    Integers can also be represented as binary, octal, and hexadecimal numbers. We just need to add a prefix to the number
    to tell the compiler which base the number should be in. The prefix takes the form of a zero, followed by the by the base specifier.
    The following shows how the number 95 is represented in each of the numerical baes:
 */

var decimal = 95 // no prefix
var binary = 0b1011111 // 0b
var octal = 0o137 // 0o
var hexidecimal = 0x5f // 0x

/**
    Prior to Swift 5 checking if a number was a multiple of another number was done as so:
 */
let number = 4

if number % 2 == 0 {
    print("Even")
}
else {
    print("Odd")
}

/**
    Now in Swift 5, we can use the isMultiple(of:) method like this:
 */
if number.isMultiple(of: 2) {
    print("Even")
}
else {
    print("Odd")
}

/**
    Swift supports 32 bit (Float), 64 bit (Double), and an extended 80 bit floating point number (Float80).
    The double type has a precision of at least 15 decimal digits while Float can be as small as six decimal digits.
 */

let f: Float = 0.111_111_111 + 0.222_222_222
let d: Double = 0.111_111_111 + 0.222_222_222

let f1: Float = 0.111_111_166 + 0.222_222_222
let d1: Double = 0.111_111_166 + 0.222_222_222

/**
    All numeric typesin Swift have an initializer to type conversion, these are called convenience initializers.
    Generally when we are adding two different types together, we will want to convert the number with the least floating
    point precision, like an integer or float, to the type with the highest precision, like a double.
 */
var a: Int = 3
var b: Double = 0.14
var c = Double(a) + b

var intVar = 32
var floatVar = Float(intVar)
var uint16Var = UInt16(intVar)

/**
    In previous versions of Swift, if we wanted to toggle the value of a Boolean type we would have used the code:
 */
var isItRaining = false;
isItRaining = !isItRaining;

// Starting with Swift 4.2, we can use the toggle() method like this:
isItRaining.toggle()

var multiLine = """
This is a multiline string literal.
This shows how we can create a string over multiple lines.
"""

var stringOne = "Hello"
for char in stringOne {
    print(char)
}

// The map function also can retrieve each character
stringOne.map {
    print($0)
}

// String concatenation example
var stringA = "Jon"
var stringB = "Vinny"
var stringC = stringA + stringB
var stringD = "\(stringA) \(stringB)"

/**
    Starting in Swift 5, we have the ability to create raw strings. In previous versions of Swift, if we wanted to include
    quotes or backslashes in a string, we had to use escape characters to do so such as this:
 */
let str = "The main character said \"hello\"";
/**
    With a raw string, the double quotes and backslashes are treated as part of the string literal, so we do not need to escape them.
    The following example shows how to do this:
 */
let str1 = #"The main character said "hello""#
/**
    The hashtag and double quotes at the start and end of the string signify to Swift that this is a raw string, making it much easier
    to read what the string actually contains. If we wanted to append another string in-line, we would use the \#() escape character:
 */
let ans = 42
var str2 = #"The answer is \#(ans)"#

/**
    In Swift, we define the mutability of variables and collections by using the var and let keywords. If we define a sring as a variable
    using var, the string is mutable, but if we use let the string is immutable.
    The following code shows the difference between a mutable and an immutable string:
 */
var x = "Hello"
let y = "HI"
var z = " World"
// This is valid because x is mutable
x += z
// This is invalid because y is no mutable
//y += z

/**
    Strings in Swift have two methods that can convert the case of the string. These methods are lowercased() and uppercased()
 */
var stringOnee = "hElLo"
print("Lowercase String: \(stringOnee.lowercased())")
print("Uppercase String: \(stringOnee.uppercased())")

/**
    Swift provides four ways to compare a string; these are string equality, prefix equality, suffix equality, and isEmpty.
    The isEmpty() method checks to see if the string contains any characters or not. The string equality (==) checks to see if the
    characters (which are case-sensitive) in the two strings are the same. The prefix and suffix equality is case-sensitive as well.
    The following example demonstrates these ways:
*/

var newStringOne = "Hello Swift"
var newStringTwo = ""
newStringOne.isEmpty // false
newStringTwo.isEmpty // true
newStringOne == "hello swift" // false
newStringOne == "Hello Swift" // true
newStringOne.hasPrefix("Hello") // true
newStringOne.hasSuffix("Hello") // false
newStringOne.hasSuffix("Swift") // true

/**
    We can replace all the occurrences of a target string with another string. This is done with the replacingOccurances(of:) method.
 */
var occuring = "one,to,three,four"
var occuring2 = occuring.replacingOccurrences(of: "to", with: "two")
print(occuring2)

/**
    We can also retrieve substrings and individual characters from our strings; however, when we retrieve a substring from a string,
    the substring is an instance of the Substring type and not the String type. The Substring type contains most of the same methods
    as the String type, so you can use them in a similar way.
    Unlike String types, they are meant to be used only for short periods of time, only while we are working with the value. If you need to
    use a Substring type for a long time, you should convert it into a String type.
    The following example shows how we can work with substrings:
 */

var path = "/one/two/three/four"
// Create start and end indexes
let startIndex = path.index(path.startIndex, offsetBy: 4)
let endIndex = path.index(path.startIndex, offsetBy: 14)

let sPath = path[startIndex ..< endIndex] // returns /two/three
// convert the substring to a string
let newStr = String(sPath)
path[..<startIndex] // returns the "/one"
path[endIndex...] // returns the "/four"

path.last
path.first

/**
    We use the subscript path to retrieve the substring between a start and end index; The indices are created with the index(_:offsetBy)
    function; the first property in the index(_:offsetBy:) function gives the index of where we wish to start, and the offsetBy property tells
    us how much to increase the index by.
    The path[..<startIndex] line creates a substring from the beginning of the string to the index and the path[endIndex...] line creates
    a substring from the index to the end of the string. We then use the last property to get the last character of the string and the
    first property to get the first character.
    We can retrieve the number of characters in a string by using the count property; such as the following example:
 */
var newPath = "/one/two/three/four"
var length = path.count

/**
    Tupe group multiple values into a single compound type. These values are not required to be of the same type. The following example
    is an unnamed type that contains two strings, two integers, and one double. The values of the tuple can be decomposed into a set of
    variables, as shown in the following:
 */
var team = ("Boston", "Red Sox", 97, 65, 59.9)
var (city, name, wins, losses, percent) = team
// Can also get values of tuples by the location
// var city = team.0
// var name = team.1
// ...
/**
    Named tuples, allow us to avoid the decomposition step. A named tuple associates a name (key) with each element of the tuple.
    Values from a named tuple can be accessed using the dot syntax; we can access the city element like team.city which will contain
    Boston.
 */
var team1 = (city1:"Boston", name1:"Red Sox", wins1:97, losses1:65, percentage:59.9)

/**
    Enumerations are a special data type that enables us to group related types together and use them in a type-safe manner. Enums
    in Swift are not tied to integer values as they are in other languages such as C. In Swift, we are able to define an enumeration with
    a type (string, character, integer, or floating-point) and define its actual value (known as the raw value). Enums also support features
    that are tradionally only supported by classes, such as computed properties and instance methods. These features will be discussed later.
 */

/// When defining the enumeration type, the name of the enumeration should be capitalized like other types; however the member
/// values can be upper or lower case.
enum Planets {
    case mercury
    case venus
    case earth
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
}

/**
    The values defined in an enumeration are considered to be the member values of the enum. In most cases, you will see the member
    values defined like it is in the priori example however there is a more verbose method.
 */

enum Planets1 {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
var planetWeLiveOn = Planets.earth
var furthestPlanet = Planets.neptune

/**
    The type for the plantWeLiveOn and furthestPlanet variables is inferred when we initialize the variable with one of the member
    values of the Planets enumeration. Once the variable type is inferred, we can then assign a new value without the Planets prefix:
 */
planetWeLiveOn = .mars

/**
    The following example shows how to use the equals operator and the switch statement with an enum:
 */

if planetWeLiveOn == .earth {
    print("Earth it is")
}
// Using the switch statement
switch planetWeLiveOn {
    case .mercury:
        print("We live on Mercury, it is very hot!")
    case .venus:
        print("We live on Venus, it is very hot!")
    case .earth:
        print("We live on Earth, just right")
    case .mars:
        print("We live on Mars, a little cold")
    default:
        print("Where do we live?")
}

/**
    Enumerations can come prepopulated with raw values, which are required to be of the same type. The rawValue property is
    used to retrieve the stored value for the Tablet member of the Devices enumeration. The following example shows
    how to define an enumeration with string values:
 */
enum Devices: String {
    case MusicPlayer = "iPod"
    case Phone = "iPhone"
    case Tablet = "iPad Pro"
}

print("We are using an \(Devices.Tablet.rawValue)")

/// We only assign a value to the first member here; If integers are used for the raw values then we do not have to assin a value to
/// each member. If no value is present, the raw values will be auto-incremented.
enum Planets2: Int {
    case mercury = 1
    case venus, earth, mars, jupiter, saturn, uranus, neptune
}
print("Earth is planet number \(Planets2.earth.rawValue)")

/**
    In Swift, enumerations can also have associated values. Associated values allow us to store additional information, along with
    member values. This additional information can vary each time we use the member. It can also be of any type, and the types can be
    different for each member.
 */

enum Product {
    case Book(Double, Int, Int)
    case Puzzle(Double, Int)
}

var masterSwift = Product.Book(49.99, 2017, 310)
var worldPuzzle = Product.Puzzle(9.99, 200)
switch masterSwift {
    case .Book(let price, let year, let pages):
        print("Mastering Swift was published in \(year) for the price of \(price) and has \(pages) pages.")
    case .Puzzle(let price, let pieces):
        print("Mastering Swift is a puzzle with \(pieces) pieces and sells for \(price)")
}

switch worldPuzzle {
case .Book(let price, let year, let pages):
    print("World Puzzle was published in \(year) for the price of \(price) and has \(pages) pieces.")
case .Puzzle(let price, let pieces):
    print("World Puzzle is a puzzle with \(pieces) pieces and sells for \(price)")
}

/**
    In the  preceding example, we begin by defining a Product enum with two members: Book and Puzzle. The Book member has associated
    values of the Double, Int, and Int types, whie the Puzzle member has associated values of the Double and Int types. Notice that we are
    using named associated types where we assign a name for each associated type. We then create two products, masterSwift and
    worldPuzzle. We assign the masterSwift variable a value of Product.Book with the associated values of 49.99, 2017, and 310; likewise
    for the worldPuzzle variable.
 
    We can then check the Products enum using a switch statement; we then extract the associated values within the switch statement
    into constants using the let keyword, but can also use the var keyword.
 */

for i in 1...3 {
    print("Number: \(i)")
}

/**
    The preceding example shows the closed range operator which defines a range that runs from the first number to the second number.
    The numbers are separated by three dots such as:
            a...b
 */

for i in 1..<3 {
    print("Number: \(i)")
}

/**
    The preceding example shows the half open range operator which defines a range that runs from the first number to one minus the
    second number. The numbers are separated by two dots and the less than sign.
            a..<b
 */

/**
    The ternary conditional operator assigns a value to a variable based on the evaluation of a comparison operator or boolean value.
        boolValue ? valueA : valueB
 */
var x2 = 2
var y2 = 3
var z2 = (y2 > x2 ? "Y is greater" : "X is greater") // z equals "Y is greater"
