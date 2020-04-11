import Cocoa

/**
                            Protocol Oriented Design
                                  Chapter 9
*/

/**
    In this chapter, we will be comparing a protocol-oriented design with an object-oriented design to highlight some of the conceptual
    differences between the two. We will look at how we can use protocols and protocol extensions to replace superclasses, and how
    we can use POP to create a cleaner and easier-to-maintain code base. To do this, we will look at how to define animal types for a
    video game in both an object-oriented and protocol oriented way.
 */

/**
    Requirements:
    We will have 3 categories of animals: sea, land, and air
    Animals may be members of multiple categories. e.g., an alligator can be a member of both the land and sea categories.
    Animals may attack and/or move when they are on a tile that matches the categories they are in.
    Animals will start off with a certain number of hit points, and if those hit points reach 0 or less, they will be considered dead.
 */

///     Object-Oriented Design:

/**
   We start by defining 10 properties for the Animal superclass. These properties will define what type of animal it is and what type
   of attacks/movements it can do. We defined these properties as fileprivate variables b/c we will need to set these properties in
   the subclasses that we defined in the same source file; however, we do not want external entities to change them. The preference
   is for these to be constants, but with an OOP approach; a subclass cannot set/change the value of a constant defined in a superclass.
   For this to work, the subclass will need to be defined in the same physical file as the superclass.

   Next, we will define an initialier that will set the properties. We will set all the properties to false by default, and the hit points to zero.
   It will be up to the subcalsses to set the appropriate properties that apply. Since our properties are fileprivate, we need to create some
   getter methods so that we can retrieve their values. We will also create a couple of additional methods that will see if the animal is
   alive. We will need another to deduct hit points when the animal takes a hit.

   One big disadvantage of this design, as noted is that all the subclasses need to be in the same physical file as the Animal superclass.
   Considering how large the animal classses can be once we get in all the game logic, we probably do not want all of these types in
   the same file. To avoid this, we could set the properties to internal or public, but that would not prevent the values from being
   changed by instances of other types. This is a major drawback of our object-oriented design.
*/

class OOAnimal {
    fileprivate var landAnimal = false
    fileprivate var landAttack = false
    fileprivate var landMovement = false
    
    fileprivate var seaAnimal = false
    fileprivate var seaAttack = false
    fileprivate var seaMovement = false
    
    fileprivate var airAnimal = false
    fileprivate var airAttack = false
    fileprivate var airMovement = false
    
    fileprivate var hitPoints = 0
    
    init() {
        landAnimal = false
        landAttack = false
        landMovement = false
        airAnimal = false
        airAttack = false
        airMovement = false
        seaAnimal = false
        seaAttack = false
        seaMovement = false
        hitPoints = 0
    }
    func isLandAnimal() -> Bool {
        return landAnimal
    }
    func canLandAttack() -> Bool {
           return landAttack
       }
    func canLandMove() -> Bool {
        return landMovement
    }
    func isSeaAnimal() -> Bool {
           return seaAnimal
       }
    func canSeaAttack() -> Bool {
        return seaAttack
    }
    func canSeaMove() -> Bool {
           return seaMovement
       }
    func isAirAnimal() -> Bool {
        return airAnimal
    }
    func canAirAttack() -> Bool {
           return airAttack
       }
    func canAirMove() -> Bool {
        return airMovement
       }
    func doLandAttack() {}
    func doLandMovement() {}
    func doSeaAttack() {}
    func doSeaMovement() {}
    func doAirAttack() {}
    func doAirMovement() {}
    func takeHit(amount: Int) {
        hitPoints -= amount
    }
    func hitPointsRemaining() -> Int {
        return hitPoints
    }
    func isAlive() -> Bool {
           return hitPoints > 0 ? true : false
       }
}

/**
    As we can see, these classes set the functionality needed for each animal. Another disadvantage for this OOP design is that we do
    not have a single point that defines what type of animal (air, land, or sea) this is. It is very easy to set the wrong flag or add the wrong
    function when we cut and paste, or type in the code. This may lead use to have an animal that incorporates flags and functions that
    it was never supposed to deal with.
 */

class OOLion: OOAnimal {
    override init() {
        super.init()
        landAnimal = true
        landAttack = true
        landMovement = true
        hitPoints = 20
    }
    override func doLandAttack() {
        print("Lion Attack")
    }
    override func doLandMovement() {
        print("Lion Move")
    }
}

class OOAlligator: OOAnimal {
    override init() {
        super.init()
        landAnimal = true
        landAttack = true
        landMovement = true
        seaAnimal = true
        seaAttack = true
        seaMovement = true
        hitPoints = 35
    }
    override func doLandAttack() {
        print("Alligator Land Attack")
    }
    override func doLandMovement() {
        print("Alligator Land Move")
    }
    override func doSeaAttack() {
        print("Alligator Sea Attack")
    }
    override func doSeaMovement() {
        print("Alligator Sea Move")
    }
}

/**
    Since both classes are animals, we can use polymorphism to access them:
 */

var animals = [OOAnimal]()
animals.append(OOAlligator())
animals.append(OOAlligator())
animals.append(OOLion())

for (index, animal) in animals.enumerated() {
    if animal.isAirAnimal() {
        print("Animal at \(index) is Air")
    }
    if animal.isLandAnimal() {
        print("Animal at \(index) is Land")
    }
    if animal.isSeaAnimal() {
        print("Animal at \(index) is Sea")
    }
}

/**
    The way we designed the animal types here would work; however, there are several drawbacks in this design. The first is the
    large monolithic Animal superclass. Another is not being able to define constants in the superclass that the subclasses can set.
    We could define various initializers for the superclass that would correctly set the constants for the different animal categories;
    however, these initializers will become pretty complex and hard to maintain as we add more animals. The builder pattern could
    help us with the initialization, but as we are about to see, a protocol-oriented design would be even better. One final drawback
    is the use of flags to define the type of animal, and the type of attack and movements an animal can perform. If we do not
    correctly set these flags, then the animal will not behave correctly.
 */

///     Protocol-Oriented Design

/**
    Protocol inheritance is where one protocol can inherit the requirements from one or more protocols. This is similar to class
    inheritance in OOP, but instead of inheriting functionality, we are inheriting requirements. We can also inherit requirements from
    multiple protocols, whereas a class in Swift can only have one superclass.
 */

protocol Name {
    var firstName: String { get set }
    var lastName: String { get set }
}

protocol Age {
    var age: Double { get set }
}

protocol Fur {
    var furColor: String { get set }
}

protocol Hair {
    var hairColor: String { get set }
}

/**
    If you find yourself creating protocols with single requirements, you probably want to reconsider your overall design. Protocols
    should not be this granular because we end up  with too many protocols and they become hard to manage. We are using small
    protocols here as an example.
 
    Now we use protocol inheritance to create additional protocols:
 */

protocol Person: Name, Age, Hair {
    var height: Double { get set }
}

protocol Dog: Name, Age, Fur {
    var breed: String { get set }
}

/**
    Protocol inheritance is extremely powerful because we can define several smaller protocols and mix/match them to create
    larger protocols. You will want to be careful not to create protocols that are too granular.
 
    Protocol composition allows types to conform to more than one protocol. This is one of the many advantages that protocol-oriented
    design has over object-oriented design. With OOP, a class can have only one superclass. This can lead to very large superclasses.
    With POP, we are encouraged to create multiple smaller protocols with very specific requirements.
 */

protocol Occupation {
    var occupationName: String { get set }
    var yearlySalary: Double { get set }
    var experienceYears: Double { get set }
}

struct Programmer: Person, Occupation {
    var firstName: String
    var lastName: String
    var age: Double
    var hairColor: String
    var height: Double
    var occupationName: String
    var yearlySalary: Double
    var experienceYears: Double
}

/**
    Protocol composition and inheritance may not seem that powerful on their own; however, when we combine them with protocol
    extensions, we have a very powerful programming paradigm.
 
    We begin by rewriting the Animal superclass as a protocol:
        If we were putting in all the requirements for an animal in a video game, this protocol would contain all the requirements
        that would be common to every animal; to be consistent with our OOP design we need to only add the hitPoints property.
 */

protocol Animal {
    var hitPoints: Int { get set }
}

/**
    Next we need an Animal protocol extension, which will contain the functionality that is common for all types that conform to the
    protocol:
 */

extension Animal {
    mutating func takeHit(amount: Int) {
        hitPoints -= amount
    }
    func hitPointsRemaining() -> Int {
        return hitPoints
    }
    func isAlive() -> Bool {
        return hitPoints > 0 ? true : false
    }
}

/**
    The protocol extension above contains the same takeHit(), hitPointsRemaining(), and isAlive() methods that we saw in the Animal
    superclass from the OOP example. Any type that conforms to the Animal protocol will automatically inherit these three methods.
    
    Now lets define our LandAnimal, SeaAnimal, and AirAnimal protocols:
*/

protocol LandAnimal: Animal {
    var landAttack: Bool { get }
    var landMovement: Bool { get }
    
    func doLandAttack()
    func doLandMovement()
}

protocol SeaAnimal: Animal {
    var seaAttack: Bool { get }
    var seaMovement: Bool { get }
    
    func doSeaAttack()
    func doSeaMovement()
}

protocol AirAnimal: Animal {
    var airAttack: Bool { get }
    var airMovement: Bool { get }
    
    func doAirAttack()
    func doAirMovement()
}

/**
    Unlike the Animal superclass in the OOP design, these three protocols only contain the functionality needed for their particular type
    of animal. Each of these protocols only contains 4 lines of code while the animal superclass from the OOP example contains a lot
    more. This makes our protocol design easier to read and manage. The protocol design is also much safer because the functionality
    for various animal types is isolated in their own protocol rather than being embedded in a giant superclass. We are also able to avoid
    the use of flags to define the animal category and, instead define the category of the animal by the protocols it conforms to.
 
    In a full design, we would probably need to add some protocol extensions for each of the animal types, but once again, to be
    consistent we do not need to implement them here.
 
    Now lets look at how to create our Lion and Alligator types:
 */

struct Lion: LandAnimal {
    var hitPoints = 20
    let landAttack = true
    let landMovement = true
    
    func doLandAttack() {
        print("Lion Attack")
    }
    func doLandMovement() {
        print("Lion Move")
    }
}

struct Alligator: LandAnimal, SeaAnimal {
    var hitPoints = 35
    let landAttack = true
    let landMovement = true
    let seaAttack = true
    let seaMovement = true
    
    func doLandAttack() {
        print("Alligator Land Attack")
    }
    func doLandMovement() {
        print("Alligator Land Move")
    }
    func doSeaAttack() {
        print("Alligator Sea Attack")
    }
    func doSeaMovement() {
        print("Alligator Sea Move")
    }
}

/**
    Notice that we specify that the Lion type conforms to the LandAnimal protocol, while the Alligator type conforms to both the
    LandAnimal and SeaAnimal protocols. Both the Lion and Alligator types originate from the Animal protocol; therefore, they will inherit
    the functionality added with the Animal protocol extension. If our animal type protocols also had extensions, then they would also
    inherit the function added by those extensions as well. With protocol inheritance, composition, and extensions, our concrete types
    contain only the functionality needed by the particular animal types that they conform to, unlike in the OOP design, where each
    animal would contain all of the functionality from the huge, single superclass.
 
    Since the Lion and the Alligator originate from the Animal protocol, we can still use polymorphism as we did in the OOP example:
 */

var protocol_animals = [Animal]()

protocol_animals.append(Alligator())
protocol_animals.append(Alligator())
protocol_animals.append(Lion())

for (index, animal) in protocol_animals.enumerated() {
    if let _ = animal as? AirAnimal {
        print("Animal at \(index) is Air")
    }
    if let _ = animal as? LandAnimal {
        print("Animal at \(index) is Land")
    }
    if let _ = animal as? SeaAnimal {
        print("Animal at \(index) is Sea")
    }
}

/**
    With protocols, we are able to use the where statement to filter the instances of our types. For example, if we only want to get the
    instances that conform to the SeaAnimal protocol, we can create a for loop as follows:
 */

for (index, animal) in protocol_animals.enumerated() where animal is SeaAnimal {
    print("Only Sea Animal: \(index)")
    print(animal.hitPoints)
}

/// Structures versus classes

/**
    You may have noticed that in the OOP design we used classes, while in the POP design we used structures. Classes, which are
    reference types, are one of the pillars of OOP programming and every major OOP language uses them. For Swift, Apple has said
    that we should prefer value types (structures) to reference types (classes). While this may seem odd for anyone who has extensive
    experience with OOP, there are several good reasons for this recommendation.
 
    The biggest reason, for using structures (value types) over classes is the performance gain we get. Value types do not incur the
    additional overhead for reference counting that reference types incur. Value types are also stored on the stack, which provides
    better performance as compared to reference types, which are stored on the heap. It is also worth noting that copying values is
    relatively cheap in Swift.
 
    Keep in mind that, as our value types get large, the performance cost of copying can negate the other performance gains of value
    types. In the Swift standard library, Apple has implemented copy-on-write behavior to reduce the overhead of copying large value
    types.
 
    With copy-on-write behavior, we do not create a new copy of our value type when we assign it to a new variable.  The copy is
    postponed until one of the instances changes the value. This means that, if we have an array of one million numbers, when we
    pass this array to another array we will not make a copy of the one million numbers until one of the arrays changes. This can
    greatly reduce the overhead incurred from copying instances of our value types.
 
    Value types are also a lot safer than references types, because we do not have multiple references pointing to the same instance,
    as we do with reference types. This really becomes apparent when we are dealing with a multithreaded environment. Value types
    are also safer because we do not have memory leaks caused by common programming errors, such as the strong reference cycles
    that will be discussed later in Chapter 16, Memory Management.
 
    The thing to understand is that v alue types, like structures, are safer, and for the most part provide better performance in Swift, as
    compared to reference types, such as classes. 
 */
