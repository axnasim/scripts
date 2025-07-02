fun main() {
    // Interface
    interface Clickable {
        fun click()
        fun showClickedMessage() { // Default implementation (optional)
            println("I was clicked!")
        }
    }

    // Implementation
    class Button : Clickable {
        override fun click() {
            println("Button clicked!")
        }
    }

    val button = Button()
    button.click()
    button.showClickedMessage()

    // Abstract Class
    abstract class Shape {
        abstract fun area(): Double // Abstract method (no implementation)
        fun display() {
            println("This is a shape")
        }
    }

    // Implementation
    class Circle(val radius: Double) : Shape() {
        override fun area(): Double {
            return Math.PI * radius * radius
        }
    }

    val circle = Circle(5.0)
    circle.display()
    println("Circle area: ${circle.area()}")
}
