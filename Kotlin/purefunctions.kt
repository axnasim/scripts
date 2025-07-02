fun add(a: Int, b: Int): Int { // Pure function
    return a + b // Only depends on the input parameters, no external state
}

fun main() {
    val result1 = add(5, 3) // Always returns 8
    val result2 = add(5, 3) // Always returns 8

    println("Result 1: $result1, Result 2: $result2")
}
