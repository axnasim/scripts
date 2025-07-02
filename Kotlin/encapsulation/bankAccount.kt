class BankAccount(private val accountNumber: String, private var balance: Double) { // Class representing a bank account with private properties

    fun deposit(amount: Double) {
        // Method to deposit money into the account, checks if the amount is positive
        if (amount > 0) {
            balance += amount // Increases the balance by the deposit amount
            println("Deposited $amount. New balance: $balance") // Prints the deposit success message and new balance
        } else {
            println("Invalid deposit amount.") // Prints a message if the deposit amount is invalid
        }
    }

    fun withdraw(amount: Double) {
        // Method to withdraw money from the account, checks if the amount is positive and sufficient
        if (amount > 0 && amount <= balance) {
            balance -= amount // Decreases the balance by the withdrawal amount
            println("Withdrawn $amount. New balance: $balance") // Prints the withdrawal success message and new balance
        } else {
            println("Insufficient funds or invalid amount.") // Prints a message if the withdrawal amount is invalid or exceeds balance
        }
    }

    fun getBalance(): Double { // Public method to access the current balance
        return balance // Returns the current balance
    }
}

fun main() {
    val account = BankAccount("1234567890", 1000.0) // Creating a new BankAccount object with an initial balance
    // account.balance = -500.0 // Error: balance is private, demonstrates encapsulation
    account.deposit(500.0) // Deposits 500.0 into the account
    account.withdraw(200.0) // Withdraws 200.0 from the account
    println("Current balance: ${account.getBalance()}") // Prints the current balance using the getter method
}
