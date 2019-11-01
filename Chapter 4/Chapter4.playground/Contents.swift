import Cocoa

/**
                    Using Swift Collections
                        Chapter 4
 */

/**
    Swift provides three native collection types and these are arrays, sets, and dictionaries. Arrays are an ordered collection,
    sets are unordered collections of unique values and dictionaries are unordered collections of key-value pairs.
    The data stored in a Swift collection must be of the same type. Since Swift does not allow us to mismatch data types in
    collections, we can be certain of the data type when we retrieve elements from a collection.
    This seems minor on the surface but actually helps eliminate common programming mistakes.
        
    Swift handles mutability differently than Objective-C, for a mutable object just define it as a variable (var) and immutable
    objects as constants (let).
 */

///         Arrays

let immutableArray = [1,2,3]
var mutableArray = [4,5,6]

/**
    In the previous 2 examples, the compiler inferred the types of values stored in the array by looking at the type of values
    stored in the array literal. If we want to create an empty array, we need to explicitly declare the type of values to store in
    the array. There are two ways to declare null arrays in Swift. The following examples show how to declare an empty mutable
    array that can be used to store integers:
 */

var mutableArray2 = [Int]()
var mutableArray3: [Int] = []

/**
    Once an array is defined as containing a particular type, all the elements must be of that type.
 */

var strArray = [String]()
var dblArray = [Double]()

/**
    Swift provides special type aliases for working with nonspecific types, AnyObject and Any. We can use these aliases
    to define arrays whose elements are of different types:
 */

var anyArray: [Any] = [1, "Two"]

/**
    The AnyObject aliases can represent an instance of any class type, while the Any aliases can represent an instance of the
    instance of any type, including function types. We should use the Any and AnyObject aliases only when there is an explicit
    need for this behavior.
    An array can also be initialized to a certain size with all the elements set to a predefined value:
 */

/// Defines an array with 7 elements each containing the number 3.
var initializeArray = [Int](repeating: 3, count: 7)

/**
    While the most common arrays are one-dimensional arrays, multidimensional arrays can also be created.
    The following examples show the two ways to create a two-dimensional array in Swift:
 */

var multiArrayOne = [[1,2], [3,4], [5,6]]
var multiArrayTwo = [[Int]]()

let constArray = [1,2,3,4,5,6]
print(constArray[0])
print(constArray[3])

let arr = multiArrayOne[0] // arr contains the array [1,2]
let value = multiArrayOne[0][1] // value contains 2

/**
    We can retrieve the first and last elements of an array using first and last properties. The first and last properties return
    an optional value, since the values may be nil if the array is empty:
 */

let testArrOne = [1,2,3,4,5,6]
let first = testArrOne.first
let last = testArrOne.last

let testMultiOne = [[1,2], [3,4], [5,6]]
let arrFirst1 = testMultiOne[0].first   // arrFirst1 contains 1
let arrFirst2 = testMultiOne.first      // arrFirst2 contains [1,2]
let arrLast1 = testMultiOne[0].last     // arrLast1 contains 2
let arrLast2 = testMultiOne.last        // arrLast2 contains [5,6]

/**
    At times, it is essential to know the number of elements in an array. The array type in Swift contains a read-only count property:
 */

let arrCount = [1,2,3]
let multiArrCount = [[3,4], [5,6], [7,8]]
print(arrCount.count) // Displays 3
print(multiArrCount.count) // Displays 3
print(multiArrCount[0].count) // Displays 2

/**
    Swift contains array bounds checking and will throw an error during runtime. Therefore, if we are unsure of the size of the
    array, it is a good practice to verify that the index is not outside the range of the array:
 */
/// print(arrCount[8]) creates a runtime error
let arrTwo = [1,2,3,4]
var cnt = 0;
print()
while (cnt < arrTwo.count) {
    print(arrTwo[cnt]);
    cnt += 1;
}

/**
    To check whether an array is empty, we use the isEmpty property:
 */
var emptyArr = [Int]()
print(emptyArr.isEmpty);

/**
    An array can be very easily shuffled using the shuffle() and shuffled() methods. This can be very useful if we are creating
    a game such as a card game, where the array contains the 52 cards in the deck. To shuffle the array in place, the shuffle()
    method can be used; to put the shuffled results in a new array, leaving the original untouched, the shuffled() method would be used.
 */
var shuffleArr = [1,2,3,4,5,6]
var shuffledArr = shuffleArr.shuffled()
shuffleArr.shuffle()

/**
    A static array is somewhat useful but having the ability to add elements dynamically is what makes arrays really useful.
    To add an item to the end of an array, we use the append method:
 */
var appArr = [1,2]
appArr.append(3)

/**
    Swift also alows us to use the addition assignment operator (+=) to append an array to another array. The following example
    shows how to use the addition assignment operator to append an array to the end of another array:
 */
var appArr2 = [1,2]
appArr2 += [3,4]
appArr2 += [5]

/**
    We can insert a value into an array by using the insert method. The insert method will move all the items up one spot, starting
    at the specified index, to make room for the new elements, and then insert the value into the specified index:
 */
var insertArr = [1,2,3,4,5]
insertArr.insert(10, at: 3)

/**
    You cannot insert a value that is outside the current range of the array. This will throw an index out of range exception.
    Technically can use insert to insert element at the end of array like append does and it will use an index that is "out of bounds".
    However it is recommended to use append to append an item to avoid errors.
 */
insertArr.insert(11, at: 6)

/**
    We use the subscript syntax to replace elements in an array. Using the subscript, we pick the element of the array we wish to update
    and then use the assignment operator to assign a new value:
 */
var assignArr = [1,2,3]
assignArr[1] = 10

/**
    There are three methods that we can use to remove one or all of the elements in an array: removeLast, remove(at:), and removeAll().
 */
var rmArr = [1,2,3,4,5]
rmArr.removeLast()
rmArr.remove(at: 2)

/**
    The removeLast() and remove(at:) methods will also return the value of the element being removed. Therefore, if we want to know
    the value of the item that was removed, we can capture it:
 */
var rmLastVal = rmArr.removeLast()
var rmVal = rmArr.remove(at: 1)
rmArr.removeAll()

/**
    To create a new array by adding two arrays together, we use the addition operator:
 */
var combineArrs = [1,2,3,4] + [4, 5, 6, 7, 8]

/**
    We can retrieve a subarray from an existing array by using the subscript syntax with a range operator:
 */
var fullArr = [1,2,3,4,5]
var subArr = fullArr[2...4]

/**
    The ... operator is known as a two-sided range operator. The range operator, in the previous example, says that I want all
    the elements from 2 to 4 inclusively (elements 2 and 4 as well as what is between them). There is another two-sided range
    operator,  which is known as the half-open range operator. The half-open range operator functions the same as the previous
    however, it excludes the last element.
 */
var subArr2 = fullArr[2..<4]

/**
    In the preceding example, the subarray will contain two elements: 3 and 4. A two-sided range operator has numbers on either
    side of the operator. In Swift, we are not limited to two-sided range operators; we can also use one-sided range operators:
 */

var a = fullArr[..<3] /// contains 1, 2, 3
var b = fullArr[...3] /// contains 1, 2, 3, 4
var c = fullArr[2...] /// contains 3, 4, 5

/**
    We can use the subscript syntax with a range operator to change the values of multiple elements. The following code has
    elements 1 and 2 changed to the numbers 12 and 13.
 */
fullArr[1...2] = [12, 13]

/**
    The number of elements that you are changing in the range operator does not need to match the number of values you are
    passing in. Swift makes bulk changes by first removing the elements defined by the range operator and then inserting the new
    values:
 */
var newValuedArr = [1,2,3,4,5]
newValuedArr[1...3] = [12,13] /// now contains 1, 12, 13, 5

/**
    In the preceding code, the newValuedArr array startfs with five elements. We then replace the range of elements 1 to 3
    inclusively. This causes elements 1 through 3 to be removed from the array first. After those three are removed, then the two
    new elements are added to the array starting at index 1. Using the same logic, we can also add more elements than we remove:
 */
var newValuedArr2 = [1,2,3,4,5]
newValuedArr2[1...3] = [12,13,14,15] /// now contains 1, 12, 13, 14, 15, 5

/**
    Swift arrays have several lmethods that take a closure as the argument. These methods transform the array in some way defined
    by the code in the closure. Closures are self-contained blocks of code that can be passed around, and are similar to blocks in
    Objective-C and lambdas in other languages.
    The sort algorithm sorts an array in place. This means that, when sort() is used, the original array is replaced with the sorted one.
    the closure takes two arguments (represented by $0 and $1), and it should return a Boolean value that indicates whether the first
    element should be placed before the second element.
 */
var sortArr = [9,3,6,2,8,5]
sortArr.sort(){ $0 < $1 } // contains 2,3,5,6,8,9
print(sortArr)

/**
    The preceding code will sort the array in ascending order. We know this because the rule will return true if the first number $0
    is less than the second number $1. Therefore, when the sort algorithm begins, it compares the first two numbers (9 and 3) and returns
    true, if the first number is less than the second. In our case, the rule returns false, so the numbers are reversed. The algorithm
    continues sorting in this manner until all of the numbers are sorted in the correct order.
    The preceding example sorted the array in a numerically-increasing order; if we wanted to reverse the order, we would reverse
    the arguments in the closure:
 */
sortArr = [9,3,6,2,8,5]
sortArr.sort(){ $1 < $0 } // contains 9,8,6,5,3,2
print(sortArr)

/**
    The preceding code can be simplified by using the sort(by:) method and passing in a greater than or less than operator:
 */
sortArr = [9,3,6,2,8,5]
sortArr.sort(by: <) /// ascending order use greater than sign for descending order

/**
    While the sort algorithm sorts the array in place, the sorted algorithm does not change the original array; it instead creates a new
    array with the sorted elements from the original array:
 */
sortArr = [9,3,6,2,8,5]
let sorted = sortArr.sorted(){ $0 < $1 }
print(sorted)
print(sortArr)

/**
    The filter algorithm will return a new array by filtering the original array. This is one of the most powerful array algorihtsm and may
    end up being the one you use the most. If you need to retrieve a subset of an array based on a set of rules, I recommend using
    this algorithm rather than trying to write your own method to filter the array.
    The closure takes one argument, and it should return a Boolean true if the element should be included in the new array:
 */
var filterArr = [1,2,3,4,5,6,7,8,9]
let filtered = filterArr.filter{$0 > 3 && $0 < 7}
print(filtered)

/**
    This next example shows how to retrieve a subset of cities that contain the letter o in their name:
 */
var cities = ["Boston", "London", "Chicago", "Atlanta", "Philadelphia", "New York", "Orlando"]
let filtered2 = cities.filter{$0.range(of: "o") != nil}
print(filtered2)

/**
    In the preceding code, we use the range(of:) method to return true if the string contains the letter o. If the method returns true,
    the string is included in the filtered array.
 */

/**
    While the filter algorithm is used to select only certain elements of an array, map is used to apply logic to all elements in the array:
 */
var mapArr = [10,20,30,40]
let applied = mapArr.map{$0 / 10}
print(applied)

/**
    The new array created by the map algorithm is not required to contain the same element types as the original array; however,
    all the elements in the new array must be of the same type.
 */
var mapArr2 = [1,2,3,4]
let applied2 = mapArr2.map{ "num:\($0)" }
print(applied2)

/// using the ForEach algorithm is very easy, but has some limitations; the recommended way to iterate over an array is to use the
/// for-in loop.
mapArr.forEach{ print($0) }

/**
    We can iterate over all elements of an array in order, with a for-in loop:
 */
var arrElement = ["one", "two", "three"]
for item in arrElement {
    print(item)
}

/**
    There are times when we would like to iterate over an array, as we did in the preceding example, but we would also like to know the
    index, as well as the value of the element. To do this, we can use the enumerated method of an array, which returns a tuple for each
    item in the array that contains both the index and value of the element:
 */
for (index, value) in arrElement.enumerated() {
    print("\(index): \(value)")
}

///         Dictionaries

/**
    While dictionaries are not as commonly used as arrays, they have additional functionality that makes them incredibly powerful.
    A dictionary is a container that stores multiple key-value pairs, where all the keys are of the same type and all the values are of
    the same type. The key is used as a unique identifier for the value. A dictionary does not guarantee the order in which the key-value
    pairs are stored since we look up the values by the key rather than the index of the value.
    Dictionaries are good for storing items that map to unique identifiers, where the unique identifier should be used to retrieve the item.
    Countries with their abbreviations are a good example of items that can be stored in a dictionary. We can initialize a dictionary using
    a dictionary literal, similarly how we initialzed an array with the array literal:
 */
let countries = ["US":"United States", "IN":"India", "UK":"United Kingdom"]

/**
    The preceding code creates an immutable dictionary that contains each of the key-value pairs in the chart we saw before. Just
    like the array, to create a mutable dictionary we will need to use var instead of let:
 */
var countries2 = ["US":"United States", "IN":"India", "UK":"United Kingdom"]

/**
    In the preceding two examples, we created a dictionary where the key and value were both strings. The compiler inferred that
    the key and value were string because that was the type of the keys and values used to initiate the dictionary. If we wanted
    to create an empty dictionary, we would need to tell the compiler what the key and value types are:
 */
var dict1 = [String:String]()
var dict2 = [Int:String]()
var dict3 = [String:Any]()
var dict4: [String:String] = [:]
var dict5: [Int:String] = [:]

/**
    If we wanted to use a custom object as the key in a dictionary, we will need to make the custom object conform to the Hashable
    protocol from Swift's standard library.
    We use the subscript syntax to retrieve the value for a particular key. If the dictionary does not contain the key we are looking for,
    the dictionary will return nil; therefore, the variable returne dfrom this lookup is an optional variable.
 */
var name = countries2["US"]

/**
    We use the count property of the dictionary to get the number of key-value pairs in the dictionary:
 */
var count1 = countries2.count

/**
    To test whether the dictionary contains any key-value pairs, we can use the isEmpty property.
 */
var empty = countries2.isEmpty

/**
    To update the value of a key in a dictionary, we can use either the subscript syntax, or the updateValue(_: , forKey:) method.
    The updateValue(_:, forKey:) method has an additional feature that the subscript doesn't: it returns the original value associated
    with the key prior to changing the value.
 */
countries2["UK"] = "Great Britain"
var orig = countries2.updateValue("Britain", forKey: "UK")
print(countries2)
/**
    To add a new key-value pair to a dictionary, we can use the subscript syntax or the same updatevalue(_:, forKey:) method that we
    used to update the value of a key. If we use the updateValue(_:, forKey:) method and the key is not currently present in the dictionary,
    this method will add a new key-value pair and return nil.
 */
countries2["FR"] = "France"
var orig2 = countries2.updateValue("Germany", forKey: "DE")

/**
    There may be time when we need to remove values from a dictionary. There are three ways to achieve this: the subscript syntax,
    the removeValue(forKey:) method, or the removeAll method. The removeValue(forKey:) method returns the value of the key
    prior to removing it. The removeAll() method removes all the elements from the dictionary.
 */
countries2["IN"] = nil /// The "IN" key/value pair is removed
var orig3 = countries2.removeValue(forKey: "UK")

countries2.removeAll()

///         Set

/**
    The set type is a generic collection that is similar to the array type. While the array type is an ordered collection that may
    contain duplicate items, the set type is an unordered collection where each item must be unique.
    Like the key in a dictionary, the type stored in an array must conform the Hashable protocol. This means that the type must provide
    a way to compute a hash value for itself. All of Swift's basic types, such as String, Double, Int, and Bool, conform to this protocol
    and can be used in a set by default.
    There are a couple ways of initializing a set. Just like the array and dictionayr types, Swift needs to know what type of data is going
    to be stored in it. This means that we must either tell Swift the type of data to store in the set or initialize it with some data so that it
    can infer the data type.
 */

/// Initializes an empty set of the String type
var mySet = Set<String>()

/// Initalizes a mutable set of String type with initial values
var mySet2 = Set(["one", "two", "three"])

/// Initializes an immutable set of the String type
let mySet3 = Set(["one", "two", "three"])

/**
    We use the insert() method to insert an item into a set. If we attempt to insert an item that is already in the set, the item will be
    ignored.
 */
var mySet4 = Set<String>()
mySet4.insert("One")
mySet4.insert("Two")
mySet4.insert("Three")


/**
    The insert() method returns a tuple that we can use to verify that the value was successfully added to the set:
 */
var mySet5 = Set<String>()
mySet5.insert("One")
mySet5.insert("Two")
var results = mySet5.insert("One")
if results.inserted {
    print("Success")
}
else {
    print("Failed")
}

/**
    We can use the count property to determine the number of items in a set:
 */
var mySet6 = Set<String>()
mySet6.insert("One")
mySet6.insert("Two")
mySet6.insert("Three")
print("\(mySet6.count) items")

/**
    We can verify whether a set contains an item by using the contains() method:
 */
var contain = mySet6.contains("Two")

/**
    We can use the for-in statement to iterate over the items in a set as we did with arrays:
 */
for item in mySet6 {
    print(item)
}

/**
    We can remove a single item or all items in a set. To remove a single item, we would use the remove() method, and to remove
    all items, we would use the removeAll method:
 */
var item = mySet6.remove("Two")
mySet6.removeAll()

///         Set operations

/**
    Apple has provided four methods that we can use to construct a set from two other sets. These operations can be performed in
    place, on one of the sets, or used to create a new set:
        Union and formUnion: These create a set with all the unique values from both sets.
        Subtracting and subtract: These create a set with values from the first set that are not in the second set.
        Intersection and formIntersection: These create a set with value that are common to both sets.
        SymmetricDifference and formSymmetricDifference: These create a new set with values that are in either set, but not in both.
 */

var thisSet1 = Set(["One", "Two", "Three", "abc"])
var thisSet2 = Set(["abc", "def", "ghi", "One"])

var newSetUnion = thisSet1.union(thisSet2)
print(newSetUnion)

// doesn't create new set
//thisSet1.formUnion(thisSet2)

var newSetSubtract = thisSet1.subtracting(thisSet2)
print(newSetSubtract)

// doesn't create new set
//thisSet1.subtract(thisSet2)

var newSetIntersect = thisSet1.intersection(thisSet2)
print(newSetIntersect)

// doesn't create new set
//thisSet1.formIntersection(thisSet2)

var newSetExclusiveOr = thisSet1.symmetricDifference(thisSet2)

// doesn't create new set
// thisSet1.formSymmetricDifference(thisSet2)

/**
    These four operations add functionality that is not present with arrays. Combined with faster lookup speeds, as compared to
    an array, the set type can be very useful alternative when the order of the collection is not important and the instances in the
    collection must be unique.
 */
