// Encapsulation in Kotlin
// Encapsulation is a fundamental principle of object-oriented programming that restricts direct access to an object's data and methods.
// It allows you to hide the internal state of an object and expose only what is necessary.
// In Kotlin, encapsulation is achieved using visibility modifiers such as `private`, `protected`, and `public`.

fun main() {
    // Class with encapsulation
    class Person(private var name: String, private var age: Int) { // Properties are private
        // Public method to access private properties
        fun getInfo(): String {
            return "Name: $name, Age: $age"
        }

        // Public method to change the name
        fun setName(newName: String) {
            name = newName
        }
    }

    // Create an instance of the Person class
    val person = Person("Alice", 30)
    println(person.getInfo()) // Accessing private properties through public method
    person.setName("Bob") // Changing the name using public method
    println(person.getInfo()) // Accessing updated information

    // Attempting to access private properties directly will result in a compilation error
    // println(person.name) // Error: Cannot access 'name': it is private in 'Person'
    // println(person.age) // Error: Cannot access 'age': it is private in '
    // person'
}

// Encapsulation helps in maintaining the integrity of the object's state and provides a clear interface for interaction.
// It allows you to change the internal implementation without affecting the code that uses the class, promoting code maintainability and flexibility.  
// In Kotlin, the default visibility modifier is `public`, which means the class and its members are accessible from anywhere.
// You can also use `internal` to restrict visibility to the same module, and `protected` to allow access only within the class and its subclasses. 
// The `private` modifier restricts access to the class itself, preventing external code from accessing its members.
// Encapsulation is a key concept in Kotlin that helps you design robust and maintainable code by controlling access to the internal state of your classes.
// It allows you to define a clear interface for your classes while keeping the implementation details hidden,
// ensuring that the internal state can only be modified through well-defined methods.
