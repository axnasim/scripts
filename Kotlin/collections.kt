fun main() {
    // Collections in Kotlin
    // Collections are used to store multiple items in a single variable.
    // Kotlin provides several types of collections, including List, Set, and Map.
    // Collections can be mutable (can change) or immutable (cannot change).
    // Immutable collections are created using `listOf`, `setOf`, and `mapOf`.
    // Mutable collections are created using `mutableListOf`, `mutableSetOf`, and `mutableMapOf`.
    // Immutable collections cannot be modified after creation, while mutable collections can be changed.
    // Immutable collections are preferred for functional programming and thread safety.
    // Mutable collections are useful when you need to modify the collection after creation.

    // List (ordered, allows duplicates)
    val numbers: List<Int> = listOf(1, 2, 2, 3, 4)
    println("List: $numbers")

    // Set (unordered, no duplicates)
    val uniqueNumbers: Set<Int> = setOf(1, 2, 2, 3, 4) // Duplicates are removed
    println("Set: $uniqueNumbers")

    // Map (key-value pairs)
    val ages: Map<String, Int> = mapOf("Alice" to 30, "Bob" to 25)
    println("Map: $ages")

    // Mutable versions
    val mutableList = mutableListOf<Int>(1, 2, 3)
    mutableList.add(4)
    println("Mutable List: $mutableList")
}
