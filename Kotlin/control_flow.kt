fun main() {
    val number = 15

    // If/else
    if (number > 10) {
        println("Number is greater than 10")
    } else if (number > 5) {
        println("Number is greater than 5")
    } else {
        println("Number is 5 or less")
    }

    // When (like a switch statement, but more powerful)
    when (number) {
        1 -> println("Number is 1")
        in 2..10 -> println("Number is between 2 and 10")
        15 -> println("Number is 15")
        else -> println("Number is something else")
    }

    // when (more powerful than switch)
    val day = 3
    val dayOfWeek = when (day) {
        1 -> "Monday"
        2 -> "Tuesday"
        3 -> "Wednesday"
        4 -> "Thursday"
        5 -> "Friday"
        6 -> "Saturday"
        7 -> "Sunday"
        else -> "Invalid day"
    }
    println("Day of the week: $dayOfWeek")

     // for loop
    val numbers = listOf(1, 2, 3, 4, 5)
    for (number in numbers) {
        println("Number: $number")
    }

    // for loop with index
    for (i in numbers.indices) {
        println("Index: $i, Value: ${numbers[i]}")
    }

    // while loop
    var counter = 0
    while (counter < 5) {
        println("Counter: $counter")
        counter++
    }
}
