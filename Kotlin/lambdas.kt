fun main() {
    val numbers: List<Int> = listOf(1, 2, 3, 4, 5)

    // Lambda expression to square each number
    val squaredNumbers: List<Int> = numbers.map { it * it } // { it -> it * it } is a lambda

    println("Squared numbers: $squaredNumbers")

    // Lambda with multiple statements
    val processNumber: (Int) -> String = { number ->
        val doubled = number * 2
        "Number doubled is $doubled"
    }

    println(processNumber(3)) // "Number doubled is 6"
}
