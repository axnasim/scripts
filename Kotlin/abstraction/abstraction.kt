// abstraction/abstraction.kt
// This file demonstrates abstraction in Kotlin using an abstract class `Animal` and concrete classes `Dog` and `Cat`.
// Abstraction allows us to define a common interface for different types of objects while hiding the implementation details.
// In this example, the `Animal` class is abstract and defines an abstract method `makeSound()`.
// The `Dog` and `Cat` classes inherit from `Animal` and provide specific implementations of the `makeSound()` method.
// The `main` function creates a list of `Animal` objects and iterates through them to call the `makeSound()` method,
// demonstrating abstraction in action. This allows for flexible and reusable code, as new animal types can be added
// without changing the existing code that uses the `Animal` class. The `Animal` class serves as a base class,
// while `Dog` and `Cat` provide specific implementations of the `makeSound()` method,
// showcasing the power of abstraction in Kotlin.   

abstract class Animal { // Abstract class
    abstract fun makeSound() // Abstract method to be implemented by subclasses
}   
// Concrete classes
class Dog : Animal() { // Inherits from Animal
    override fun makeSound() { // Implement the abstract method for Dog
        println("Woof!") // Dog sound
    }
}       

class Cat : Animal() { // Inherits from Animal
    override fun makeSound() { // Implement the abstract method for Cat
        println("Meow!") // Cat sound
    }
}   

// Main function to demonstrate abstraction
// This function creates a list of animals and calls their makeSound method 
// Each animal object calls its own overridden makeSound method, demonstrating abstraction
fun main() {
    val animals: List<Animal> = listOf(Dog(), Cat()) // List of Animal objects

    for (   animal in animals) { // Iterate through each animal
        animal.makeSound() // Call the makeSound method on each animal
    }
}
// Each animal makes its own sound, demonstrating abstraction   
// This code demonstrates abstraction in Kotlin using an abstract class `Animal` and concrete classes `Dog` and `Cat`.
// Abstraction allows us to define a common interface for different types of objects while hiding the implementation    
// details. In this example, the `Animal` class is abstract and defines an abstract method `makeSound()`.
// The `Dog` and `Cat` classes inherit from `Animal` and provide specific implementations
// of the `makeSound()` method. The `main` function creates a list of `Animal` objects and iterates through them to call
// the `makeSound()` method, demonstrating abstraction in action. This allows for flexible and reusable code, as new animal types can be added
// without changing the existing code that uses the `Animal` class. The `Animal` class serves as a base class,
// while `Dog` and `Cat` provide specific implementations of the `makeSound()` method,
// showcasing the power of abstraction in Kotlin.   
// This code demonstrates abstraction in Kotlin using an abstract class `Animal` and concrete classes `Dog` and `Cat`.
// Abstraction allows us to define a common interface for different types of objects while hiding the implementation    
// details. In this example, the `Animal` class is abstract and defines an abstract method `makeSound()`.
// The `Dog` and `Cat` classes inherit from `Animal` and provide specific implementations   
// of the `makeSound()` method. The `main` function creates a list of `Animal` objects and iterates through them to call
// the `makeSound()` method, demonstrating abstraction in action. This allows for flexible and reusable
// code, as new animal types can be added without changing the existing code that uses the `Animal` class.
// The `Animal` class serves as a base class, while `Dog` and `Cat` provide specific implementations
// of the `makeSound()` method, showcasing the power of abstraction in Kotlin.
