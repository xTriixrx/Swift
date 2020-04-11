//
//  main.swift
//  Chapter16
//
//  Created by Vincent Nigro on 11/16/19.
//  Copyright © 2019 Vincent Nigro. All rights reserved.
//

import Foundation

/**
                            Memory Management
                                Chapter 16
*/

/**
    Modern languages like Swift take care of managing the memory for us however it is a good idea to understand how this memory
    management works so we can avoid the pitfalls that cause this memory management to fail.
 
    As we saw in Chapter 15, Custom Types, structures are value types and classes are reference types. What this means is that
    when we pass an instance of a structure within our application, such as a parameter of a method, we create a new instance of
    the structure in the memory. This new instance of the structure is only valid while the application is in the scope where the
    structure was created. Once the structure goes out of scope, the new instance of the structure is automatically destroyed, and
    the memory is released. This makes memory management of structures very easy and mostly painless.
 
    Classes, on the other hand, are reference types. This means that we allocate memory for the instance of the class only once which
    is when it is initially created. When we pass an instance of the class within our application, either as a function argument or by
    assigning it to a variable, we are really passing a reference to where the instance is stored in memory. Since the instance of a
    class may be referenced in multiple scopes (unlike a structure), it cannot be automatically destroyed, and memory is not released
    when it goes out of scope because it may be referenced in another scope. Therefore, Swift needs some form of memory
    management to track and release the memory used by instances of classes when the class is no longer needed. Swift uses
    Automatic Reference Counting (ARC) to track and manage memory usage.
 
    With ARC, for the most part, memory management in Swift simply works. ARC will automatically track the references to instances of
    classes, and when an instance is no longer needed (no references pointing to it), ARC will automatically destroy the instance and
    release the memory. There are a few instances where ARC requires additional information about relationships to properly manage
    the memory. Before we look at the instances where ARC needs help, let's look at how ARC itself works.
 */

/// How ARC works

/**
    Whenever we create a new instance of a class, ARC allocates the memory needed to store that class. This ensures that there is
    enough memory to store the information associated with that instance of the class, and also locks the memory so that nothing
    overwrites it. When the instance of the class is no longer needed, ARC will release the memory allocated for the class so that it can
    be used for other purposes. This ensures that we are not tying up memory that is no longer needed.
 
    If ARC were to release the memory for an instance of a class that is still needed, it would not be possible to retrieve the class
    information from memory. If we did try to access the instance of the class after the memory was released, there is a possibility that
    the application would crash or the data would be corrupt. To ensure memory is not released for an instance of a class that is still
    needed, ARC counts how many times the instance is referenced, that is, how many active properties, variables, or constants are
    pointing to the instance of the class. Once the reference count for an instance of a class equals zero (nothing is referencing the
    instance), the memory is marked for release.
 
    All the previous examples run properly in a Playground, however, the following examples will not. When we run sample code in a
    Playground, ARC does not release objects that we create; this is by design so that we can see how the application runs and also the
    state of the objects at each step. Therefore, we will need to run these samples as an iOS or macOS project. Let's look at an example
    of how ARC works.
 */

class MyClass {
    var name = ""
    init(name: String) {
        self.name = name
        print("Initializing class with name \(self.name)")
    }
    deinit {
        print("Releasing class with name \(self.name)")
    }
}

/**
    In this class we have a name property with an initiator that will accept a string value which will be used to set the name property.
    This class also has a deinitializer that is called just before an instance of the class is destroyed and removed from memory.
    This deinitializer prints out a message to the console that lets us know that the instance of the class is about to be removed.
 */

var class1ref1: MyClass? = MyClass(name: "One")
var class2ref1: MyClass? = MyClass(name: "Two")
var class2ref2: MyClass? = class2ref1

print("Setting class1ref1 to nil")
class1ref1 = nil
print("Setting class2ref1 to nil")
class2ref1 = nil
print("Setting class2ref2 to nil")
class2ref2 = nil

/**
    From the example, it seems that ARC handles memory management very well. However, it is possible to write code that will
    prevent ARC from working properly.
 
    A strong reference cycle is where the instances of two classes holds a strong reference to each other, preventing ARC from
    releasing either instance. Once again, we are not able to use a Playground for this example, so we need to create an Xcode project.
 */

class MyClass1_Strong {
    var name = ""
    var class2: MyClass2_Strong?
    init(name: String) {
        self.name = name
        print("Initializing class1_Strong with name \(self.name)")
    }
    deinit {
        print("Releasing class1_Strong with name \(self.name)")
    }
}

class MyClass2_Strong {
    var name = ""
    var class1: MyClass1_Strong?
    init(name: String) {
        self.name = name
        print("Initializing class1_Strong with name \(self.name)")
    }
    deinit {
        print("Releasing class1_Strong with name \(self.name)")
    }
}

/**
    As we can see from the code, MyClass1_Strong contains an instance of MyClass2_Strong, therefore, the instance of MyClass2_Strong
    cannot be released until MyClass1_Strong is destroyed. We can also see from the code that MyClass2_Strong contains an instance of
    MyClass1_Strong, therefore, the instance of MyClass1_Strong cannot be released until MyClass2_Strong is destroyed. This creates a
    cycle of dependency in which neither instance can be destroyed until the other one is destroyed.
 */


var class1: MyClass1_Strong? = MyClass1_Strong(name: "Class1_Strong")
var class2: MyClass2_Strong? = MyClass2_Strong(name: "Class2_Strong")
class1?.class2 = class2
class2?.class1 = class1
  
print("Setting classes to nil")
class2 = nil
class1 = nil

/**
    In this example we create instances of both the MyClass1_Strong and MyClass2_Strong classes. We then set the class2 property of the
    class1 instance to the MyClass2_Strong instance. We also set the class1 property of the class2 instance to the MyClass1_Strong
    instance. This means that the MyClass1_Strong instance cannot be destroyed until the MyClass2_Strong instance is destroyed. This
    means that the reference counters for each instance will never reach zero, therefore, ARC cannot destroy the instances, which creates a
    memory leak. A memory leak is where an application continues to use memory and does not properly release it. This can cause an
    application to eventually crash.
 
    To resolve a strong reference cycle, we need to prevent one of the classes from keeping a strong hold on the instance of the other class,
    thereby allowing ARC to destroy them both. Swift provides two ways of doing this by letting us define the properties as either a weak or
    unowned reference.
 
    The difference between a weak reference and an unowned reference is that the instance which a weak reference refers to can be nil,
    whereas the instance that an unowned reference is referring to cannot be nil. This means that when we use a weak reference, the property
    must be an optional property, since it can be nil. Let's see how we would use unowned and weak references to resolve a strong reference
    cycle. Let's start by looking at the unowned reference.
 */

class MyClass1_Unowned {
    var name = ""
    unowned let class2: MyClass2_Unowned
    init(name: String, class2: MyClass2_Unowned) {
        self.name = name
        self.class2 = class2
        print("Initializing class1_Unowned with name \(self.name)")
    }
    deinit {
        print("Releasing class1_Unowned with name \(self.name)")
        
    }
}

class MyClass2_Unowned {
    var name = ""
    var class1: MyClass1_Unowned?
    init(name: String) {
        self.name = name
        print("Initializing class2_Unowned with name \(self.name)")
    }
    deinit {
        print("Releasing class2_Unowned with name \(self.name)")
    }
}

/**
    The MyClass1_Unowned class looks pretty similar to classes in the preceding example. The difference here is the MyClass1_Unowned
    class--we set the class2 property to unowned, which means it cannot be nil and it does not keep a strong reference to the instance that
    it is referring to. Since the class2 property cannot be nil, we also need to set it when the class is initialized.
 */

let class2Uno = MyClass2_Unowned(name: "Class2_Unowned")
let class1Uno: MyClass1_Unowned? = MyClass1_Unowned(name: "Class1_Unowned", class2: class2Uno)
class2Uno.class1 = class1Uno
print("Classes going out of scope")

/**
    In the preceding code, we create an instance of the MyClass_Unowned class and then use that instance to create an instance of the
    MyClass1_Unowned class. We then set the class1 property of the MyClass2 instance to the MyClass1_Unowned instance we just
    created. This creates a reference cycle of dependency between the two classes again, but this time, the MyClass1_Unowned instance
    is not keeping a strong hold on the MyClass2_Unowned instance, allowing ARC to release both instances when they are no longer needed.
 */

class MyClass1_Weak {
    var name = ""
    var class2: MyClass2_Weak?
    init(name: String) {
        self.name = name
        print("Initializing class1_Weak with name \(self.name)")
    }
    deinit {
        print("Releasing class1_Weak with name \(self.name)")
    }
}

class MyClass2_Weak {
    var name = ""
    weak var class1: MyClass1_Weak?
    init(name: String) {
        self.name = name
        print("Initializing class2_Weak with name \(self.name)")
    }
    deinit {
        print("Releasing class2_Weak with name \(self.name)")
    }
}

let class1Weak: MyClass1_Weak? = MyClass1_Weak(name: "Class1_Weak")
let class2Weak: MyClass2_Weak? = MyClass2_Weak(name: "Class2_Weak")
class1Weak?.class2 = class2Weak
class2Weak?.class1 = class1Weak
print("Classes going out of scope")

/**
    In the preceding code, we create instances of the MyClass1_Weak and MyClass2_Weak classes and then set the properties of those
    classes to point to the instance of the other class. Once again, this creates a cycle of dependency, but since we set the class1 property
    of the MyClass2_Weak class to weak, it does not create a strong reference, allowing both instances to be released.
 
    It is recommended that you avoid creating circular dependencies, as shown in this section, but there are times when you may need
    them. For those times, remember that ARC needs some help to release them.
 */
