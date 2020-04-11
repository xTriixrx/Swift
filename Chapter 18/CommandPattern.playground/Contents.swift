import Cocoa

/**
                       Adopting Design Patterns in Swift:
                            Command Pattern
                               Chapter 18
*/

/**
    The command design pattern lets us define actions that we can execute later. This pattern generally encapsulates all the information
    needed to call or trigger the actions at a later time.
 */

/// Understanding the problem

/**
    There are times in the applications when we need to separate the execution of a command from its invoker. Typically, this is when we
    have a type that needs to perform one of several actions; however, the choice of which action to use needs to be made at runtime.
 */

/// Understanding the solution

/**
    The command pattern tells us that we should encapsulate the logic for the actions into a type that conforms to a command protocol.
    We can then provide instances of the command types for use by the invoker. The invoker will use the interface provided by the
    protocol to invoke the necessary actions.
 */

/// Implementing the command pattern

/**
    In this section, we will demonstrate how to use the command pattern by creating a Light type. In this type, we will define the
    lightOnCommand and lightOffCommand commands and will use the turnOnLight() and turnOffLight() methods to invoke these
    commands. We will begin by creating a protocol named Command, which all of the command types will conform to. Here is the
    command protocol:
 */

protocol Command {
    func execute()
}

/**
    This protocol contains a method named execute(), which will be used to execute the command. Now, let's look at the command types
    that the Light type will use to turn the light on and off. They are as follows:
 */

struct RockerSwitchLightOnCommand: Command {
    func execute() {
        print("Rocker Switch:Turning Light On")
    }
}
struct RockerSwitchLightOffCommand: Command {
    func execute() {
        print("Rocker Switch:Turning Light Off")
    }
}
struct PullSwitchLightOnCommand: Command {
    func execute() {
        print("Pull Switch:Turning Light On")
    }
}
struct PullSwitchLightOffCommand: Command {
    func execute() {
        print("Pull Switch:Turning Light Off")
    }
}

/**
    The RockerSwitchLightOffCommand, RockerSwitchLightOnCommand, PullSwitchLightOnCommand, and
    PullSwitchLightOffCommand commands all conform to the Command protocol by implementing the execute() method; therefore,
    we will be able to use them in the Light type. Now, let's look at how to implement the Light type:
 */

struct Light {
    var lightOnCommand: Command
    var lightOffCommand: Command
    func turnOnLight() {
        self.lightOnCommand.execute()
    }
    func turnOffLight() {
        self.lightOffCommand.execute()
    }
}

/**
    In the Light type, we start off by creating two variables, named lightOnCommand and lightOffCommand, which will contain instances
    of types that conform to the Command protocol. Then we create the turnOnLight() and turnOffLight() methods that we will use to turn
    the light on and off. In these methods, we call the appropriate command to turn the light on or off.
    We would then use the Light type as follow:
 */

var on = PullSwitchLightOnCommand()
var off = PullSwitchLightOffCommand()
var light = Light(lightOnCommand: on, lightOffCommand: off)
light.turnOnLight()
light.turnOffLight()
light.lightOnCommand = RockerSwitchLightOnCommand()
light.turnOnLight()

/**
    In this example, we begin by creating an instance of the PullSwitchLightOnCommand type named on and an instance of the
    PullSwitchLightOffCommand type named off. We then create an instance of the Light type using the two commands that we just
    created and call the turnOnLight() and turnOffLight() methods of the Light instance to turn the light on and off. In the last two lines, we
    change the lightOnCommand method, which was originally set to an instance of the PullSwitchLightOnCommand class, to an
    instance of the RockerSwitchLightOnCommand type. The Light instance will now use the RockerSwitchLightOnCommand type
    whenever we turn the light on. This allows us to change the functionality of the Light type during runtime.
    There are several benefits from using the command pattern. One of the main benefits is that we are able to set which command to
    invoke at runtime, which also lets us swap the commands out with different implementations that conform to the Command protocol
    as needed throughout the life of the application. Another advantage of the command pattern is that we encapsulate the details of
    command implementations within the command types themselves rather than in the container type.
 */
