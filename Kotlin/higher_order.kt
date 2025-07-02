fun operate(x: Int, y: Int, operation: (Int, Int) -> Int): Int {
    return operation(x, y)
}

fun main() {
    val sumResult = operate(10, 5) { a, b -> a + b }
    println("Sum result: $sumResult")

    fun multiply(a: Int, b: Int): Int = a * b // Regular function
    val productResult = operate(10, 5, ::multiply) // Function reference
    println("Product result: $productResult")
}
