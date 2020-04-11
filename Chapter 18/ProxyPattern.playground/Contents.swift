import Cocoa

/**
                       Adopting Design Patterns in Swift:
                              Proxy Pattern
                               Chapter 18
*/

/**
    In the proxy design pattern, there is one type acting as an interface for another type or API. This wrapper class, which is the proxy,
    can then add functionality to the object, make the object available over a network, or restrict access to the object.
 */

/// Understanding the problem

/**
    We can use the proxy pattern to solve several problems, but I find that I mainly use this pattern to solve one of two problems.
    The first problem that I use the proxy pattern to solve is when I want to create a layer of abstraction between a single API and my
    code. The API could be a local or remote API, but I usually use this pattern to put an abstraction layer between my code and a remote
    service. This will allow changes to the remote API without the need to refactor large portions of the code.
    The second problem that I use the proxy pattern to solve is when I need to make changes to an API, but I do not have the code or
    there is already a dependency on the API elsewhere in the application.
 */

/// Understanding the solution

/**
    To solve these problems, the proxy pattern tells us that we should create a type that will act as an interface for interacting with the
    other type or API. In the example, we will show how to use the proxy pattern to add functionality to an existing type.
 */

/// Implementing the proxy pattern

/**
    In this section, we will demonstrate the proxy pattern by creating a house class that we can add multiple floor plans to, where each
    floor plan represents a different story of the house. Let's begin by creating a FloorPlan protocol:
 */

protocol FloorPlan {
    var bedRooms: Int { get set }
    var utilityRooms: Int { get set }
    var bathRooms: Int { get set }
    var kitchen: Int { get set }
    var livingRooms: Int { get set }
}

/**
    In the FloorPlan protocol, we define five properties that will represent the number of rooms contained in each floor plan. Now, let's
    create an implementation of the FloorPlan protocol named HouseFloorPlan, which is as follows:
 */

struct HouseFloorPlan: FloorPlan {
    var bedRooms = 0
    var utilityRooms = 0
    var bathRooms = 0
    var kitchen = 0
    var livingRooms = 0
}

/**
    The HouseFloorPlan structure implements all five properties required from the FloorPlan protocol and assigns default values to them.
    Next, we will create the House type, which will represent a house:
 */

struct House {
    var stories = [FloorPlan]()
    mutating func addStory(floorPlan: FloorPlan) {
        stories.append(floorPlan)
    }
}

/**
    Within the House structure, we have an array of instances that conforms to the FloorPlan protocol where each floor plan will represent
    one story of the house. We also have a function named addStory(), which accepts an instance of a type that conforms to the
    FloorPlan protocol. This function will add the floor plan to the array of FloorPlan protocols.
    If we think about the logic of this class, there is one problem that we might encounter; we are allowed to add as many floor plans as
    we want, which may lead to houses that are 60 or 70 stories high. This would be great if we were building skyscrapers, but we just
    want to build basic single-family houses. If we want to limit the number of floor plans without changing the House class (either we
    cannot change it, or we simply do not want to), we can implement the proxy pattern. The following example shows how to implement
    the HouseProxy class, where we limit the number of floor plans we can add to the house:
 */


struct HouseProxy {
    var house = House()
    mutating func addStory(floorPlan: FloorPlan) -> Bool {
        if house.stories.count > 3 {
            house.addStory(floorPlan: floorPlan)
             return true
        } else {
            return false
        }
    }
}

/**
    We begin the HouseProxy class by creating an instance of the House class. We then create a method named addStory(), which lets
    us add a new floor plan to the house. In the addStory() method, we check to see if the number of stories in the house is fewer than
    three; if so, we add the floor plan to the house and return true. If the number of stories is equal to or greater than three, then we do
    not add the floor plan to the house and return false. Let's see how we can use this proxy:
 */

var ourHouse = HouseProxy()
var basement = HouseFloorPlan(bedRooms: 0, utilityRooms: 1, bathRooms: 1, kitchen: 0,
                              livingRooms: 0)
var firstStory = HouseFloorPlan(bedRooms: 1, utilityRooms: 0, bathRooms: 2, kitchen: 1,
                                livingRooms: 1)
var secondStory = HouseFloorPlan(bedRooms: 2, utilityRooms: 0, bathRooms: 1, kitchen: 0,
                                 livingRooms: 0)
var additionalStory = HouseFloorPlan(bedRooms: 1, utilityRooms: 0, bathRooms: 1, kitchen: 0, livingRooms: 0)

ourHouse.addStory(floorPlan: basement)
ourHouse.addStory(floorPlan: firstStory)
ourHouse.addStory(floorPlan: secondStory)
ourHouse.addStory(floorPlan: additionalStory)

/**
    In the example code, we start off by creating an instance of the HouseProxy class named ourHouse. We then create four instances of
    the HouseFloorPlan type, each with a different number of rooms. Finally, we attempt to add each of the floor plans to the ourHouse
    instance. If we run this code, we will see that the first three instances of the floorplans class were added to the house successfully, but
    the last one wasn't because we are only allowed to add three floors.
    The proxy pattern is very useful when we want to add some additional functionality or error checking to a type, but we do not want to
    change the actual type itself. We can also use it to add a layer of abstraction between a remote or local API.
 */
