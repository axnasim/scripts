fun main() {
    // declaring variables
    // Declaring variables
    val immutableVariable: String = "This cannot be changed" // val = read-only
    var mutableVariable: Int = 10 // var = can be reassigned
    mutableVariable = 20
    val name: String = "John Doe" // Immutable variable
    var age: Int = 30 // Mutable variable
    val isStudent: Boolean = true // Immutable variable
    var height: Double = 5.9 // Mutable variable
    val hobbies: List<String> = listOf("Reading", "Traveling", "Cooking") // Immutable list 
    var scores: MutableList<Int> = mutableListOf(85, 90, 78) // Mutable list
    val address: Map<String, String> = mapOf("city" to "New York", "country" to "USA") // Immutable map

   
    // Basic Data Types
    val integer: Int = 10        // 32-bit integer
    val longInteger: Long = 10000000000 // 64-bit integer
    val floatNumber: Float = 3.14f  // 32-bit floating-point
    val doubleNumber: Double = 3.14159 // 64-bit floating-point
    val booleanValue: Boolean = true   // true or false
    val character: Char = 'A'      // Single character
    val string: String = "Hello, Kotlin!" // Sequence of characters

    println("Integer: $integer, String: $string, Boolean: $booleanValue")

    // Mutable map
    scores.add(92)
    println("Name: $name")
    println("Age: $age")
    println("Is Student: $isStudent")
    println("Height: $height")
    println("Hobbies: $hobbies")
    println("Scores: $scores")
    println("Address: ${address["city"]}, ${address["country"]}")

    // Changing mutable variables
    age += 1 // Incrementing age
    height += 0.1 // Incrementing height
    println("Updated Age: $age")
    println("Updated Height: $height")

    // Using variables in expressions
    val fullName: String = "$name, Age: $age"
    println("Full Name: $fullName")

    // Using variables in conditions
    if (isStudent) {
        println("$name is a student.")
    } else {
        println("$name is not a student.")
    }

    // Using variables in loops
    for (score in scores) {
        println("Score: $score")
    }   

    // Type inference (Kotlin can often figure out the type)
    val inferredString = "Kotlin is cool"
    var inferredInt = 100
    inferredInt = 200
    println("Inferred String: $inferredString")
    println("Inferred Int: $inferredInt")

    println("Immutable: $immutableVariable, Mutable: $mutableVariable, Inferred String: $inferredString")
}