fun main() {
    // val (immutable - read-only)
    val name: String = "Alice"
    // name = "Bob" // Compilation error: Val cannot be reassigned

    // var (mutable - can be reassigned)
    var age: Int = 30
    age = 31

    // Null Safety
    var nullableString: String? = "Hello"
    nullableString = null

    // Safe call operator (?.) - Access length only if not null
    val length: Int? = nullableString?.length // length will be null if nullableString is null
    println("Length: $length")

    // Elvis operator (?:) - Provide a default value if null
    val nonNullLength: Int = nullableString?.length ?: 0 // nonNullLength will be 0 if nullableString is null
    println("NonNull Length: $nonNullLength")
}
