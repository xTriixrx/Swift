import Cocoa

/**
                            Working with Closures
                                Chapter 13
*/

/**
    Closures are self-contained blocks of code that can be passed around and used throughout our application. We can think of the Int
    type as a type that contains an integer, and a String as a type that contains a string. In this context, a closure can be thought of as a
    type that contains a block of code. This means that we can assign closures to a variable, pass them as arguments to functions, and
    return them from a function.
 
    Closures have the ability to capture and store references to any variable or constant from the context in which they were defined. This
    is known as closing over the variables or constants and, for the most part, Swift will handle the memory management for us. The
    only exception is in creating a strong reference cycle, and we will look at how to resolve this in Chapter 16, Memory Management.
 
    Closure in Swift are similar to blocks in Objective-C; however, closures in Swift are a lot easier to use and understand. Lets look at the
    syntax used to define a closure in Swift:
 */

//{
// (< # parameters # > ) -> < # return-type # >
// in < # statements # >
//}

/**
    The syntax used to create a closure looks very similar to the syntax we used to create functions and in Swift, global and nested
    functions are closures. The biggest difference in the format between closures and functions is the in keyword. The in keyword
    is used in place of curly brackets to separate the definition of the closures parameter and return types from the body of the closure.
 
 */

let clos1 = { () -> Void in
    print("Hello World")
}

/**
    In this example, we create a closure and assign it to the clos1 constant. Since there are no parameters defined between the
    parentheses, this closure will not accept any parameters. Also the return type is defined as Void; therefore this closure doesn't return
    any value. There are many ways to use closures; in this example, all we want to do is execute it:
 */

clos1()

let clos2 = {
    (name: String) -> Void in
        print("Hello \(name)")
}

clos2("Vinny")

/**
    Our original definition of closures stated that closures are self-contained blocks of code that can be passed around and used
    throughout our application code. This tells us that we can pass our closure from the context that they were created in to other
    parts of our code. Lets look how we can pass our clos2 closure into a function:
 */

func testClosure(handler: (String) -> Void) {
    handler("Vinny")
}

/**
    We define the function just like we would any other function; however, in the parameter list, we define a parameter named handler,
    and the type defined for the handler parameter is (String) -> Void. If we look closely, we can see that the (String) -> Void definition
    of the handler paremeter matches the parameter and return types that we defined for the clos2 closure. This means that we can
    pass the clos2 closure into the function.
 */

testClosure(handler: clos2)

/**
    We call the testClosure() function just like any other function, and the closure that is being passed in looks like any other variable.
    Since the clos2 closure is executed in the testClosure() function. As we will see later in this chapter, the ability to pass closures to
    functions is what makes closures so exciting and powerful. Lets look at how to return a value from a closure:
 */

let clos3 = {
    (name: String) -> String in
        return "Hello \(name)"
}

var hello = clos3("Vinny")

/**
    Those who are familiar with Objective-C can see that the format of closures in Swift is a lot cleaner and easier to use. The syntax for
    creating closures that we have seen so far is pretty short; however we can shorten it even more.
 */

/// Shorthand syntax for closures

/**
    In this section, we will look at a couple of ways to shorten the syntax. Using the shorthand syntax for closures is really a matter
    of personal preference. A lot of developers like to make their code as small and compact as possible, and they take great pride in
    doing so. However, at times this can make the code hard to read and understand for other developers.
 
    The first shorthand syntax for closures we are going to look at is one of the most popular, which is the syntax we saw when we were
    using algorithms with arrays in Chapter 4. This format is mainly used when we want to send a really small (usually one line) closure
    to a function, like we did with the algorithms for arrays. Before we look at this shorthand syntax, we need to write a function that
    will accept a closure as a parameter:
 */

func testFunction(num: Int, handler: () -> Void) {
    for _ in 0 ..< num {
        handler()
    }
}

/**
    We can pass the closure in either the normal way or in a shorthand way:
 */
let testClos = {
    () -> Void in
        print("Hello from standard syntax")
}
testFunction(num: 5, handler: testClos)

testFunction(num: 5, handler: {print("Hello from Shorthand closure")})

/**
    In this example, we created the closure inline within the function call, using the same syntax that we used previously. The closure
    is placed in between two curly brackets ({}). When this code is executed, it will print out the Hello from shorthand closure message
    five times on the screen.
 
    Having the closure as the final parameter allows us to leave off the label when calling the function. This example, gives us both
    compact and readable code. Let's look at how to use parameters with this shorthand syntax. We will begin by creating a new
    function that will accept a closure with a single parameter.
 */

func testFunction2(num: Int, handler: (_ : String) -> Void) {
    for _ in 0 ..< num {
        handler("Me")
    }
}
testFunction2(num: 5, handler: {_ in print("Hello from Shorthand closure")})
/**
    In testFunction2, we define the closure like this: (_ : String) -> Void. This definition means that the closure accepts one parameter
    and does not return any value. Now lets look at how to use the same shorthand syntax to call this function:
 */

testFunction2(num: 5) {
    print("Hello from \($0)")
}

/**
    The difference between this closure definition and the previous one is $0. The $0 parameter is shorthand for the first parameter
    passed into the function. If we execute this code, it prints out the Hello from Me message five times. Using the dollar sign followed
    by a number with inline closures allows us to define the closure without having to create a parameter list in the definition. The number
    after the dollar sign defines the position of the parameter in the parameter list. Let's examine this format a bit more, because we are
    not limited to only using the dollar sign and number shorthand format with inline closures. This shorthand syntax can also be used to
    shorten the closure definition by allowing us to leave the parameter names off. The following example demonstrates this:
 */

let clos5: (String, String) -> Void = {
    print("\($0) \($1)")
}

/**
    In this example, the closure has two string parameters defined; however we do not give them names. The parameters are defined
    like this: (String, String). We can then access the parameters within the body of the closure using $0 and $1. Also, note that the
    closure definition is after the colon (:), using the same syntax that we use to define a variable type rather than inside the curly
    brackets. When we use anonymous arguments, this is how we would define the closure.
 */

clos5("Hello", "Carly")

/**
    Since Hello is the first string in the parameter list, it is accessed with $0, and $1 for Carly. Rather than defining the return type
    as Void, we can use parentheses, as the following example shows:
 */

let clos6: () -> () = {
    print("Howdy")
}

/**
    In this example, we define the closure as () -> (). This tells Swift that the closure does not accept any parameters and also does
    not return a value.
 */

clos6()

/**
    In this last example, we will demonstrate how we can return a value from a closure without the need to include the return keyword.
    If the entire closure body consists of only a single statement, we can omit the return keyword, and the result of the statement
    will be returned:
 */

let clos7 = { (first: Int, second: Int) -> Int in first + second }

/**
    In this example above, the closure accepts two parameters of the integer type and will return an instance of the integer type. The
    only statement within the body of the closure adds the first and second parameter. Notice how we do not include the return keyword
    before the statement. Swift will see that this is a single statement closure and will automatically return the results, just as if we did
    put the return keyword there. We do need to make sure the result type of our statement matches the return type of the closure.
 */

/// Using closures with Swift's array algorithms

/**
    In this section, we will primarily be using the map algorithm for consistency purposes; however we can use the basic ideas shown
    with any of the algorithms.
 */

let guests = ["Vinny", "Carly", "Kailey", "Kara"]

guests.map { name in  print("Hello \(name)") }

/**
    Since the map algorithm applies the closure to each item of the array, this example will print out a greeting for each name within
    the array. Using the shorthand syntax that we saw previously we could reduce the statement above to the following:
 */

guests.map { print("Hello \($0)") }

/**
    This is one of the few times where shorthand syntax may be easier to read than the standard syntax. Now lets say we want
    to return the messages:
 */

var messages = guests.map {
    (name: String) -> String in
        return "Welcome \(name)"
}

for message in messages {
    print("\(message)")
}

/**
    The preceding examples showed how to add a closure to the map algorithm inline. This is good if we only had one closure that we
    wanted to use with the map algorithm, but what if we had more than one closure that we wanted to use, or if we wanted to use
    the closure multiple times or reuse it with different arrays? For this, we could assign the closure to a constant or variable and then
    pass in the closure, using its constant or variable name, as needed.
 */

let greetGuest = {
    (name: String) -> Void in
        print("Hello guest named \(name)")
}

let sayGoodbye = {
    (name: String) -> Void in
        print("Goodbye \(name)")
}

guests.map(greetGuest)
guests.map(sayGoodbye)

/**
    We could do a lot in a closure, for example we can filter the array within the closure:
 */

let greetGuest2 = {
    (name: String) -> Void in
    if(name.hasPrefix("K")) {
        print("\(name) is on the guest list")
    }
    else {
        print("\(name) was not invited")
    }
}
guests.map(greetGuest2)

/**
    As mentioned earlier in this chapter, closures have the ability to capture and store references to any variable or constant from the
    context in which they were defined. Let's say that we have a function that contains the highest temperature for the last seven days
    at a given location and this function accepts a closure as a parameter:
 */

func temperatures(calculate: (Int) -> Void) {
    var tempArray = [72,74,76,68,70,72,66]
    tempArray.map(calculate)
}

/**
    The key to using a closure correctly in this situation is to understand that the temperatures function does not know or care about
    what is going on inside the calculate closure. Also, be aware that the closure is also unable to update or change items within the
    function's context, which means closures cannot change any other variable within the temperature's function; however it can update
    variables in the context that it was created in.
    Let's look at the function that we will create the closure in:
 */

func testFunction() {
    var total = 0
    var count = 0
    let addTemps = {
        (num: Int) -> Void in
            total += num
            count += 1
    }
    temperatures(calculate: addTemps)
    print("Total: \(total)")
    print("Count: \(count)")
    print("Average: \(total/count)")
}

testFunction()

/**
    In this function, we begin by defining two variables, named total and count, where both variables are of the integer type. We then
    create a closure named addTemps that will be used to add all the temperatures from the temperatures function together. The
    addTemps closure will also count how many temperatures there are in the array. To do this, the addTemps closure calculates the
    sum of each item in the array and keeps the total in the total variable. Notice that neither the total nor count variables are defined
    within the closure; however, we are able to use them within the closure because they were defined in the same context as the closure.
 */

/// Changing functionality

/**
    Closures also give us the ability to change the functionality of types on the fly. In Chapter 10 Generics, we saw that generics give
    us the abilty to write functions that are valid for multiple types. With closures, we are able to write functions and types whose
    functionality can change, based on the closure that is passed in.
 */

struct TestType {
    typealias getNumClosure = ((Int, Int) -> Int)
    
    var numOne = 5
    var numTwo = 8
    var results = 0
    
    mutating func  getNum(handler: getNumClosure) -> Int {
        results = handler(numOne, numTwo)
        print("Results: \(results)")
        return results
    }
}

/**
    We begin this type by defining a typealias of our closure, which is named getNumClosure. Any closure that is defined as a
    getNumClosure closure will take two integers and return a single integer. Within this closure, we assume that it does something
    with the integers that we pass in to get the value to return, but it really doesn't have to do anything with the integers. To be honest,
    this class doesn't really care what the closure does as long as it conforms to the getNumClosure type.
 
    We also define a method named getNum(). This method accepts a closure that conforms to the getNumClosure type as its only
    parameter. Within the getNum() method, we execute the closure by passing in the numOne and numTwo variables, and the integer
    that is returned is put into the results structure variable. Now lets look at several closures that conform to the getNumClosure type:
 */

var max: TestType.getNumClosure = {
    if $0 > $1 {
        return $0
    }
    else {
        return $1
    }
}

var min: TestType.getNumClosure = {
    if $0 < $1 {
        return $0
    }
    else {
        return $1
    }
}

var multiply: TestType.getNumClosure = {
    return $0 * $1
}

var second: TestType.getNumClosure = {
    return $1
}

var answer: TestType.getNumClosure = {
    var _ = $0 + $1
    return 42
}

/**
    In the answer closure, we have an extra line that looks like it doesn't have a purpose with the wildcard var. We do this
    diliberately because just the return of 42 is not valid because we get an error of: contextual type for closure argument list expects
    two arguments, which cannot be implicitly ignored. Otherwise meaning Swift will not let us ignore the expected parameters within
    the body of the closure.
 */

var myType = TestType()
myType.getNum(handler: max)
myType.getNum(handler: min)
myType.getNum(handler: multiply)
myType.getNum(handler: second)
myType.getNum(handler: answer)

/// Selecting a closure based on results

/**
    In this final example, we will pass two closures to a method, and then, depending on some logic, one or possibly both closures will
    be executed. Generally, one of the closures is called if the method was successfully executed and the other is called if the
    method fails.
 */

class TestType1 {
    typealias ResultsClosure = ((String) -> Void)
    
    func isGreater(numOne: Int, numTwo: Int, successHandler: ResultsClosure,
                   failureHander: ResultsClosure) {
        if numOne > numTwo {
            successHandler("\(numOne) is greater than \(numTwo)")
        }
        else {
            failureHander("\(numOne) is not greater than \(numTwo)")
        }
    }
}

/**
    We begin by creating a typealias that defines a closure that we will use for both the success and failure closures. This example
    also illustrates why you should use a typealias rather than retyping the closure definition. It saves us a lot of typing and prevents
    us from making mistakes. In this example, if we do not use a typealias, we would need to retype the closure definition four times,
    and if we need to change the closure definition, we would need to change it in all of those spots. With a type alias, we only need
    to type the closure definition once and then use the alias throughout the remaining code.
 
    We then create a method named isGreater which takes two integers and two closures. The first closure is for success and the second
    is for failure of the condition defined:
 */

var success: TestType1.ResultsClosure = {
    print("Success: \($0)")
}

var failure: TestType1.ResultsClosure = {
    print("Failure: \($0)")
}

var test = TestType1()
test.isGreater(numOne: 8, numTwo: 6, successHandler: success, failureHander: failure)
test.isGreater(numOne: 6, numTwo: 8, successHandler: success, failureHander: failure)

/**
    This use case is really good when we call asynchronous methods, such as loading data from a web service. If the web service call
    was successful, the success closure is called otherwise failure closure is called.
 
    One big advantage of using closures like this is that the UI does not freeze while we wait for the asynchronous call to complete. This
    also involves a concurrency piece, which is covered next chapter. As an example imagine we tried to retrieve data from a web service,
    as follows:
 
    var data = myWebClass.myWebServiceCall(params)
 
    Our UI would freeze while we wait for the response, or we would have to make the call in a separate thread so that the UI would
    not hang. With closures, we pass the closures to the networking framework and rely on the framework to execute the appropriate
    closure when it is done. This relies on the framework to implement concurrency correctly, to make the calls asynchronously, but
    a decent framework should handle that for us.
 */
