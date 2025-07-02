import kotlinx.coroutines.*
// coroutines and asynchronous programming
// Coroutines are a way to write asynchronous code in a sequential manner.
// They allow you to write non-blocking code that can pause and resume execution.
// Coroutines are lightweight threads that can be suspended and resumed.
// They are used for tasks like network requests, file I/O, and other long-running operations.
// To use coroutines, you need to add the kotlinx-coroutines-core dependency to your project.
// In Gradle, add the following dependency:
// implementation "org.jetbrains.kotlinx:kotlinx-coroutines-core:1.6.0"
// In Maven, add the following dependency:
// <dependency>
//     <groupId>org.jetbrains.kotlinx</groupId>
//     <artifactId>kotlinx-coroutines-core</artifactId>
//     <version>1.6.0</version>
// </dependency>
// The main function is the entry point of a Kotlin program.
// In Kotlin, the main function is defined as follows:
// fun main() {
//     // Your code here
// }

// The runBlocking function is used to start a coroutine that blocks the current thread until it completes.
// It is typically used in main functions or tests to bridge the gap between blocking and non-blocking code.
// The GlobalScope is a global coroutine scope that is used to launch coroutines that are not tied to any specific lifecycle.
// It is generally not recommended to use GlobalScope in production code, as it can lead to memory leaks and unhandled exceptions.
// The launch function is used to start a new coroutine.
// It returns a Job object that represents the coroutine and can be used to manage its lifecycle.
// The delay function is used to suspend the coroutine for a specified time without blocking the thread.
// The join function is used to wait for the coroutine to finish.



fun main() = runBlocking { // Use runBlocking for simple examples
    println("Starting coroutine")

    val job = GlobalScope.launch { // Launches a new coroutine
        delay(1000L) // Suspend the coroutine for 1 second (non-blocking)
        println("World!")
    }

    println("Hello,")
    job.join() // Wait for the coroutine to finish
    println("Coroutine finished")
}
