import Cocoa

/**
                              Optional Types
                                Chapter 3
 */

/**
    When we declare variables in Swift, they are by default non-optional, which means that they must contain a valid, non-nil value.
    If we try to set a non optional variable to nil, it will result in an error.
 */

var message: String = "My String"
// message = nil this is an error
/**
    It is very important to understand that nil in Swift is very different from nil in Objective-C or other C-based languages. In these
    languages, nil is a pointer to a non-existent object; however in Swift a nil value is the absence of a value. This concept is very
    important to fully understand optionals in Swift.
    A variable defined as an optional can contain a valid value or it can indicate the absence of a value. We indicate the absence
    of a value by assigning it a special nil value. Optionals of any type can be set to nil, where as in Objective-C, only objects can
    be set to nil.
 */

var myString: String?

/**
    The question mark at the end indicates that the myString variable is an optional. We read this line of code as saying that the
    myString variable is an optional type, which may contain a value of the string type or may contain no value.
    Optionals are a special type in Swift. When we define the myString variable, we actually defined it as an optional type. To
    understand this, let's look at some more code:
 */

var myString1: String?
var myString2: Optional<String>

/**
    These two declarations are equivalent. Both lines declare an optional type that may contain a string type or may lack a value.
    The optional type is an enumeration with two possible values, None and Some(T), where T is the generic associated value of
    the appropriate type. If we set the optional to nil, it will have a value of None, and if we set a value, the optional will have a value
    of Some with an associated value of the appropriate type.
        Internally an optional is defined as follows:
    Optionals are useful and important in Swift because with optionals, Swift is able to detect problems such as attempting to call
    a method function from an uninitialized object at compile-time and alert us before it becomes a runtime issue.
    If we expect a variable or object to always contain a value prior to using it, we will declare the variable as a non-optional (default).
    Then we will recieve an error if we try to use it prior to initializing it.
 */

var thisError: String
// print(thisError)

/**
    If a variable is declared as an optional, it is good programming practice to verify that it contains a valid value before attempting
    to use it. We should only declare a variable optional if there is a valid reason for the variable to contain no value. This is the reason
    Swift declares variables as non-optional by default. By default, declared optionals are set to nil. The key to using optionals is to always
    verify that they contain a valid value prior to accessing them. We use the term unwrapping to refer to the process of retrieving a value
    from an optional.
 */

/**
    To unwrap or retrieve the value of an optional, we place an exclamation mark (!) after the variable name. This is called forced
    unwrapping. Forced unwrapping, in this manner, is very dangerous and should be used only if we are certain that the variable
    contains a non-nil value. Otherwise, if it does contain a nil value, we will get a runtime error and the application will crash.
 
    When we use the exclamation point to unwrap an optional, we are telling the compilerthatwe know the optional contains a value,
    so go ahead and give it to us.
 */

var myOptional: String?
myOptional = "test"
if myOptional != nil {
    let test: String = myOptional!
    print(test)
}

/**
    Note that the compiler will not alert us to an issue because we are using the exclamation point to unwrap the optional, therefore,
    the compiler assumes that we know what we are doing and will happily compile the code for us. We should verify that the optional
    contains a valid value prior to unwrapping it like the prior code does.
    Unwrapping optionals, is not optimal, andis not recommended that optionals be unwrapped in this manner. We can combine
    verification and unwrapping in one step, called optional binding. With optional binding, we perform a check to see whether the
    optional contains a valid value and, if so, unwrap it into a temporary variable or constant. This is all performed in one step.
    Optional binding is performed with the if or while conditional statements. It takes the following format if we want to put the
    value of the optional in a constant (switch let with var to set into a variable):
 */

var myString3: String?
myString3 = "Space, the final frontier"
if let tempVar = myString3 {
    print(tempVar)
}
else {
    print("No value")
}

/**
    We are able to use optional binding to unwrap multiple optionals within the same optional binding line:
    If any of the 3 optionals are nil, the whole optional binding statement fails. It is also perfectly acceptable with optional
    binding to assign the value to a variable of the same name:
 */
//      if let tmp1 = optional1, let tmp2 = optional2, let tmp3 = optional3 {
//      ...
//      }

if let myOptional = myOptional {
    print(myOptional)
}
else {
    print("myOptional was nil")
}

/**
    One thing to note is that the temporary variable is scoped only for the conditional block and cannot be used outside it.
    Using optional binding is a lot cleaner and easier than manually verifying that the optional has a value and using forced
    unwrapping to retrieve the value of the optional.
 */

/**
    We can define a whole tuple as an optional or any of the elements within a tuple as an optional. It is especially useful to use
    optionals with tupes when we return a tuple from a function or method. This allows us to return part (or all) of the tuple as nil.
 */

var tuple1: (one: String, two: Int)? // entire tuple is an optional type
var tuple2: (one:String, two: Int?) // the first value is a non-optional

/**
    Optional chaining allows us to call properties, methods, and subscripts on an optional that might be nil. If any of the chained
    values returns nil, the return value will be nil.  The following example shows optional chaining using a car object. In this example,
    if either the car or tires optional variables are nil, the tireSize variable will be nil, otherwise the tireSize variable will be equal
    to the tireSize property:
 */
//      var tireSize = car?.tires?.tireSize

/**
    The nil coalescing operator is similar to the ternary operator; the nil coalescing operator attempts to unwrap an optional, and
    if it contains a value, it will return that value, or a default value, as shown in the following code, if the optional is nil.
 */

var defaultName = "Vinny"

var optionalA: String?
var optionalB: String?

optionalB = "Buddy"

var nameA = optionalA ?? defaultName // set to defaultName
var nameB = optionalB ?? defaultName //  set to optionalB

/// Shorthand for ternary operator as follows:
/// var nameC = optionalA != nil ? optionalA! : defaultName
