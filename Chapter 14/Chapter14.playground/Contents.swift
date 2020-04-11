import Cocoa

/**
                        Concurrency and Parallelism in Swift
                                Chapter 14
*/

/**
    Traditionally, the way applications added concurrency was to create multiple threads; however this model does not scale well
    to an arbitrary number of cores. The biggest problem with using threads was that our applications ran on a variety of systems
    and processors and in order to optimize our code, we needed to know how many cores/processors could be effeciently used at
    a given time, which is usually not known at the time of development.
 
    To solve this problem, many operating systems including iOS and macOS, started relying on asynchronous functions. These functions
    are often used to initate tasks that could possibly take a long time to complete, such as making an HTTP request or writing data to
    disk. An asynchronous function typically starts the long running task and then returns prior to the task's completion. Usually, this task
    runs in the background and uses a callback function (such as a closure in Swift) when the task completes.
 
    These asynchronous functions work great for the tasks that the OS provides them for, but what if we need to create our own
    asynchronous functions and do not want to manage the threads ourselves? For this, Apple provides a couple of technologies. In
    this chapter we will cover two of these: GCD and operation queues.
 
    GCD is a low-level, C-based API that allows specific tasks to be queued up for execution and schedules the execution on any of
    the available processor cores. Operation queues are similar to GCD; however, they are Foundation objects and are internally
    implemented using GCD.
 */

/// Grand Central Dispatch

/**
    Prior to Swift 3, using GCD felt like writing low-level C code. The API was a little cumbersome and sometimes hard to understand
    because it did not use any of the Swift language design features. this all changed with Swift 3 because Apple took up the task of
    rewriting the API so it would meet the Swift 3 API guidelines.
 
    GCD provides what is known as dispatch queues to manage submitted tasks. The queues manage these submitted tasks and
    executes them in a FIFO order. This ensures that the tasks are started in the order they were submitted.
 
    A task is simply some work that our application needs to perform. For example, we can create tasks that perform simple calculations,
    read/write data to disk, make an HTTP request, or anything else that our application needs to do. We define these tasks by placing
    the code inside either a function or a closure and add it to a dispatch queue.
 
    GCD provides 3 types of queues:
 
    Serial queues: Tasks in a serial queue (aka a private queue) are executed one at a time in the order they were submitted. Each
    task is started only after the preceding task is completed. Serial queues are often used to synchronize access to specific resources
    because we are guaranteed that no two tasks in a serial queue will ever run simultaneously. Therefore, if the only way to access the
    specific resource is through the tasks in the serial queue, then no two tasks will attempt to access the resource at the same time or
    out of order.
 
    Concurrent queues: Tasks in a concurrent queue (aka a global dispatch queue) execute concurrently; however the tasks are still
    started in the order that they were added to the queue. The exact number of tasks that can be executed at any given instance is
    variable and is dependent on the system's current conditions and resources. The decision on when to start a task is up to GCD and
    is not something that we can control within our application.
 
    Main dispatch queue: The main dispatch queue is a globally available serial queue that executes tasks on the application's main
    thread. Since tasks put into the main dispatch queue run on the main thread, it is usually called from a background queue when
    some background processing has finished and the user interface needs to be updated.
 
    Dispatch queues offer several advantages over traditional threads. The first and formost is the system handles the creation and
    management of threads rather than the application itself. The system can scale the number of threads dynamically, based on the
    overall available resources of the system and the current system conditions. This means that dispatch queues can manage the
    threads with greater efficiency than we could.
 
    Another advantage is that we are able to control the order in which the tasks are started. With serial queues, not only do we control
    the order, but we also ensure that one task does not start before the preceding one is complete. With traditional threads, this can
    be very cumbersome and brittle to implement.
 */


/**
    Lets create a class that will help demonstrate how the various types of queues work. This class will contain two basic functions
    and we will name the class doCalculations. The performCalculation() func accepts two params iterations and tag. performCalculation
    calls doCalc repeatedly until the it calls the function the same number of times as defined by iterations. We use the
    CFAbsoluteTimeGetCurrent() function to calculate the elapsed time it took to perform all the iterations, and then print the elapsed
    time with the tag string to the console.
 */

class doCalculations {
    func doCalc() {
        let x = 100
        let y = x*x
        _ = y/x
    }
    
    func performCalculation(_ iterations: Int, tag: String) {
        let start = CFAbsoluteTimeGetCurrent()
        for _ in 0 ..< iterations {
            self.doCalc()
        }
        let end = CFAbsoluteTimeGetCurrent()
        print("Time for \(tag): \(end-start)")
    }
}

/// Creating queues

/**
    We use the DispatchQUeue initalizer to create a new dispatch queue:
 */

let concurrentQueue = DispatchQueue(label: "cqueue.nigro.vinny", attributes: .concurrent)
let serialQueue = DispatchQueue(label: "squeue.nigro.vinny")

/**
    The first line creates a concurrent queue while the second creates a serial queue. DispatchQueue takes the following arguments:
    label: A string label that is attached to the queue to uniquely identify it in debugging tools. It is recommended to use a reverse DNS
    naming convention. This parameter is optional and can be nil.
 
    Attributes: This specifies the type of queue to make. This can be DispatchQueue.Attributes.serial,
    DispatchQueue.Attributes.concurrent, or nil. If this parameter is nil, a serial queue is created. You can use .serial or .concurrent.
 
    Note: Some programming languages use the reverse DNS naming convention to name certain components. This convention is
    based on a registered domain name that is reversed. As an example, if we worked for a company that had a domain name of
    mycompany.com with a product called widget, the reverse DNS name will be com.mycompany.widget.
 */

/// Creating and using a concurrent queue

/**
    A concurrent queue will execute the tasks in a FIFO order; however, the tasks will execute concurrently and finish in any order. Let's
    see how we would create and use a concurrent queue:
 */

let cqueue = DispatchQueue(label: "cqueue.nigro.vinny", attributes: .concurrent)
let calculation = doCalculations()
let c = {calculation.performCalculation(1000, tag: "async1")}
cqueue.async(execute: c)

/**
    While the preceding example works perfectly, we can actually shorten the code a little bit by using a closure within the async:
 */

cqueue.async {
    calculation.performCalculation(1000, tag: "async1")
}

/**
    This shorthand version is how we usually submit small code blocks to our queues. If we have larger tasks or tasks that we need
    to submit multiple types, we will generally want to create a closure and submit the closure to the queue as shown previously.
 */

sleep(5)

print("-----------------------------------------------")


/**
    Let's see how a concurrent queue works by adding several items to the queue and looking at the order and time they return:
 */

cqueue.async {
    calculation.performCalculation(10000, tag: "async1")
}

cqueue.async {
    calculation.performCalculation(1000, tag: "async2")
}

cqueue.async {
    calculation.performCalculation(100000, tag: "async3")
}

/**
    Since the queues function in a FIFO order, the task that had the tag of async1 was executed first. However it was the last to finish.
    Since this is a concurrent queue, if it is possible (if the system has the available resources), the blocks of code will execute
    concurrently. This is why tasks with the tags of async2 and async3 completed propr to the task that had the async1 tag, even though
    the execution of the async1 task began before the other 2.
 */

/// Creating and using a serial queue

/**
    A serial queue functions a little different than a concurrent queue. A serial queue will only execute one task at a time and will wait
    for one task to complete before starting the next one. This queue, like the concurrent dispatch queue, follows the FIFO order.
 */

let squeue = DispatchQueue(label: "squeue.nigro.vinny")
let calculation1 = doCalculations()
let s = {calculation1.performCalculation(1000, tag: "sync1")}
squeue.async(execute: s)

/**
    Can be done like the following as well:
 */

squeue.async {
    calculation1.performCalculation(1000, tag: "async2")
}

sleep(5)
print("-----------------------------------------------")

squeue.async {
    calculation1.performCalculation(10000, tag: "sync1")
}

squeue.async {
    calculation1.performCalculation(100, tag: "sync2")
}

squeue.async {
    calculation1.performCalculation(1000, tag: "sync3")
}

/**
    Unlike the concurrent queues, we can see that the tasks completed in the same order that they were submitted in, even though
    the sync2 and 3 took less time. This shows serial queues only executes one task at a time and the queue waits for each task to
    complete before starting the next one.
 
    In the previous examples we used the async method to execute the code blocks but we could have used the sync method.
 */

/// Async versus sync

/**
    In the previous examples, we used the async method to execute the code blocks. When we use the async method, the call will
    not block the current thread. This means that the method returns and the code block is executed asynchronously. Rather than using
    the async method, we could use the sync method to execute the code blocks. The sync method will block the current thread, which
    means it will not return until the execution of the code has completed. Generally we use the async method, but there are use cases
    where the sync method is useful. This use case is usually when we have a separate thread and we want that thread to wait for some
    work to finish.
 */

/// Executing code on the main queue function

/**
    The DispatchQueue.main.async(execute:) function will execute code on the application's main queue. We generally use this function
    when we want to update our code from another thread or queue. The main queue is automatically created for the main thread when
    the application starts. This main queue is a serial queue; therefore, items in this queue are executed one at a time, in order that they
    were submitted. We will generally want to avoid using this queue unless we have a need to update the user interfface from a
    background thread.
 */

//let squeue = DispatchQueue(label: "squeue.nigro.vinny")
//squeue.async {
//    let resizedImage = image.resize(to: rect)
//    DispatchQueue.main.async {
//        picView.image = resizedImage
//    }
//}

/**
    In the previous code, we assume that we have added a method to the UIImage type that will resize the image. In this code, we create
    a new serial queue and in that queue we resize an image. This is a good example of how to use a dispatch queue because we would
    not want to resize an image on the main queue since it would freeze the UI while the image is being resized. Once the image is
    resized, we then need to update a UIImageView with the new image; however all updates to the UI need to occur on the main thread.
    Therefore, we will use the DispatchQueue.main.async function to perform the update on the main queue.
 
    There will be times when we need to execute tasks after a delay. If we were using a threading model, we would need to create a new
    thread, perform some sort of delay or sleep function, and execute our task. With GCD, we can use the asyncAfter function.
 */

/// Using asyncAfter

/**
    The asyncAfter function will execute a block of code asynchronously after a given delay. This is very useful when we need to pause
    the execution of our code. The following code sample shows how we would use the asyncAfter function:
 */

let queue2 = DispatchQueue(label: "squeue.nigro.vinny")
let delayInSeconds = 2.0
let pTime = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) /
    Double(NSEC_PER_SEC)
queue2.asyncAfter(deadline: pTime) {
    print("Times up")
}

/**
    In this code, we begin by creating a serial dispatch queue. We then create an instance of the DispatchTime type and calculate the
    time to execute the block of code based on the current time. We then use the asyncAfter function to execute the code block after
    the delay.
 
    Now that we looked at GCD, let's look at operation queues.
 */

/// Using the Operation and OperationQueue types

/**
    The Operation and OperationQueue types, working together provide us with an alternative to GCD for adding concurrency to our
    applications. Operation queues are part of the Foundation framework and function like dispatch queues as they are a higher-level
    of abstraction over GCD.
 
    We define the tasks (Operations) that we wish to execute and then add the tasks to the operation queue. The operation queue will
    then handle the scheduling and execution of tasks. Operation queues are instances of the OperationQueue class and operations
    are instances of the Operation class.
 
    An operation represents a single unit of work or task. The Operation type is an abstract class that provides a thread-safe structure
    for modeling the state, priority, and dependencies. This class must be subclassed to perform any useful work; we will look at how to
    subclass this class later.
 
    Apple provides a concrete implementation of the Operation type that we can use as-is for situations where it does not make sense
    to build a custom subclass. This sublcass is BlockOperation.
 
    More than one operation queue can exist at the same time, and in fact, there is always at least one operation queue running. This
    operation queue is known as the main queue. The main queue is automatically created for the main thread when the application starts
    and is where all of the UI operations are performed.
 
    There are several ways that we can use the Operation and OperationQueue classes to add concurrency to our application. In this
    chapter, we will look at three of these ways.
 */

/// Using BlockOperation

/**
    In this section, we will be using the same DoCalculation class that we used in the GCD section to keep our queues busy with work
    so that we could see how the OperationQueue class works. The BlockOperation class is a concrete implementation of the Operation
    type that can manage the execution of one or more blocks. This class can be used to execute several tasks at once without the
    need to create separate operations for each task:
 */

let calculation2 = doCalculations()
let blockOperation1: BlockOperation = BlockOperation.init(block: {
    calculation2.performCalculation(10000, tag: "Operation 1")
})

blockOperation1.addExecutionBlock {
    calculation2.performCalculation(100, tag: "Operation 2")
}
blockOperation1.addExecutionBlock {
    calculation2.performCalculation(1000, tag: "Operation 3")
}

let operationQueue = OperationQueue()
operationQueue.addOperation(blockOperation1)

/**
    In this code, we begin by creating an instance of the doCalculation class and an instance of the OperationQueue class. We create
    an instance of the BlockOperation class using the init constructor. This constructor takes a single parameter, which is a block of
    code that represents one of the tasks we want to execute in the queue. Next, we add two additional tasks using the
    addExecutionBlock() method.
 
    One of the differences between dispatch queues and operations is that, with dispatch queues, if resources are available, the tasks
    are executed as they are added to the queue. With operations, the individual tasks are not executed until the operation itself is
    submitted to an operation queue. This allows us to initiate all of the operations into a single block operation prior to executing them.
 
    Once we add all of the tasks to the BlockOperation instance, we then add the operation to the OperationQueue instance that we
    created at the beginning of the code. At this point, the individual tasks within the operation start to execute.
 
    What if we dont want the tasks to run concurrently? What if we wanted them to run serially like the serial dispatch queue? We can
    set a property in the operation queue that defines the number of tasks that can be run concurrently in the queue. The property is
    named maxConcurrentOperationCount, and is used like this:
 
    operationQueue.maxConcurrentOperationCount = 1
 
    However if we add this line to our previous example, it will not work as expected. To see why this is, we need to understand what
    the property actually defines. If we look at Apple's OperationQueue class reference, the definition of the property is, the maximum
    number of queued operations that can execute at the same time.
 
    What this tells us is that this property defines the number of operations (this is the keyword) that can be executed at the same time.
    The BlockOperation instance, which we added all of the tasks to, represents a single operation, therefore, no other BlockOperation
    added to the queue will execute until the first one is complete, but the individual tasks within the operation will execute concurrently.
    To run the tasks serially, we would need to create a separate instance of BlockOperation for each task.
 
    Using an instance of the BlockOperation class is good if we have several tasks that we want to execute concurrently, but they will
    not start executing until we add the operation to an operation queue.
 */

/// Using the addOperation() method of the operation queue

/**
    The OperationQueue class has a method named addOperation() which makes it easy to add a block of code to the queue. This
    method automatically wraps the block of code in an operation object and then passes the operation to the queue. Let's see how to
    use this method to add tasks to a queue:
 */

let operationQueue1 = OperationQueue()
let calculation3 = doCalculations()
operationQueue1.addOperation {
    calculation3.performCalculation(100000, tag: "Operation 1")
}
operationQueue1.addOperation {
    calculation3.performCalculation(100, tag: "Operation 2")
}
operationQueue1.addOperation {
    calculation3.performCalculation(1000, tag: "Operation 3")
}

/**
    In the BlockOperation example earlier this chapter, we added the tasks that we wished to execute into a BlockOperation instance. In
    this example, we are adding the tasks directly to the operation queue, and each task represents one complete operation. Once we
     create the instance of the operation queue, we then use the addOperation method to add tasks to the queue.
 
    Also in the BlockOperation example, the individual tasks did not execute until all of the tasks were added, and then the operation
    was added to the queue. This example is similar to the GCD example where the tasks began executing as soon as they were added
    to the operation queue.
 
    You will notice the operations are executed concurrently. With this example, we can execute the tasks serially by using the
    maxConcurrentOperationCount property that we mentioned earlier. Let's try this by initalizing the OperationQueue instance as follows:
 
    var operationQueue = OperationQueue()
    operationQueue.maxConcurrentOperationCount = 1
 
    Using the addOperation() method to add tasks to the operation queue is generally easier than using the BlockOperation method;
    however, the tasks will begin as soon as they are added to the queue. This is usually the desired behavior, although there are cases
    where we do not want the tasks executing until all operations are added to the queue.
 */

/// Subclassing the Operation class

/**
    The previous two examples showed how to add small blocks of code to our operation queues. In these examples, we called the
    performCalculations method in the doCalculations class to perform our tasks. These examples illustrate two really good ways to
    add concurrency for functionality that is already written, but what if, at design time, we want to design our doCalculation class itself
    for concurrency? For this we can subclass the Operation class.
 
    The Operation abstract class provides a significant amount of infrastructure. This allows us to very easily create a subclass without
    a lot of work. We will need to provide at least an initialization method and a main method. The main method will be called when the
    queue begins executing the operation:
 */

class MyOperation: Operation {
    let iterations: Int
    let tag: String
    
    init(iterations: Int, tag: String) {
        self.iterations = iterations
        self.tag = tag
    }
    
    override func main() {
        performCalculation()
    }
    
    func performCalculation() {
        let start = CFAbsoluteTimeGetCurrent()
        for _ in 0 ..< iterations {
            self.doCalc()
        }
        let end = CFAbsoluteTimeGetCurrent()
        print("Time for \(tag): \(end-start)")
    }
    
    func doCalc() {
        let x = 100
        let y = x*x
        _ = y/x
    }
}

/**
    We begin by defining that the MyOperation class is a subclass of the Operation class. Within the implementation of the class,
    we define two class constants, which represent the iteration count and the tag that the performCalculation() method uses.
    Keep in mind that when the operation queue begins executing the operation, it will call the main() method with no parameters;
    therefore any parameters that we need to pass must be passed through initializers.
 */

let operationQueue2 = OperationQueue()
operationQueue2.addOperation(MyOperation(iterations: 10000, tag: "Operation 1"))
operationQueue2.addOperation {
    MyOperation(iterations: 100, tag: "Operation 2")
}
operationQueue2.addOperation {
    MyOperation(iterations: 1000, tag: "Operation 3")
}

/**
    As we saw earlier, we can also execute the tasks serially by setting the maxConcurrentOperationCount property of the operation
    queue to 1. If we know that we need to execute some functionality concurrently prior to writing the code, it is recommended to
    subclass the Operation class as shown in this example. This gives the cleanest implementation; however, there is nothing wrong
    with using the BlockOperation class or the addOperation() method described earlier.
 */
