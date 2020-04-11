import Cocoa

/**
                       Adopting Design Patterns in Swift:
                              Builder Pattern
                               Chapter 18
*/

/**
    The builder pattern helps us with the creation of complex objects and enforces the process of how these objects are created.
    With this pattern, we generally separate the creation logic from the complex type and put it in another type. This allows us to
    use the same construction process to create different representations of the type.
 */

/// Understanding the problem

/**
    The problem that the builder pattern is designed to address is when an instance of a type requires a large number of configurable
    values. We could set the configuration options when we create instances of the class, but that can cause issues if the options are not
    set correctly or we do not know the proper values for all the options. Another issue is the amount of code that may be needed to set
    all the configurable options each time we create an instance of the types.
 */

/// Understanding the solution

/**
    The builder pattern solves this problem by introducing an intermediary known as a builder type. This builder type contains most,
    if not all, of the information necessary to create an instance of the original complex type.
    There are two methods that we can use to implement the builder pattern. The first method is to have multiple builder types where
    each of the types contains the information to configure the original complex object in a specific way. In the second method, we
    implement the builder pattern with a single builder type that sets all the configurable options to a default value and then we would
    change the values as needed.
    In this section, we will look at both ways to use the builder pattern, because it is important to understand how each works.
 */

/// Implementing the builder pattern

/**
    Before we show how we would use the builder pattern, let's look at how to create a complex structure without the builder pattern
    and the problems we run into.
    The following code creates a structure named BurgerOld, and does not use the builder pattern:
 */

struct BurgerOld {
      var name: String
      var patties: Int
      var bacon: Bool
      var cheese: Bool
      var pickles: Bool
      var ketchup: Bool
      var mustard: Bool
      var lettuce: Bool
      var tomato: Bool
      init(name: String, patties: Int, bacon: Bool, cheese: Bool,
      pickles:Bool,ketchup: Bool,mustard: Bool,lettuce: Bool, tomato: Bool) {
        self.name = name
        self.patties = patties
        self.bacon = bacon
        self.cheese = cheese
        self.pickles = pickles
        self.ketchup = ketchup
        self.mustard = mustard
        self.lettuce = lettuce
        self.tomato = tomato
    }
}

/**
    In the BurgerOld structure, we have several properties that define which condiments are on the burger and the name of the burger.
    Since we need to know which items are on the burgers and which items aren't, when we create an instance of the BurgerOld structure
    the initializer requires us to define each item. This can lead to some complex initializations throughout the application, not to mention
    that, if we had more than one standard burger (bacon cheeseburger, cheeseburger, hamburger, and so on), we would need to make
    sure that each is defined correctly. Let's see how to create instances of the BurgerOld class:
 */

/// Create Hamburger
var hamburger = BurgerOld(name: "Hamburger", patties: 1, bacon: false, cheese: false, pickles: false, ketchup: false, mustard: false, lettuce: false, tomato: false)

/// Create Cheeseburger
var cheeseburger = BurgerOld(name: "Cheeseburger", patties: 1, bacon: false, cheese: true, pickles: false, ketchup: false, mustard: false, lettuce: false, tomato: false)

/**
    As we can see, creating instances of the BurgerOld type requires a lot of code. Now, let's look at a better way to do this. In this
    example, we will show how to use multiple builder types where each type will define the condiments that are on a particular burger.
    We will begin by creating a BurgerBuilder protocol that will have the following code in it:
 */

protocol BurgerBuilder {
    var name: String { get }
    var patties: Int { get }
    var bacon: Bool { get }
    var cheese: Bool { get }
    var pickles: Bool { get }
    var ketchup: Bool { get }
    var mustard: Bool { get }
    var lettuce: Bool { get }
    var tomato: Bool { get }
}

/**
    This protocol simply defines the nine properties that will be required for any type that implements this protocol. Now, let's create
    two structures that implement this protocol: the HamburgerBuilder and the CheeseBurgerBuilder structures:
 */

struct HamburgerBuilder: BurgerBuilder {
    let name = "Hamburger"
    let patties = 1
    let bacon = false
    let cheese = false
    let pickles = false
    let ketchup = false
    let mustard = false
    let lettuce = false
    let tomato = false
}

struct CheeseburgerBuilder: BurgerBuilder {
    let name = "Cheeseburger"
    let patties = 1
    let bacon = false
    let cheese = false
    let pickles = false
    let ketchup = false
    let mustard = false
    let lettuce = false
    let tomato = false
}

/**
    In both the HamburgerBuilder and the CheeseBurgerBuilder structures, all we are doing is defining the values for each of the required
    properties. In more complex types, we might need to initialize additional resources.
    Now, let's look at the Burger structure, which will use instances of the BurgerBuilder protocol to create instances of itself.
    The following code shows this new Burger type:
 */

struct Burger {
      var name: String
      var patties: Int
      var bacon: Bool
      var cheese: Bool
      var pickles: Bool
      var ketchup: Bool
      var mustard: Bool
      var lettuce: Bool
      var tomato: Bool
    init(builder: BurgerBuilder) {
        self.name = builder.name
        self.patties = builder.patties
        self.bacon = builder.bacon
        self.cheese = builder.cheese
        self.pickles = builder.pickles
        self.ketchup = builder.ketchup
        self.mustard = builder.mustard
        self.lettuce = builder.lettuce
        self.tomato = builder.tomato
    }
      func showBurger() {
         print("Name:\(name)")
         print("Patties: \(patties)")
         print("Bacon: \(bacon)")
         print("Cheese: \(cheese)")
         print("Pickles: \(pickles)")
         print("Ketchup: \(ketchup)")
         print("Mustard: \(mustard)")
         print("Lettuce: \(lettuce)")
         print("Tomato: \(tomato)")
    }
}

/**
    The difference between this Burger structure and the BurgerOld structure shown earlier is the initializer. In the previous BurgerOld
    structure, the initializer took nine arguments-one for each constant defined in the structure. In the new Burger structure, the initializer
    takes one argument, which is an instance of a type that conforms to the BurgerBuilder protocol. This new initializer allows us to
    create instances of the Burger class as follows:
 */

// Create Hamburger
var myBurger = Burger(builder: HamburgerBuilder())
myBurger.showBurger()
// Create Cheeseburger with tomatoes
var myCheeseBurger = Burger(builder: CheeseburgerBuilder())
// Lets hold the tomatoes
myCheeseBurger.tomato = false
myCheeseBurger.showBurger()

/**
    If we compare how we create instances of the new Burger structure to the earlier BurgerOld structure, we can see that it is much
    easier to create instances of the Burger structure. We also know that we are correctly setting the property values for each type of
    burger because the values are set directly in the builder classes.
    As we mentioned earlier, there is a second method that we can use to implement the builder pattern. Rather than having multiple
    builder types, we can have a single builder type that sets all the configurable options to a default value; then we change the values as
    needed. I use this implementation method a lot when I am updating older code because it is easy to integrate it with preexisting code.
    For this implementation, we will create a single BurgerBuilder structure. This structure will be used to create instances of the
    BurgerOld structure and will, by default, set all the ingredients to their default values.
    The BurgerBuilder structure also gives us the ability to change which ingredients will go on the burger prior to creating instances of
    the BurgerOld structure. We create the BurgerBuilder structure as follows:
 */

struct BurgerBuilder1 {
    var name = "Burger"
    var patties = 1
    var bacon = false
    var cheese = false
    var pickles = true
    var ketchup = true
    var mustard = true
    var lettuce = false
    var tomato = false
    mutating func setPatties(choice: Int) {
    self.patties = choice
    }
    mutating func setBacon(choice: Bool) {
        self.bacon = choice
    }
    mutating func setCheese(choice: Bool) {
        self.cheese = choice
    }
    mutating func setPickles(choice: Bool) {
        self.pickles = choice
    }
    mutating func setKetchup(choice: Bool) {
        self.ketchup = choice
    }
    mutating func setMustard(choice: Bool) {
        self.mustard = choice
    }
    mutating func setLettuce(choice: Bool) {
        self.lettuce = choice
    }
    mutating func setTomato(choice: Bool) {
        self.tomato = choice
    }
    func buildBurgerOld(name: String) -> BurgerOld {
        return BurgerOld(name: self.name, patties: self.patties, bacon: self.bacon, cheese: self.cheese, pickles: self.pickles, ketchup: self.ketchup, mustard: self.mustard, lettuce: self.lettuce, tomato: self.tomato)
    }
}

/**
    In the BurgerBuilder1 structure, we define the nine properties (ingredients) for the burger and then create a setter method for each of
    the properties except for the name property. We also create one method named buildBurgerOld(), which will create an instance of the
    BurgerOld structure based on the values of the properties for the BurgerBuilder instance. We use the BurgerBuilder structure as
    follows:
 */

var burgerBuilder = BurgerBuilder1()
burgerBuilder.setCheese(choice: true)
burgerBuilder.setBacon(choice: true)
var jonBurger = burgerBuilder.buildBurgerOld(name: "Jon's Burger")

/**
    In this example, we create an instance of the BurgerBuilder structure. We then use the setCheese() and setBacon() methods to add
    cheese and bacon to the burger. Finally, we call the buildBurgerOld() method to create the instance of the burgerOld structure.
    As we can see, both methods that were used to implement the builder pattern greatly simplify the creation of the complex type. Both
    methods also ensured that the instances were properly configured with default values. If you find yourself creating instances of types
    with very long and complex initialization commands, I recommend that you look at the builder pattern to see if you can use it to
    simplify the initialization.
 */
