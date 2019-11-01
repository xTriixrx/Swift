import Cocoa
/**
        What Playgrounds are not:
    1. Playgrounds should not be used for performace testing
    2. Playgrounds do not support on-device execution
 */

var str = "Hello, playground"
var image = NSImage(named: "codewallpaper.png")

var j = 1
for i in 1...5 {
    j += i
}

// Comments can be either //, /** ... */, or ///
// However for documentation, must use /// or /** ... */

// To document, generally use fields that XCode recognizes such as
// parameter (parameter {param name}:), return (return:), throws (throws:)

/**
  The myAdd function will take two integers, add them together and return the sum
 
 - parameter first: The first integer to add
 -  parameter second: The second integer to add
 - returns: The sum of the two integers
 - throws: Our error
 */
func myAdd(first: Int, second: Int) -> Int {
    // add the two integers together
    let sum: Int = first + second
    return sum
}

myAdd(first: 5, second: 10)

/**
  The myAdd2 function will take two integers, add them together and return the sum.
 
 - parameter first: The first integer to add
 - parameter second: The second integer to add
 - returns: The sum of the two integers
 - throws: Our error
 */

func myAdd2(first: Int, second: Int) -> Int {
    // add the two integers together
    let sum: Int = first + second
    return sum
}

myAdd2(first: 5, second: 10)
