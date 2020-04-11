import Cocoa

/**
                        Swift Formatting and Style Guider
                                Chapter 17
 */

/**
    Coding styles are very personal, and every developer has his or her own preferred style. These styles can vary from language to
    language, from person to person, and also over time. The personal nature of coding styles can make it difficult to have a consistent
    and readable code base when numerous individuals are contributing to the code.
 
    While most developers might have their own preferred styles, the recommended or preferred style between languages can vary. As
    an example, in C#, when we name a method or function, it is preferred that we use PascalCase, which is similar to CamelCase except
    the first letter is capitalized. In most other languages, such as C, Objective-C, and Java, it is also recommended that we use
    CamelCase, where the first letter is lowercase.
    
    The best applications are coded so they are easy to maintain, and the code is easy to read. It is hard for large projects and
    companies with many developers to have code that is easy to maintain and read if every developer uses their own coding style. This
    is why companies and projects with multiple developers usually adopt programming style guides for each language that they use.
 
    A programming style guide defines a set of rules and guidelines that a developer should follow while writing applications with a
    specific language within a project or company. These style guides can differ greatly between companies or projects and reflect how a
    company or project expects code to be written. These guides can also change over time. It is important to follow these style guides to
    maintain a consistent code base.
    
    A lot of developers do not like the idea of being told how they should write code, and claim that as long as their code functions
    correctly, it shouldn't matter how they format their code. This type of philosophy doesn't work in a coding team or in a sports team, like
    a basketball team. What do you think would happen if all the players on a basketball team believed that they could all play the way
    they wanted to and the team was better when they did their own thing? That team would probably lose the majority of its games. It is
    impossible for a basketball team (or any sports team, for that matter) to win most of its games unless its members are working
    together. It is up to the coach to make sure that everyone is working together and executing the same game plan, just like it is up to
    the team leader of the development project to make sure all the developers are writing code according to the adopted style guide.
 */

/// Your Style Guide

/**
    The style guide that we define in this book is just a guide. It reflects the author's opinion on how Swift code should be written and is
    meant to be a good starting point for creating your own style guide. If you really like this guide and adopt it as it is, great. If there are
    parts that you do not agree with and you change them within your guide, that is great as well. The appropriate style for you and your
    team is the one that you and your team feel comfortable with, and it may or may not be different from the guide in this book. Don't be
    afraid to adjust your style guide as needed.
    One thing that is noticeable in the style guide within this chapter, and most good style guides, is that there is very little explanation
    about why each item is preferred or not preferred. Style guides should give enough details so that the reader understands the
    preferred and non-preferred methods for each item, but should also be small and compact to make them easy and quick to read. If a
    developer has questions about why a particular method is preferred, they should bring that concern up with the development group.
    With that in mind, let's get started with the guide.
 */

/// Do not use semicolons at the end of statements
/// Do not use parentheses for conditional statements
/// Naming:

/**
    Custom types should have a descriptive name in PascalCase:
 
    // Proper Naming Convention
       BaseballTeam
       LaptopComputer
    //Non-Proper Naming Convention
        baseballTeam
    //Starts with a lowercase letter Laptop_Computer uses an underscore
 */

/**
    Functions, methods constants, variables, should have a descriptive name in camelCase:
 
    //Proper Naming Convention
       getCityName
       playSound
    //Non-Proper Naming Convention
    get_city_name //All lowercase and has an underscore
    PlaySound //Begins with an upper case letter
 */

/// Indenting width in XCode by default is defined by 4 spaces, and a tab width is also defined as four spaces. We should add an
/// extra blank line between functions/methods; should also use a blank line to separate functionality within a function or method.

/// Comments

/**
    We should use comments as needed to explain how and why our code is written. We should use block comments before custom
    types and functions. We should use double slashes to comment our code in one line. When we are commenting methods, we should
    also use the documentation tags, which will generate documentation in Xcode, as shown in the preceding example. At a minimum,
    we should use the following tags if they apply to our method:
        Parameter: This is used for parameters
        Returns: This is used for what is returned
        Throws: This is used to document errors that may be thrown
*/

/// Using the self keyword

/**
    Since Swift does not require us to use the self keyword when accessing properties or invoking methods of an object, we should
    avoid using it unless we need to distinguish between an instance property and local variables.
 */

/// Constants and variables

/**
    The difference between constants and variables is that the value of a constant never changes, whereas the value of a variable
    may change. Wherever possible, we should define constants rather than variables.
    One of the easiest ways of doing this is by defining everything as a constant by default, and then changing the definition to a
    variable only after you reach a point in your code that requires you to change it. In Swift, you will get a warning if you define
    a variable and then never change the value within your code.
 */

/// Optional types

/**
    Only use optional types when absolutely necessary. If there is no absolute need for a nil value to be assigned to a variable,
    we should not define it as an optional.
 */

/// Using optional binding

/**
    We should avoid forced unwrapping of optionals, as there is rarely any need to do this. We should prefer optional binding
    or optional chaining over forced unwrapping.
    The following examples show the preferred and non-preferred methods where the myOptional variable is defined as an optional:

*/

//Preferred Method Optional Binding
//   if let value = myOptional {
//           code if myOptional is not nil
//   } else {
//           code if myOptional is nil
//}
//Non-Preferred Method
//   if myOptional != nil {
//           code if myOptional is not nil
//   } else {
//                code if myOptional is nil
//}

/**

    If there are several optionals that we need to unwrap, we should include them in the same if-let or guard statement, rather
    than unwrapping them on separate lines. There are times, however, when our business logic may require us to handle nil
    values differently and this may require us to unwrap the optionals on separate lines. The following examples show the preferred
    and non-preferred methods:
 */

//Preferred Method Optional Binding
//if let value1 = myOptional1, let value2 = myOptional2 {
       // code if myOptional1 and myOptional2 is not nil
//    } else {
       // code if myOptional1 and myOptional2 is nil
//}
//Non-Preferred Method Optional Binding
//if let value1 = myOptional1 {
//       if let value2 = myOptional2 {
          // code if myOptional is not nil
//       } else {
          // code if myOptional2 is nil
//    }
//}
//else {
    // code if myOptional1 is nil
//}

/// Using optional chaining instead of optional binding for multiple unwrapping

/**
    When we need to unwrap multiple layers, we should use optional chaining over multiple optional binding statements.
    The following example shows the preferred and non-preferred methods:
 */

//Preferred Method
//if let color = jon.pet?.collar?.color {
//        print("The color of the collar is \(color)")
//   } else {
//        print("Cannot retrieve color")
//}
//Non-Preferred Method
//if let tmpPet = jon.pet, let tmpCollar = tmpPet.collar{
//print("The color of the collar is \(tmpCollar.color)") } else {
// print("Cannot retrieve color")
//}

/// Using type inference

/**
    Rather than defining variable types, we should let Swift infer the type. The only time we should define the variable or constant
    type is when we are not giving it a value while defining it. Let's look at the following code:
 
    //Preferred method
    var myVar = "String Type" //Infers a String type
    var myNum = 2.25 //Infers a Double type
    //Non-Preferred method
    var myVar: String = "String Type"
    var myNum: Double = 2.25
 */

/// Using shorthand declaration for collections

/**
    When declaring native Swift collection types, we should use the shorthand syntax, and, unless absolutely necessary,
    we should initialize the collection. The following example shows the preferred and non-preferred methods:

    //Preferred Method
    var myDictionary: [String: String] = [:]
    var strArray: [String] = []
    var strOptional: String?

    //Non-Preferred Method
    var myDictionary: Dictionary<String,String> var strArray: Array<String>
    var strOptional: Optional<String>
 */

/// Using switch rather than multiple if statements

/**
    Wherever possible, we should prefer to use a single switch statement over multiple if statements.
    The following example shows the preferred and non- preferred methods:
 */

//Preferred Method
//let speed = 300_000_000
//switch speed {
//case 300_000_000: print("Speed of light") case 340:
//          print("Speed of sound")
//       default:
//          print("Unknown speed")
//}
//Non-preferred Method let speed = 300_000_000 if speed == 300_000_000 {
//          print("Speed of light")
//   } else if speed == 340 {
//          print("Speed of sound")
//   } else {
//    print("Unknown speed")
//}

/// Don't leave commented-out code in your application

/**
    If we comment out a block of code while we attempt to replace it, once we are comfortable with the changes we should remove the
    code that we commented out. Having large blocks of code commented out can make the code base look messy and harder to follow.
 */
