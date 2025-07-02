fun main() {
    fun add(a: Int, b: Int): Int { // Function with parameters and return type
        return a + b
    }

    // Function with parameters and return type
    val sum = add(5, 3)
    println("Sum: $sum")
    println("Sum: ${add(5, 3)}")

    // Single-expression function
    fun multiply(a: Int, b: Int): Int = a * b // Shorthand for simple functions
    println("Product: ${multiply(4, 2)}")

   // Higher-order function (takes a function as an argument)
    fun operate(x: Int, y: Int, operation: (Int, Int) -> Int): Int {
        return operation(x, y)
    }

    // Lambda expression (anonymous function)
    val sum = operate(10, 5) { a, b -> a + b } // Lambda as argument
    println("Lambda Sum: $sum")

    val product = operate(10, 5, ::multiply)  // Function reference as argument
    println("Reference Product: $product")
   
    // Function with default parameters
    fun greet(name: String, greeting: String = "Hello"): String {
        return "$greeting, $name!"
    }
    println(greet("Alice")) // Uses default greeting
    println(greet("Bob", "Hi")) // Uses custom greeting
}
