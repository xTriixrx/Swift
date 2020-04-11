import Cocoa

/**
                       Adopting Design Patterns in Swift:
                             Strategy Pattern
                               Chapter 18
*/

/**
    The strategy pattern is pretty similar to the command pattern in that they both allow us to decouple implementation details from the
    calling type, and also allow us to switch the implementation out at runtime. The big difference is that the strategy pattern is intended to
    encapsulate algorithms. By swapping out an algorithm, we are expecting the object to perform the same functionality, but in a different
    way. In the command pattern, when we swap out the commands, we are expecting the object to change the functionality.
 */

/// Understanding the problem

/**
    There are times in the applications when we need to change the backend algorithm that is used to perform an operation. Typically,
    this is when we have a type that has several different algorithms that can be used to perform the same task; however, the choice of
    which algorithm to use needs to be made at runtime.
 */

/// Understanding the solution

/**
    The strategy pattern tells us that we should encapsulate the algorithm in a type that conforms to a strategy protocol. We can then
    provide instances of the strategy types for use by the invoker. The invoker will use the interface provided by the protocol to invoke the
    algorithm.
 */

/**
    In this section, we will demonstrate the strategy pattern by showing you how we could swap out compression algorithms at runtime.
    Let's begin this example by creating a CompressionStrategy protocol that each one of the compression types will conform to. Let's
    look at the following code:
 */

protocol CompressionStrategy {
    func compressFiles(filePaths: [String])
}

/**
    This protocol defines a method named compressFiles() that accepts a single parameter, which is an array of strings that contain the
    paths to the files we want to compress. We will now create two structures that conform to this protocol. These are the
    ZipCompressionStrategy and the RarCompressionStrategy structures, which are as follows:
 */

struct ZipCompressionStrategy: CompressionStrategy {
    func compressFiles(filePaths: [String]) {
        print("Using Zip Compression")
    }
}
struct RarCompressionStrategy: CompressionStrategy {
    func compressFiles(filePaths: [String]) {
        print("Using RAR Compression")
    }
}

/**
    Both of these structures implement the CompressionStrategy protocol by using a method named compressFiles(), which accepts an
    array of strings. Within these methods, we simply print out the name of the compression that we are using. Normally, we would
    implement the compression logic in these methods.
    Now, let's look at the CompressContent class, which will be used to compress the files:
 */

struct CompressContent {
    var strategy: CompressionStrategy
    func compressFiles(filePaths: [String]) {
        self.strategy.compressFiles(filePaths: filePaths)
    }
}

/**
    In this class, we start off by defining a variable, named strategy, which will contain an instance of a type that conforms to the
    CompressStrategy protocol. Then we create a method named compressFiles(), which accepts an array of strings that contain the
    paths to the list of files that we wish to compress. In this method, we compress the files using the compression strategy that is set in
    the strategy variable. We will use the CompressContent class as follows:
 */

var filePaths = ["file1.txt", "file2.txt"]
var zip = ZipCompressionStrategy()
var rar = RarCompressionStrategy()

var compress = CompressContent(strategy: zip)
compress.compressFiles(filePaths: filePaths)

compress.strategy = rar
compress.compressFiles(filePaths: filePaths)

/**
    We begin by creating an array of strings that contains the files we wish to compress. We also create an instance of both the
    ZipCompressionStrategy and the RarCompressionStrategy types. We then create an instance of the CompressContent class, setting
    the compression strategy to the ZipCompressionStrategy instance, and call the compressFiles() method, which will print the Using zip
    compression message to the console. We then set the compression strategy to the RarCompressionStrategy instance and call the
    compressFiles() method again, which will print the Using rar compression message to the console.
    The strategy pattern is really good for setting the algorithms to use at runtime, which also lets us swap the algorithms out with different
    implementations as needed by the application. Another advantage of the strategy pattern is that we encapsulate the details of the
    algorithm within the strategy types themselves and not in the main implementation type.
 */
