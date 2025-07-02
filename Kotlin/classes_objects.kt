fun main() {
    // Class
    open class Animal(val name: String) { // Open allows inheritance
        open fun makeSound() {
            println("Generic animal sound")
        }
    }

    // Inheritance
    class Dog(name: String) : Animal(name) { // Inherits from Animal
        override fun makeSound() { // Override the method
            println("Woof!")
        }
    }

    // Polymorphism
    val animal: Animal = Dog("Buddy")
    animal.makeSound() // Prints "Woof!"

    // Data class (automatically generates equals(), hashCode(), toString(), copy())
    data class Point(val x: Int, val y: Int)

    val point1 = Point(10, 20)
    val point2 = Point(10, 20)
    println(point1 == point2) // true (because it's a data class)
}
