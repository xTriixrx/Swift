import Cocoa

/**
                        Availability and Error Handling
                              Chapter 11
*/

/**
    Languages such as Java and C# generally refer to the error-handling process as exception handling. Within the Swift documentation,
    Apple referes to this process as error handling. While on the outside, Java and C# exception handling may look somewhat similar to
    Swift's error handling, there are some significant differences that those familiar with exception handling in other languages will notice.
 */

/**
    In Swift, errors are represented by values of types that conform to the Error protocol. Swift's enumerations are very well-suited to
    modeling error conditions because we have a finite number of error conditions to represent.
 */

//enum MyError: Error {
//    case Minor
//    case Bad
//    case Terrible
//}

/**
    We can also use associated values with our error conditions to allow us to add more details about the error condition. Let's say
    that we want to add a description to the Terrible error condition. We would do it like this:
 */

enum MyError: Error {
    case Minor
    case Bad
    case Terrible(description:String)
}

/**
    Those who are familiar with exception handling in Java and C# can see that representing errors in Swift is a lot cleaner and easier,
    because we do not need to create a lot of boilerplate code or a full class. With Swift, it can be as simple as defining an enumeration
    with our error conditions. Another advantage is that it is very easy to define multiple error conditions and group them together so that
    all related error conditions are of one type.
 
    Now let's see how we can model errors in Swift. For this example, let's look at how we would assign numbers to players on a
    baseball team. For a baseball team, every new player who is called up is assigned a unique number. This number must also be within
    a certain range, because only two numbers fit on a baseball jersey. Therefore we would have 3 error conditions: number is too large,
    number is too small, and number is not unique. The following example shows how we might represent these error conditions:
 */

//enum PlayerNumberError: Error {
//    case NumberTooHigh(description: String)
//    case NumberTooLow(description: String)
//    case NumberAlreadyAssigned
//}

/**
    These error conditions are grouped together in one type since they are all related to assigning the players' numbers. This method
    of defining errors allows us to define very specific erros that let our code know exactly what went wrong if an error condition occurs.
    It also lets us group the errors so that all related errors can be defined in the same type.
 */

/**
    When an error occurs in a function, the code that called the function must be made aware of it; this is called throwing the error. When
    a function throws an error, it assumes that the code that called the function, or some code further up the chain, will catch and
    recover appropriately from the error.
    
    To throw an error from a function, we use the throws keyword. This keyword lets the code that called it know that an error may be
    thrown from the function. Unlike exception handling in other languages, we do not list the specific error types that may be thrown.
    
    Since we do not list the specific error types that may be thrown from a function within the function's definition, it would be good
    practice to list them in documentation and comments for the function, so that other developers who use the function know what error
    types to catch.
 
    Let's add a fourth error to the PlayerNumberError type; this error condition is thrown if we are trying to retrieve a player by their
    number, but no player has been assigned that number.
 */

enum PlayerNumberError: Error {
    case NumberTooHigh(description: String)
    case NumberTooLow(description: String)
    case NumberAlreadyAssigned
    case NumberDoesNotExist
}

/**
    To demonstrate how to throw errors, let's create a BaseballTeam structure that will contain a list of players for a given team. These
    players will be stored in a dictionary object named players, and will use the player's number as the key, because we know that each
    player must have a unique number. The BaseballPlayer type, which will be used to represent a single player, will be a typealias for
    a tuple type, and is defined as so:
 */

typealias BaseballPlayer = (firstName: String, lastName: String, number: Int)

/**
    In this BaseballTeam structure, we will have two methods. The first one will be named addPlayer(). This method will accept
    one parameter of the BaseballPlayer type and will attempt to add the player to the team. This method can also throw one of
    three error conditions.
 
    We use 3 guard statements aboce to verify that the number is not too large, small and is unique. If any of these conditions are not
    met, the appropriate error is thrown using the throw keyword.
    
    The second method is the getPlayerByNumber() method. This method will attempt to retrieve the baseball player that is assigned
    a given number. If no player is assigned that number, this method will throw a NumberDoesNotExist error.
 
    We have added the throws keyword to this method definition as well; however, this method also has a return type. When we use a
    throws keyword with a return type, it must be placed before the return type in the method's definition. Within the method, we attempt
    to retrieve the baseball player with the number that is passed into the method. If it fails we throw an error.
 
    Note that if we throw an error from a method that has a return type, a return value is not required.
 */

struct BaseballTeam {
    let maxNumber = 100
    let minNumber = 0
    var players = [BaseballPlayer?]()
    
    mutating func addPlayer(player: BaseballPlayer) throws {
        guard player.number < maxNumber else {
            throw PlayerNumberError.NumberTooHigh(description: "Max number is \(maxNumber)")
        }
        guard player.number > minNumber else {
            throw PlayerNumberError.NumberTooLow(description: "Min number is \(minNumber)")
        }
        guard players[player.number] == nil else {
            throw PlayerNumberError.NumberAlreadyAssigned
        }
        players[player.number] = player;
    }
    
    func getPlayerByNumber(number: Int) throws -> BaseballPlayer {
        if let player = players[number]
        {
            return player
        }
        else
        {
            throw PlayerNumberError.NumberDoesNotExist
        }
    }
}

/// Catching errors

/**
    When an error is thrown from a function, we need to catch it in the code that called it; this is done using the do-catch block. We use
    the try keyword, within the do-catch block, to identify the places in the code that may throw an error. The do-catch block with a try
    statement takes the following:
 */

//do
//{
//    let player = try myTeam.getPlayerByNumber(number: 34)
//    print("Player is \(player.firstName) \(player.lastName)")
//}
//catch PlayerNumberError.NumberDoesNotExist
//{
//    print("No player has that number.")
//}


/**
    Any time an error is thrown within a do-catch block, the remainder of the code within the block is skipped and the code within the
    catch block, which matches the error, is executed. We do not have to include a pattern after the catch statement. If a pattern is not
    included after the catch statement, or if we put in an underscore, the catch statement will match all error conditions. For example,
    either one of the following two catch statements will catch all errors:
 */


//do {
//    //statements
//} catch {
//    //error conditions
//}

//do {
//    //statements
//} catch _ {
//    //error conditions
//}


/**
    If we want to capture the error, we can use the let keyword
 */

//do {
//    // statements
//} catch let error {
//    print("Error: \(error)")
//}

/**
    Now let's look at how we can use the catch statement, similar to a switch statement, to catch different error conditions:
 */


//do {
//    try myTeam.addPlayer(player:("David", "Ortiz", 34))
//} catch PlayerNumberError.NumberTooHigh(let description) {
//    print("Error: \(description)")
//} catch PlayerNumberError.NumberTooLow(let description) {
//    print("Error: \(description)")
//} catch PlayerNumberError.NumberAlreadyAssigned {
//    print("Error: Number already assigned")
//}

/**
    It is always good practice to make your last catch statement an empty catch statement so that it will catch any error that did not
    match any of the patterns in the previous catch statements.
 */

//do {
//try myTeam.addPlayer(player:("David", "Ortiz", 34))
//} catch PlayerNumberError.NumberTooHigh(let description) { print("Error: \(description)")
//} catch PlayerNumberError.NumberTooLow(let description) {
//      print("Error: \(description)")
//} catch PlayerNumberError.NumberAlreadyAssigned {
//     print("Error: Number already assigned")
//   } catch {
//      print("Error: Unknown Error")
//   }

/**
    We can also let the errors propagate out rather than immediately catching them. To do this, we just need to add the throws keyword
    to the function definitions. For instance, in the following example, rather than catching the error, we could let it propagate out to the
    code that called the function.
 */

//func myFunc() throws {
//try myTeam.addPlayer(player:("David", "Ortiz", 34))
//}

/**
    If we are certain that any error will not be thrown, we can call the function using a forced-try expression, which is written as try!. The
    forced-try expression disables error propagation and wraps the function call in a runtime assertion so no error will be thrown from
    this call. If an error is thrown, you will get a runtime error, so be careful when using this function.
    It is highly recommended that you avoid using the forced-try expression in production code since it can cause a runtime error and
    cause your application to crash.
    In Swift we can write an empty catch statement as so:
 */
//do {
//let player = try myTeam.getPlayerByNumber(number: 34) print("Player is \(player.firstName)
//\(player.lastName)")
//} catch {}

/**
    Swift developers came up with a way to avoid this, try? attempts to perform an operation that may throw an error and converts
    it into an optional value; therefore, the results of the operation will be nil if an error was thrown, or the result of the operation
    if there was no error thrown.
 */

//if let player = try? myTeam.getPlayerByNumber(number: 34) {
//  print("Player is \(player.firstName) \(player.lastName)")
//}

/**
    If we need to perform some cleanup action, regardless of whether we had any errors, we can use a defer statement. We use defer
    statements to execute a block of code just before the code execution leaves the current scope.
 */

func deferFunction()
{
    print("Function started")
    var str: String?
    
    defer {
        print("In defer block")
        if let s = str {
            print("str is \(s)")
        }
    }
    str = "Jon"
    print("Function finished")
}
deferFunction()

/**
    If we call this function, the first line is printed to the console, skip over the defer block, print the last finished line of the function, and
    finally would execute the defer block just before leaving the function's scope. The defer block will always be called before the
    execution leaves the current scope, even if an error is thrown. The defer statement is very useful when we want to make sure we
    perform all the necessary cleanup, even if an error is thrown. For example, if we successfully open a file to write to, we will always
    want to make sure we close that file, even if we encounter an error during the write operation.
 */

/// The availability attribute

/**
    Swift allows us to use the availibilty attribute to safely wrap code to run only when the correct version of the operating system is
    available. The availability attribute is only available when we use Swift on Apple platforms. The availability blocks essentially lets us,
    if we are running the specified version of the operating system or higher, run this code or otherwise run some other code. There are
    two ways in which we can use the availiability attribute. The first way allows us to execute a specific block of code that can be used
    with an if or guard statement. The second way allows us to mark a method or type as available only on certain platforms.
    
    The availability attribute accepts up to six comma-separated arguments, which allows us to define the minimum version of the
    operating system or application extension needed to execute our code. There arguments are as follows:
 
    iOS: This is the min iOS version that is compatible with our code
    OSX: This is the min OS X version that is compatible with our code
    watchOS: This is the min watchOS version that is compatible with our code
    tvOS: This is the min tvOS version that is compatible with our code
    iOSApplicationExtension: This is the min iOS application extension that is compatible with our code
    OSXApplicationExtension: This is the min OS X application extension that is compatible with our code
 
    After the argument, we specify the min version that is required. We only need to include the arguments that are compatible with our
    code. As an example, if we are writing an iOS application, we only need to include the iOS argument in the availability attribute.
    We end the argument list with an * (asterisk) as it is a placeholder for future versions:
 */

if #available(iOS 9.0, OSX 10.10, watchOS 2, *) {
    //Available for iOS 9, OSX 10.10, watchOS 2 or above
    print("Minimum requirements met")
   } else {
      //Block on anything below the above minimum requirements
      print("Minimum requirements not met")
}

/**
    In this example, the if statement line prevents the block of code from executing when the application is run on a system that does not
    meet the specified minimum operating system version. In this example, we also use the else to execute separate code if the
    operating system does not meet the minimum requirements.
 
    We can also restrict access toa function or a type. In the previous code, the available attribute was prefixed with the # character. To
    restrict access to a function or type, we prefix the available attribute with an @ character:
 */

@available(iOS 9.0, *)
func testAvailability() {
      // Function only available for iOS 9 or above
   }
@available(iOS 9.0, *)
struct TestStruct {
      // Type only available for iOS 9 or above
   }

/**
    In order to use the @available attribute to block access to a function or type, we must wrap the code that class that function or
    type with the #available attribute:
 */

if #available(iOS 9.0, *) {
    testAvailability()
   } else {
      // Fallback on earlier versions
}
   
