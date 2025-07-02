fun main() {
    val numbers: List<Int> = listOf(1, 2, 3, 4, 5) // Immutable List
    // numbers.add(6)  // Compilation error: Cannot add to an immutable list

    val doubledNumbers: List<Int> = numbers.map { it * 2 } // Creates a new immutable list

    println("Original numbers: $numbers")
    println("Doubled numbers: $doubledNumbers")
}
