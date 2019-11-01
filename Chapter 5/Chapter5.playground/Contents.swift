import Cocoa

/**
                       Control Flow
                        Chapter 5
*/

/**
    In Swift, unlike other C-like languages, curly brackets are required for conditional statements and loops. In other C-like languages,
    if there is only one statement to execute for a condtional statement or a loop, curly brackets around that line are optional. This has
    led to numerous errors and bugs, such as Apple's goto fail bug. When Apple was designing Swift, they decided to introduce the use
    of curly brackets, even when there was only one line of code to execute.
    Unlike other C-like languages, the parentheses around conditional experessions in Swift are optional.
    Control flow refers to the order in which statements, instructions, or functions are executed within an application. Swift supports
    most of the familiar control flow statements that are used in C-like languages. It is worth noting that Swift does not include the
    traditional C for loop and rather than the traditional do-while loop, Swift has the repeat-while loop.
    In addition to the standard C control flow statements, Swift has also included statements such as the for-in loop and enhanced
    some of the existing statements such as the switch statement.
 */

let teamOneScore = 7
let teamTwoScore = 6
if teamOneScore > teamTwoScore {
    print("Team One Won")
}

if teamOneScore > teamTwoScore {
    print("Team One Won")
} else {
    print("Team Two Won")
}

if teamOneScore > teamTwoScore {
    print("Team One Won")
} else if teamTwoScore > teamOneScore {
    print("Team Two Won")
} else {
    print("We have a tie.")
}

/**
    In Swift, and most modern languages, our conditional statements tend to focus on testing whether a condition is true. This type
    of code embeds our functional code within our checks and tucks the error conditions away at the end of our functions, but what if that
    is not what we really want? Sometimes, it may be nice to take care of our error conditions at the beginning of the function. Not all
    conditional statements are that easy to rewrite, especially items such as optional binding.
    In Swift, we have the guard statement. This statement focuses on performing a function if a condition is faluse; this allows us to trap
    erros and perform the error conditions early in our functions:
 */
var x = 19
guard x > 10 else {
    // Do error condtion return
    exit(1)
}
// Functional code here

/**
    In this example, we check to see whether the x variable is greater than 10, and if not we perform the error condition; otherwise the
    code continues. you will notice that we have a return statement embedded within a guard condition. The code within the guard
    statement must contain a transfer of control statement; this is what prevenst the rest of the code from executing. If we forget the
    transfer of control statement, Swift will show an error.
 */

func guardFunction(str: String?) {
    guard let goodStr = str else {
        print("Input was nil")
        return
    }
    print("Input was \(goodStr)")
}

/**
    In the previous example, we create a function named guardFunction that accepts an optional that contains a string or nil value. We
    then use the guard statement with optional binding to verify that the string optional is not nil. If it does contain nil, then the code within
    the guard statement is executed and the return statement is used to exit the function. The great thing about using the guard statement
    with optional binding is that the new variable is within the scope of the rest of the function, rather than just within the scope of the
    optional binding statement.
 */

/**
    While Swift does not offer the standard C-based for loop, it does have the for-in loop. The for-in statement is used to execute a
    block of code from each item in a range, collection, or sequence. The for-in loop iterates over a collection of items or a range of
    numbers, and executes a block of code for each item in the collection or range.
 */

for index in 1...5 {
    print(index)
}

/**
    The preceding loop used the close range operator but Swift also provides the half-open range operator and the one-sided range
    operators that were in the previous chapter as well.
 */

var countries = ["USA", "UK", "IN"]
for item in countries {
    print(item)
}

/**
    As you can see, iterating through an array with the for-in loop is safer, cleaner, and a lot easier than using the standard C-based
    for loop. Using the for-in loop prevents us from making common mistakes, such as using the less than or equal to operator
    rather than the less than operator in our conditional statement.
 */

var dic = ["USA": "United States", "UK": "United Kingdom", "IN": "India"]
for (abbr, name) in dic {
    print("\(abbr) -- \(name)")
}

/**
    In the previous example, each item in the dictionary is returned as a key value tuple. We can decompose tuple members as named
    constants within the body of the loop. One thing to note is that since a dictionary does not guarantee the order that items are stored
    in, the order that they are iterated through may not be the same as the order in which they were inserted.
 */

/**
    The while loop executes a block of code until a condition is met. Swift provides two forms of the whle loop; these are the while
    and repeat-while loops. In Swift 2.0, Apple replaced the do-while loop with the repeat-while loop. The repeat while loop functions
    in the same way as the do-while loop did. Swift uses the do statement for error handling.
    We use while loops when the number of iterations to perform is not known and is usually dependent on some business logic.
    A while loop is used when you want to run a loop zero or more times, while a repeat-while loop is used when you want to run the
    loop one or more times.
    In the following example, the while loop will continue to execute the block of code while the randomly-generated number is less than 7.
 */
var ran = 0
while ran < 7 {
    print(ran)
    ran = Int.random(in: 1..<20)
}

/**
    The difference between the while and repeat-while loops is that the while loops check the conditional statement prior to executing
    the block of code for the first time; therefore all the variables in the conditional statements need to be initialized prior to executing
    the while loop. The repeat-while loop will run through the loop block prior to checking the conditional for the first time. Meaning we
    can initalize the variables in the conditional block of code.
 */

var ran2: Int
repeat {
    ran2 = Int.random(in: 1..<20)
} while ran2 < 4

/**
    The switch statement takes a value, compares it to several possible matches, and executes the appropriate block of code based
    on the first successful match. Unlike most other languages, in Swift, the switch statement does not fall through to the next case
    statement; therefore we do not need to use a break statement to prevent this fall through. This is another safety feature that has
    been built into Swift, as one of the most common programming mistakes regarding the switch statement made by beginners is to
    forget the break statement at the end of a case statement.
 */
var speed = 300000000
switch speed {
    case 300000000:
        print("Speed of light")
    case 340:
        print("Speed of sound")
    default:
        print("Unknown speed")
}

/**
    Every switch statement must have a match so it is required to include a default case, otherwise the compiler will throw an error
    during compile time; therefore we will not be notified until attempting to compile.
    It is possible to include multiple items in a single case; this needs to be separate items with a comma:
 */

var char : Character = "e"
switch char {
    case "a", "e", "i", "o", "u":
        print("letter is a vowel!")
    case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m","n", "p",
    "q", "r", "s", "t", "v", "w","x", "y", "z":
        print("Letter is a consonant")
    default:
        print("unknown letter")
}

/**
    It is also possible to check the value of a switch statement to see whether it is included in a range:
 */
var grade = 93
    switch grade {
    case 90...100:
        print("Grade is an A")
    case 80...89:
        print("Grade is a B")
    case 70...79:
        print("Grade is a C")
    case 60...69:
        print("Grade is a D")
    case 0...59:
        print("Grade is a F")
    default:
        print("Unknown Grade")
}

/**
    In Swift, any case statement can contain an optional where clause, which provides an additional condition that needs validating. Lets
    say that, in our preceding example, we have students who are receiving special assistance in class and we want to define a grade of
    D for them as a range from 55 to 69:
 */

var studentId = 4
var grade1 = 57
switch grade1 {
case 90...100:
    print("Grade is an A")
case 80...89:
    print("Grade is a B")
case 70...79:
    print("Grade is a C")
case 55...69 where studentId == 4:
    print("Grade is a D for student 4")
case 60...69:
    print("Grade is a D")
case 0...59:
    print("Grade is a F")
default:
    print("Unknown Grade")
}

/**
    One thing to bear in mind with the where expression is that Swift will attempt to match the value starting with the first case statement
    and working its way down; this means that if we put the case statement with the where expression after the grade F case statement,
    then the case statement with the where will never be reached.
    If you are using the where clause, a good rule of thumb is to always put the case statements with the where clause before any
    similar case statements without the where clause.
    Switch statements are also extremely useful for evaluating enuemrations. Since an enumeration has a finite number of values,
    if we provide a case statement for all the values in an enumeration, we do not need to provide a default case.
 */

enum Product {
    case Book(String, Double, Int)
    case Puzzle(String, Double)
}

var order = Product.Book("Mastering Swift 5", 49.99, 2017)
switch order {
case .Book(let name, let price, let year):
    print("You ordered the book \(name): \(year) for \(price).")
case .Puzzle(let name, let price):
    print("You ordered the puzzle \(name) for \(price).")
}

enum Planets {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

var planetWeLiveOn = Planets.Earth
switch planetWeLiveOn {
    case .Mercury:
        print("We live on Mercury, it is very hot!")
    case .Venus:
        print("We live on Venus, it is very hot!")
    case .Earth:
        print("We live on Earth, just right")
    case .Mars:
        print("We live on Mars, a little cold")
    case .Jupiter, .Saturn, .Uranus, .Neptune:
        print("Where do we live?")
}

/**
    In the preceding code, we have a case statement that will handle each planet in the Planets enumeration. We can also add a default
    statement to handle any additional planets if they are added in later. However it is recommended that if a switch statement uses a
    default case with an enumeratrion, than we use the @unknown attribute as follow:
 */
switch planetWeLiveOn {
    case .Mercury:
        print("We live on Mercury, it is very hot!")
    case .Venus:
        print("We live on Venus, it is very hot!")
    case .Earth:
        print("We live on Earth, just right")
    case .Mars:
        print("We live on Mars, a little cold")
    case .Jupiter, .Saturn, .Uranus, .Neptune:
        print("Where do we live?")
    @unknown default:
        print("Unknown planet")
   }

/**
    This will always throw a warning to remind us that if we add a new planet to the Planet enumeration, than we need to handle that
    new planet in this part o the code.
 */

let myDog = ("Chestnut", 5)
switch myDog {
    case ("Lily", let age):
        print("Lily is my dog and is \(age)")
    case ("Chestnut", let age):
        print("Chestnut is my dog and is \(age)")
    case ("Dash", let age):
        print("Dash is my dog and is \(age)")
    default:
        print("unknown dog")
    }

/**
    In this code, we created a tuple named myDog that contained the name of my dog and his age. We then use the switch statement
    to match the name (first element of the tuple) and a let statement to retrieve the age.
    We can also use the underscore (wildcard) and range operators with tuples in the case statement:
 */
switch myDog {
    case(_, 0...1):
        print("Your dog is a puppy")
    case(_, 2...7):
        print("Your dog is middle aged")
    case(_, 8...):
        print("Your dog is getting old")
    default:
        print("Unknown")
       }

/**
    In the preceding code, the underscore will match any name, while the range operators will look for the age of the dog.
    In Swift, we can also combine the underscore (wildcard) with the where statement:
 */

let myNumber = 10
switch myNumber {
    case _ where myNumber.isMultiple(of: 2):
        print("Multiple of 2")
    case _ where myNumber.isMultiple(of: 3):
        print("Multiple of 3")
    default:
        print("No Match")
}

/**
    In this following example, we will take an array of integers and print out only multiples of 3. However before we look at how to filter
    the results with the where statement, lets look at how this would be done without one:
 */

for number in 1...30 {
    if number % 3 == 0 {
        print(number)
    }
}

for number in 1...30 where number % 3 == 0 {
    print(number)
}

/**
    Both loops are the same, however we have now put the where statement at the end; therefore we only loop through numbers that
    are multiples of 3. Using the where statement shortens our example code line-wise, as well as the complexity of the looping of every
    single number in the range.
 */

/**
    In this next example, we will use the for-case statement to filter through an array of tuples and print out only the results that match
    our criteria. The for-case example is very similar to using the where statement where it is designed to eliminate the need for an if
    statement within a loop to filter the results.
 */

var worldSeriesWinners = [
    ("Red Sox", 2004),
    ("White Sox", 2005),
    ("Cardinals", 2006),
    ("Red Sox", 2007),
    ("Phillies", 2008),
    ("Yankees", 2009),
    ("Giants", 2010),
    ("Cardinals", 2011),
    ("Giants", 2012),
    ("Red Sox", 2013),
    ("Giants", 2014),
    ("Royals", 2015)
]

for case let ("Red Sox", year) in worldSeriesWinners {
    print(year)
}

/**
    The for-case-in statement also makes it very easy to filter out the nil values in an array of optionals:
 */
let myNumbers: [Int?] = [1, 2, nil, 4, 5, nil, 6]
for case let .some(num) in myNumbers {
    print(num)
}
/**
    In this example we created an array of optionals named myNumbers that could contain either an integer value or nil. As we saw in
    Chapter 3, Optional Types, an optional is internally defined as an enumeration as shown:
    enum Optional < Wrapped > {
        case none,
            case some(Wrapped)
    /}
    If an optional is set to nil, it will have a value of none, but if it is not nil, it will have a value of some, with an associated type of the
    actual value. In the previous example, when we filter for .some(num), we are looking for any optional that has a non-nil value.
    As shorthand for .some(), we could use the question mark symbol.
 */
for case let num? in myNumbers where num < 3 {
    print(num)
}

/**
    Using the if-case statement if very similar to using the switch statement. Most of the time, the switch statement is preferred when
    we have over two cases that we are trying to match, but there are instances where the if-case is needed. One of those times is when
    we are only looking for one or two possible matches, and we do not want to handle all the possible matches:
 */
enum Identifier {
    case Name(String)
    case Number(Int)
    case NoIdentifier
}

var playerIdentifier = Identifier.Number(2)
if case let .Number(num) = playerIdentifier {
    print("Player's number is \(num)")
}

/**
    In this example, we created an enumeration named Identifier that contains three possible values: Name, Number, and NoIdentifier.
    We then created an instnae of the Identifier enumeration named playerIdentifier, with a value of Number and an associated value of 2.
    We then used the if-case statement to see if the playerIdentifier had a value for Number and if so, we printed a message.
    Just like the for-case statement, we can perform additional filtering with the where statement.
 */
if case let .Number(num) = playerIdentifier, num == 2 {
    print("Player is either Xander Bogarts or Derek Jeter")
}

/**
    In this example, we have used the if-case statement to see if the playerIdentifier had a value of Number, but we also added the where
    statement (,) to see if the associated value was equal to 2.
 */

/**
    Control transfer statements are used to transfer control to another part of the code. Swift offers six control transfer statements; these
    are continue, break, fallthrough, guard, throws, and return.
    The continue statement tells a loop to stop excecuting the code block and to go to the next iteration of the loop:
 */

for i in 1...10 {
    if i % 2 == 0 {
        continue
    }
    print("\(i) is odd.")
}

/**
    The break statement immediately ends the execution of a code block within the control flow.
 */

for i in 1...10 {
    if i % 2 == 0 {
        break
    }
    print("\(i) is odd.")
}

/**
    In Swift, the switch statement does not fall through like other languages; however, we can use the fallthrough statement to force them
    to fall through. The fallthrough statement can be very dangerous because, once a match is found, the next case defaults to true
    and that code block is executed.
 */

var name = "Vinny"
var sport = "Hockey"
switch sport {
case "Hockey":
    print("\(name) plays Hockey")
    fallthrough
case "Basketball":
    print("\(name) plays Basketball")
default:
    print("Unknown sport")
}

/**
    Be very careful using the fallthrough statement, Apple purposely disabled falling through on the case statement to avoid the common
    erros that programmers make. By using fallthrough this can be reintroduced.
 */
