# Sum triangle from array

Given an array of integers, print a sum triangle from it such that the first level has all array elements. From then, at each level number of elements is one less than the previous level and elements at the level is be the Sum of consecutive two elements in the previous level.

```c++
Input : A = {1, 2, 3, 4, 5}
Output : [48]
         [20, 28] 
         [8, 12, 16] 
         [3, 5, 7, 9] 
         [1, 2, 3, 4, 5] 

Explanation :
Here,   [48]
        [20, 28] -->(20 + 28 = 48)
        [8, 12, 16] -->(8 + 12 = 20, 12 + 16 = 28)
        [3, 5, 7, 9] -->(3 + 5 = 8, 5 + 7 = 12, 7 + 9 = 16)
        [1, 2, 3, 4, 5] -->(1 + 2 = 3, 2 + 3 = 5, 3 + 4 = 7, 4 + 5 = 9)
```

Write this function as a recursive function.

Solution:

```c++
void print_triangle(int A[], int n) { 
	// TODO
} 
```

# Generate Binary Strings

Given a integer K. Task is to print all binary string of size K without consecutive 1’s.

Examples:

```c++
Input : K = 3  
Output : 000 001 010 100 101 

Input : K  = 4 
Output : 0000 0001 0010 0100 0101 1000 1001 1010   
```

Write this function as a recursive function. Hint: You may need a helper function.

Solution:

```c++
void generate_strings(int K) { 
    // TODO
} 
```

# Pseudo-perfect Numbers

A number `n` is called *pseudo-perfect* if it is equal to the sum of a subset of its proper divisors. The subset cannot contain duplicate divisors. For example, 12 is pseudo-perfect since it can be written as
2+4+6, where 2, 4, and 6 are three of its proper divisors.

Note: A proper divisor is a positive divisor of a number n, excluding n itself. For example, 1, 2 and 3 are proper divisors of 6, but 6 itself is not.

In this problem, you will write a program that takes an integer as its argument and checks whether it is a pseudo-perfect number. It outputs 1 if the number is and 0 otherwise.

For example, suppose that your program is named as `is_pseudoperfect`. If you run it as
`./is_pseudoperfect 12`
the output should be
`1`

Consider the `list_t` data structure defined in Lecture 7 with the following functions:

```c++
bool list_isEmpty(list_t list);
// EFFECTS: returns true if "list" is empty, false otherwise

list_t list_make();
// EFFECTS: returns an empty list

list_t list_make(int elt, list_t list);
// EFFECTS: given "list", make a new list consisting of
// the new element "elt" followed by the elements
// of the original "list"

int list_first(list_t list);
// REQUIRES: "list" is not empty
// EFFECTS: returns the first element of "list"

list_t list_rest(list_t list);
// REQUIRES: "list" is not empty
// EFFECTS: returns the list containing all but the first
// element of "list"
```

1. Implement `list_proper_divisors`, which takes a positive integer as input and returns a list of its proper divisors in ascending order. You are not required to implement this function recursively.

   ```c++
   list_t list_proper_divisors(int num);
   // REQUIRES: "num" is a positive integer
   // EFFECTS: returns a list_t which contains all the proper
   // divisors of "num" in ascending order
   ```

   Solution:

   ```c++
   list_t list_proper_divisors(int num){
   	// TODO
   }
   ```

2. Before writing the function `is_pseudoperfect`, implement a helper function first. It’s up to you to decide the REQUIRES and EFFECTS of this function. Write this function as a recursive function.

   ```c++
   bool is_pseudoperfect_helper(int num, list_t proper_divisors);
   // REQUIRES: TODO
   // EFFECTS: TODO
   ```

   Solution:

   ```c++
   bool is_pseudoperfect_helper(int num, list_t proper_divisors){
   	// TODO
   }
   ```

3. Please implement the function `is_pseudoperfect` which takes a positive integer as input and returns a Boolean type indicating whether the integer is pseudo-perfect. You may want to use the function `list_proper_divisors` and the helper function implemented above.

   ```c++
   bool is_pseudoperfect(int num);
   // REQUIRES: "num" is a positive integer
   // EFFECTS: returns true if "num" is a pseudoperfect number,
   // false otherwise
   ```

   Solution:

   ```c++
   bool is_pseudoperfect(int num){
   	// TODO
   }
   ```

