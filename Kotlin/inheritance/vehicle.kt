open class Vehicle(val brand: String, val model: String) { // Open class to allow inheritance
    // Properties of the Vehicle class
    // The `open` keyword allows this class to be inherited from.
    // The `brand` and `model` properties are initialized through the primary constructor.
    // The `drive` method is open, meaning it can be overridden in subclasses.
    // This class represents a generic vehicle with a brand and model.
    // The `drive` method is a placeholder that can be overridden by subclasses to provide specific behavior.
    // This class can be used as a base class for more specific types of vehicles, such as cars, trucks, etc.
    // The `Vehicle` class serves as a base class for all types of vehicles, providing common properties and methods.
    // It can be extended by other classes to create specific types of vehicles.
    // The `drive` method is defined as open, allowing subclasses to provide their own implementation.
    // This allows for polymorphism, where a subclass can be treated as an instance of the
    open fun drive() {
        println("Driving the $brand $model")
    }
}

// Inheritance
// The `Car` class inherits from the `Vehicle` class.
// It adds a new property `numberOfDoors` and overrides the `drive` method to
// provide a specific implementation for cars.
// The `Car` class is a concrete implementation of a vehicle that represents a car.
// It extends the `Vehicle` class, inheriting its properties and methods.
// The `Car` class can be used to create instances of cars with specific attributes like brand, model, and number of doors.
// The `drive` method in the `Car` class provides a specific implementation for driving a car,
// which includes the number of doors in the output message.

class Car(brand: String, model: String, val numberOfDoors: Int) : Vehicle(brand, model) { // Inherits from Vehicle
    override fun drive() {
        println("Driving the $brand $model car with $numberOfDoors doors")
    }
}

// The `Car` class inherits from the `Vehicle` class and overrides the `drive` method.
// The `Car` class adds a new property `numberOfDoors` to represent the number of doors in the car.
// The `drive` method in the `Car` class provides a specific implementation for driving a car,
// which includes the brand, model, and number of doors in the output message.  

fun main() {
    val myCar = Car("Toyota", "Camry", 4)
    myCar.drive() // Prints "Driving the Toyota Camry car with 4 doors"
}
// This code demonstrates inheritance in Kotlin. The `Vehicle` class is an open class that can be inherited from.
// The `Car` class inherits from `Vehicle` and overrides the `drive` method to provide a specific implementation for cars.
// The `main` function creates an instance of `Car` and calls the `drive` method, which prints a message including the brand, model, and number of doors of the car.
// This shows how inheritance allows for code reuse and polymorphism in Kotlin.