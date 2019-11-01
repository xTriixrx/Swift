import Cocoa

print("Hello World")

var name = "Vinny"
var language = "Swift"

var message1 = "Welcome to the wonderful world of "
// \() is the escape character for inserting variables/constants in strings
var message2 = "\(name), Welcome to the wonderful world of \(language)!"

print(message2)
print(name, message1, language, "!");

var name1 = "Jon"
var name2 = "Kim"
var name3 = "Kailey"
var name4 = "Kara"

var line = ""
// The separator parameter defines string that separates variable/constants with that value
// The terminator parameter defines what character is inserted at the end of the line
// The to: parameter lets us redirect the output of the print function.
print(name1, name2, name3, name4, separator:", ", terminator:"", to:&line)
print(line)

