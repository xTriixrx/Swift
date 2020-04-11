import Cocoa

/**
                       Adopting Design Patterns in Swift:
                              Facade Pattern
                               Chapter 18
*/

/**
    The facade pattern provides a simplified interface to a larger and more complex body of code. This allows us to make the libraries
    easier to use and understand by hiding some of the complexities. It also allows us to combine multiple APIs into a single, easier to use
    API, which is what we will see in the example.
 */

/// Understanding the problem

/**
    The facade pattern is often used when we have a complex system that has a large number of independent APIs that are designed to
    work together. Sometimes it is hard to tell where we should use the facade pattern during the initial application design. The reason for
    this is that we normally try to simplify the initial API design; however, over time, and as requirements change and new features are
    added, the APIs become more and more complex, and then it becomes pretty evident where we should have used the facade pattern.
 */

/// Understanding the solution

/**
    The main idea of the facade pattern is to hide the complexity of the APIs behind a simple interface. This offers us several advantages,
    with the most obvious being that it simplifies how we interact with the APIs. It also promotes loose coupling, which allows the APIs to
    change, as requirements change, without the need to refactor all the code that uses them.
 */

/// Implementing the facade pattern

/**
    To demonstrate the facade pattern, we will create three APIs: HotelBooking, FlightBooking, and RentalCarBookings. These APIs will
    be used to search for and book hotels, flights, and rental cars for trips. While we could very easily call each of the APIs individually in
    the code, we are going to create a TravelFacade structure that will allow us to access the functionality of the APIs in single calls.
    We will begin by defining the three APIs. Each of the APIs will need a data storage class that will store the information about the hotel,
    flight, or rental car. We will start off by implementing the hotel API:
 */

struct Hotel {
      //Information about hotel room
}
struct HotelBooking {
    static func getHotelNameForDates(to: Date, from: Date) -> [Hotel]? {
        let hotels = [Hotel]()
        //logic to get hotels
        return hotels
    }
    static func bookHotel(hotel: Hotel) {
        // logic to reserve hotel room
    }
}

/**
    The hotel API consists of the Hotel and Hotel Booking structures. The Hotel structure will be used to store the information about a
    hotel room, and the HotelBooking structure will be used to search for a hotel room and to book the room for the trip. The flight and
    rental car APIs are very similar to the hotel API. The following code shows both of these APIs:
 */


struct Flight {
    //Information about flights
}
struct FlightBooking {
    static func getFlightNameForDates(to: Date, from: Date) -> [Flight]? {
        let flights = [Flight]()
        //logic to get flights
        return flights
    }
    static func bookFlight(flight: Flight) {
        // logic to reserve flight
    }
}
struct RentalCar {
    //Information about rental cars
}
struct RentalCarBooking {
    static func getRentalCarNameForDates(to: Date, from: Date) ->
    [RentalCar]?
{
        let cars = [RentalCar]()
        //logic to get flights
        return cars
}
    static func bookRentalCar(rentalCar: RentalCar) {
        // logic to reserve rental car
    }
}

/**
    In each of these APIs, we have a structure that is used to store information and a structure that is used to provide the search/booking
    functionality. In the initial design, it would be very easy to call these individual APIs within the application; however, as we all know,
    requirements tend to change, which causes the APIs to change over time.
    By using the facade pattern here, we are able to hide how we implement the APIs; therefore, if we need to change how the APIs work
    in the future, we will only need to update the facade type rather than refactoring all of the code. This makes the code easier to
    maintain and update in the future. Now let's look at how we will implement the facade pattern by creating a TravelFacade structure:
 */

struct TravelFacade {
    var hotels: [Hotel]?
    var flights: [Flight]?
    var cars: [RentalCar]?
    init(to: Date, from: Date) {
        hotels = HotelBooking.getHotelNameForDates(to: to, from: from)
        flights = FlightBooking.getFlightNameForDates(to: to, from:from)
        cars = RentalCarBooking.getRentalCarNameForDates(to: to, from:from)
    }
    func bookTrip(hotel: Hotel, flight: Flight, rentalCar: RentalCar) { HotelBooking.bookHotel(hotel: hotel)
        FlightBooking.bookFlight(flight: flight)
        RentalCarBooking.bookRentalCar(rentalCar: rentalCar)
    }
}

/**
    The TravelFacade class contains the functionality to search the three APIs and book a hotel, flight, and rental car. We can now use
    the TravelFacade class to search for hotels, flights, and rental cars without having to directly access the individual APIs. As we
    mentioned at the start of this chapter, it is not always obvious when we should use the facade pattern in the initial design. A good
    rule to follow is: if we have several APIs that are working together to perform a task, we should think about using the facade pattern.
 */
