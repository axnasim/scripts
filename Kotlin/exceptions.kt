// Set (unordered, no duplicates)
//      val uniqueNumbers: Set<Int> = setOf(1, 2, 2, 3, 4) // Duplicates are removed
//      println("Set: $uniqueNumbers")

// Map (key-value pairs)
//      val ages: Map<String, Int> = mapOf("Alice" to 30, "Bob" to 25)
//      println("Map: $ages")

// Mutable versions
//      val mutableList = mutableListOf<Int>(1, 2, 3)   
//      mutableList.add(4)
//      println("Mutable List: $mutableList")
// }
// Exception Handling in Kotlin
// Exception handling is a mechanism to handle runtime errors gracefully.
// It allows you to catch exceptions and take appropriate actions instead of crashing the program.
// In Kotlin, you can use try-catch blocks to handle exceptions.
// The `try` block contains the code that might throw an exception, and the `catch` block handles the exception.
// You can also use a `finally` block to execute code that should run regardless of whether an exception occurred or not.

fun main() {
    try {
        val number = "abc".toInt() // This will throw a NumberFormatException
        println("Number: $number")
    } catch (e: NumberFormatException) {
        println("Error: Invalid number format")
    } finally {
        println("Finally block executed") // Always executed
    }
}