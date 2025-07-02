
// File: polymorphism/Shape.kt
// This code demonstrates polymorphism in Kotlin using a base class `Shape` and derived classes `Circle` and `Square`.
// Polymorphism allows objects of different classes to be treated as objects of a common superclass.    
// In this example, both `Circle` and `Square` classes override the `area` method from the `Shape` class,
// allowing each shape to calculate its area in its own way. The `main` function creates a list of `Shape` objects,
// and iterates through them to print the area of each shape, demonstrating polymorphism in action
// by calling the overridden `area` method on each shape object.
// This allows for flexible and reusable code, as new shapes can be added without changing the existing
// code that uses the `Shape` class. The `Shape` class serves as a base class, while `Circle` and `Square`
// provide specific implementations of the `area` method, showcasing the power of polymorphism in Kotlin.
// Polymorphism is a key concept in object-oriented programming that allows for flexibility and code reuse  

open class Shape { // Base class
    open fun area(): Double {   // Open method to be overridden
        // Default implementation (if any)
        return 0.0 // Default area for a generic shape
    }
}
// Derived classes  
class Circle(val radius: Double) : Shape() { // Inherits from Shape
    override fun area(): Double { // Override the area method for Circle
        // Calculate area of the circle
        return Math.PI * radius * radius
    }
}

class Square(val side: Double) : Shape() { // Inherits from Shape
    override fun area(): Double { // Override the area method for Square
        // Calculate area of the square
        return side * side
    }
}

// Main function to demonstrate polymorphism
// This function creates a list of shapes and calculates their areas using polymorphism 
// Each shape object calls its own overridden area method, demonstrating polymorphism
// The main function serves as the entry point for the program, where polymorphism is showcased

fun main() {
    val shapes: List<Shape> = listOf(Circle(5.0), Square(4.0)) // List of Shape objects

    for (shape in shapes) { // Iterate through each shape
        // Call the area method on each shape
        println("Area: ${shape.area()}") // Each shape calculates its area appropriately
    }
}
