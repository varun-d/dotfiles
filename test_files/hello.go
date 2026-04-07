package main

import (
	"fmt"
)

// Function 1: simple arithmetic
func add(a int, b int) int {
	return a + b
}

// Function 2: string formatting
func greet(name string) string {
	return fmt.Sprintf("Hello, %s!", name)
}

// Function 3: slice processing
func sumSlice(nums []int) int {
	total := 0
	for _, n := range nums {
		total += n
	}
	return total
}

// Function 4: conditional logic
func isEven(n int) bool {
	return n%2 == 0
}

// Function 5: struct usage
type User struct {
	Name string
	Age  int
}

func describeUser(u User) string {
	return fmt.Sprintf("%s is %d years old", u.Name, u.Age)
}

func main() {
	// Test add
	result := add(3, 5)
	fmt.Println("add:", result)

	// Test greet
	message := greet("Varun")
	fmt.Println("greet:", message)

	// Test sumSlice
	nums := []int{1, 2, 3, 4}
	total := sumSlice(nums)
	fmt.Println("sumSlice:", total)

	// Test isEven
	fmt.Println("isEven(4):", isEven(4))
	fmt.Println("isEven(5):", isEven(5))

	// Test describeUser
	user := User{Name: "Alice", Age: 30}
	desc := describeUser(user)
	fmt.Println("describeUser:", desc)
}

