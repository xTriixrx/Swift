import Cocoa

/**
                             Custom Subscripting
                                Chapter 12
*/

/**
    Subscripts, in the Swift language, are used as shortcuts for accessing elements of a collection, list or sequence. We can use them
    in our custom types to set or retrieve the values by index rather than using getter and setter methods. Subscripts, if used correctly
    can significantly enhance the usability and readability of our custom types.
 
    We can define mutiple subscripts for a single type. When types have multiple subscripts, the appropriate subscript will be chosen
    based on the type of index passed in with the subscript. We can also set external parameter names for our subscripts that can help
    distinguish between subscripts that have the same types.
    
    We use custom subscripts just like we use subscripts for arrays and dictionaries. For example, to access an element in an array, we
    use the Array[index] syntax. When we define a custom subscript for our custom types, we also access them with the same syntax.
 
    When creating custom subscripts, we should try to make them feel like a natural part of the class, structure, or enumeration.
 
    The following example shows how to use subscripts to access and change the value of an array:
 */

var arrayOne = [1, 2, 3, 4, 5]
print(arrayOne[3])
arrayOne[3] = 10
print(arrayOne[3])

/// Creating and using custom subscripts

/**
    Subscripts in our custom types should follow the same set by the Swift language itself, so other developers that use our types are
    not confused by the implementation. The key to knowing when to use subscripts, and when not to is to understand how they will be
    used.
 
    Let's look at how to define a subscript that is used to read and write to a backend array. Reading and writing to a backend storage
    class is one of the most common uses of custom subscripts; however as we will see later we do not need to have a backend
    storage class.
 */

class MyNames {
    private var names = ["Jon", "Kim", "Kailey", "Kara"]
    subscript(index: Int) -> String {
        get
        {
            return names[index]
        }
        set
        {
            names[index] = newValue
        }
    }
}

/**
    As you can see, the syntax for subscripts is similar to how we define properties within a class using the get and set keywords. The
    difference is that we declare the subscript keyword. We then specify one or more inputs and the return type. We can now use the
    custom subscript just like we used the subscripts with arrays and dictionaries:
 */

var nam = MyNames()
print(nam[0])
nam[0] = "Buddy"
print(nam[0])

/**
    While we could make the names array available for external code to read and write directly, this would lock our code into using an
    array to store the data. In the future, if we wanted to change the backend storage mechanism to a dictionary object, or even a
    SQLite database, we would have a hard time doing so, because all of the external code would also have to change. Subscripts
    are very good at hiding how we store information within our custom types; therefore external code that uses these custom types
    does not rely on specific storage implementations.
 
    If we gave direct access to the names array, we would also be unable to verify that the external code was inserting valid information
    into the array. With subscripts, we can add validation to our setters to verify that the data being passed in is correct before adding it
    to the array. This can be very useful when we are creating a framework or a library.
 
 */

/// Read-only custom subscripts

/**
    We can also make the subscript read-only by either not declaring a setter method within the subscript or by not explicitly declaring a
    getter or setter method.
 */

//subscript(index: Int) -> String {
//    return names[index]
//}

/**
    The following example shows how to declare a read-only proeprty by only declaring a getter:
 */

//subscript(index: Int) -> String {
//    get
//    {
//        return names[index]
//    }
//}

/**
    One thing to not is that write-only subscripts are not valid in Swift.
 */

/// Calculated subscripts

/**
    We can also use subscripts in a similar manner to the computed properties:
 */

struct MathTable {
    var num: Int
    subscript(index: Int) -> Int {
        return num * index
    }
}

/**
    In this example, we use the value of the subscript to calculate the return value:
 */

var table = MathTable(num: 5)
print(table[4])

/// Subscript  values

/**
    We are not limited to just integers as subscripts:
 */

struct Hello {
    subscript(name: String) -> String {
        return "Hello \(name)"
    }
}

var hello = Hello()
print(hello["Vinny"])

/// External names for subscripts

/**
    We can have multiple subscript signatures for our custom types. The appropriate subscript will be chosen based on the type of index
    passed into the subscript. There are times when we may wish to define multiple subscripts that have the same type, For this, we
    could use external names in a similar way to how we define external names for the parameters of a function.
 */

struct MathTable1 {
    var num: Int
    subscript(multiply index: Int) -> Int {
        return num * index
    }
    subscript(add index: Int) -> Int {
        return num + index
    }
}

var table1 = MathTable1(num: 5)
print(table1[multiply: 4])
print(table1[add: 4])

/**
    Using external names within our subscript is very useful if we need multiple subscripts of the same type. I would not recommend
    using external names unless they are needed to distinguish between multiple subscripts.
 */

/// Multidimensional subscripts

/**
    Let's look at how we could implement a Tic-Tac-Toe board using a multidimensional array and multidimensional subscripts:
 */
struct TicTacToe {
    var board = [["","",""],["","",""],["","",""]]
    subscript(x: Int, y: Int) -> String {
        get
        {
            return board[x][y]
        }
        set
        {
            board[x][y] = newValue
        }
    }
}

var board = TicTacToe()
board[1,1] = "x"
board[0,0] = "o"

/**
    We are not limited to using only one type for our multidimensional subscript. We can also add external names for our multidimensional
    subscript types to help identify what values are used for and to distinguish between subscripts that have the same types. Let's take
    a look at how to use multiple types and external names with subscripts, by creating a subscript that will return an array of string
    instances based on the values of the subscript:
 */

struct SayHello {
    subscript(messageText message: String, messageName name: String, number number: Int)
        -> [String] {
        var retArray: [String] = []
        for _ in 0 ..< number {
            retArray.append("\(message) \(name)")
        }
        return retArray
    }
}

/**
    This defines a subscript with three elements. Each element has an external name and an internal name. We use the first two elements
    to create a message for the user that will repeat the number of times defined by the last number element:
 */

var message = SayHello()
var ret = message[messageText: "Bonjour", messageName: "Vinny", number: 5]

/// Dynamic member lookup

/**
    Dynamic member lookup enables a call to a property that will be dynamically resolved at runtime. Let's say that we had a structure
    that represented a baseball team. This structure has a property that represents the city the team was from and another property
    that represented the nickname of the team.
 */

//struct BaseballTeam {
//    let city: String
//    let nickName: String
//}

/**
    In this structure, if we wanted to retrieve the full name of the baseball team, including the city and nickname, we could easily create
    a method like:
 */

//func fullname() -> String {
//  return "\(city) \(nickName)"
//}

/**
    This is how it would be done in most OOP languages; however, we can create a much cleaner interface using dynamic member
    lookups. To use dynamic member lookups, the first thing we need to do is add the @dynamicMemberLookup attribute when we
    define the BaseballTeam structure. We need to add the lookup to the structure. This is done by implementing the
    subscript(dynamicMember: ) subscript.
 */

@dynamicMemberLookup
struct BaseballTeam {
    let city: String
    let nickName: String
    let wins: Double
    let losses: Double
    let year: Int
    
    subscript(dynamicMember key: String) -> String {
        switch key {
            case "fullname":
                return "\(city) \(nickName)"
            case "percent":
                let per = wins/(wins+losses)
                return String(per)
            default:
                return "Unknown request"
        }
    }
}

var redsox = BaseballTeam(city: "Boston", nickName: "Red Sox", wins: 108, losses: 54, year: 2005)
print("The \(redsox.fullname) won \(redsox.percent) of their games in \(redsox.year)")

/**
    Notice how we are able to access both fullname and percent from the instance of BaseballTeam as if they were normal properties.
    This makes our code much cleaner and easier to read. However, there is one thing to keep in mind when using lookups like this:
    there is no way to control what keys are passed into the lookup.
 
    In the previous example, we could just as easily have called flower, or dog with no warning from the compiler. This is why there is a
    lot of controversy attached to dynamic member lookup, because there is no compile time warning if you do something wrong.
 
    If you use dynamic member lookup, make sure you verify the key and handle any instances when something unexpected is sent
    as we did with the previous example using the default case.
 */

/// When not to use a custom subscript

class MyNames1 {
    private var names:[String] = ["Jon", "Kim", "Kailey", "Kara"]
    var number: Int {
        get
        {
            return names.count
        }
    }
    subscript(add name: String) -> String {
        names.append(name)
        return name
    }
    subscript(index: Int) -> String {
        get
        {
            return names[index]
        }
        set
        {
            names[index] = newValue
        }
    }
}

/**
    Let's say that within our application we display this list of names and allow users to add names to it. Within the MyNames class, we
    then define the following subscript, which allows us to append a new name to the array:
 */

//subscript(add name: String) -> String {
//    names.append(name)
//    return name
//}

/**
    This would be a poor use of subscripts, because its usage is not consistent with how subscripts are used within the Swift language
    itself. This might cause confusion when the class is used. It would be more appropriate to rewrite this subscript as a function.
        
    Remember, when you are using custom subscripts, make sure that you are using them appropriately.
 */
