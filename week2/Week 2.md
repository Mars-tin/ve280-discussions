#  Lecture 4: C++ Basics

## Value Category

### Naïve Value Categories 

L/R-value refers to memory location which identifies an object. A simplified definition for beginners are as follows.

* L-value may appear as **either left hand or right hand** side of an assignment operator(=). 
  * In memory point of view, an l-value, also called a *locator value*, represents an object that occupies some identifiable location in memory (i.e. has an address).
  * Any non-constant variable is lval.
* R-value may appear as **only right hand** side of an assignment operator(=).
  * Exclusively defined against L-values.
  * Any constant is an rval.

Consider the following code.

```c++
int main(){
    int arr[5] = {0, 1, 2, 3, 4};
    int *ptr1 = &arr[0];
    int *ptr2 = &(arr[0]+arr[1]);
    cout << ptr1 << endl;
    cout << ptr2 << endl;
    arr[0] = 5;
    arr[0] + arr[1] = 5;
}
```

The compiler will raise errors.

```shell
...\main.cpp:7:32: error: lvalue required as unary '&' operand
     int *ptr2 = &(arr[0]+arr[1]);
                                ^
...\main.cpp:11:21: error: lvalue required as left operand of assignment
     arr[0] + arr[1] = 5;
```

### Deep Dive into Value Categories (*Optional*):

Consider the following code.

```c++
int main(){
    vector<int> v = {0, 1, 2, 3, 4};
    auto output_iterator = back_inserter(v);
    *output_iterator = 5;
    cout << *output_iterator << endl;
}
```

* What’s the output of this function? Or will this program compile? 

* Is `*output_iterator` an l-value or r-value? Why?

Read [L-values and R-values](<https://docs.microsoft.com/en-us/cpp/cpp/lvalues-and-rvalues-visual-cpp?view=vs-2019>) and take EECS 483, Compiler Structure, if interested.

![C++ expression value categories](https://docs.microsoft.com/en-us/cpp/cpp/media/value_categories.png?view=vs-2019)

## Function Declaration and Definition

Consider the following codes.

```c++
// Function Declaration
int getArea(int length, int width);

int main()
{
    cout << getArea(2, 5) << endl;
}

// Function Definition
int getArea(int length, int width)
{
    return length*width;
}
```

### Function Declaration

Function declaration (prototype) shows how the function is called. It must appear in the code before function can be called.

A Function declaration `int getArea(int length, int width);` tells you about:

* Type signature:
  * Return type: `int`;
  * \# arguments: 2;
  * Types of arguments: `int`*2;

* Name of the function: `getArea`;
* Formal Parameter Names (\*): `length` and `width`.

However, formal parameter names are not necessary. Try to replace:

```c++
int getArea(int length, int width);
```

with:

```c++
int getArea(int l, int w);
```

or even:

```c++
int getArea(int, int);
```

The program still works. Yet, it is considered good coding style to keep the formal parameter names, so that your potential collaborators can understand what the function is for.

### Function Definition

Function definition describes how a function performs its tasks. It can appear in the code before or after function can be called.

```c++
int getArea(int length, int width)	// ----> Function Header
{                           // -+
    return length*width;    //  |--> Function Body
}                           // -+
```

## Argument Passing Mechanism

Consider the following example.

```c++
void pass_by_val(int x){
    x = 2;
}

void pass_by_ref(int &x){
    x = 2;
}

void mixed(int x, int &y){
    x = 3;
    y = 3;
}

int main(){
    int y = 1;
    int z = 2;
    pass_by_val(y);
    pass_by_ref(z);
    cout << y << " " << z << endl;
    mixed(y, z);
    cout << y << " " << z << endl;
}
```

The output of the above code is

```
1 2
1 3
```

This example demonstrates the 2 argument passing mechanism in C++: 

* Pass by Value;
* Pass by Reference.

The difference of above mechanisms can be interpreted from the following aspects:

* Language point of view: reference parameter allows the function to change the input parameter.
* Memory point of view: 
  * Pass-by-reference introduce an extra layer of indirect access to the original memory object. In fact, many compilers implement references with pointers.
  * Pass-by-value needs to copy the argument.
  * Can both expensive, in terms of memory and time. 

Choosing argument passing methods wisely:

* Pass atomic types by value (`int`, `float`, `char*`...).
  * `char` is 1B, `int32` is 2B, `int64` is 4B, and a pointer is 8B (x64 System).
* Pass large compound objects by reference (`struct`, `class`...).
  * For `std` containers, passing by value costs 3 pointers, but passing by reference costs only 1;
  * What about structures/classes you created?

## Arrays and Pointer

Your familiarity of arrays and pointers is assumed in this course. Test yourself with the following examples.

### Pointers

What is the output of the following example?

```c++
int main(){
    int x = 1;
    int y = 2;
    int *p = &x;
    *p = ++y;
    p = &y;
    y = x++;
    cout << x << " " << y << " " << *p << endl;
}
```

### Arrays

What is the output of the following example?

```c++
void increment(int arr[], int size){
    for (int i = 0; i < size; ++i){
        (*(arr + i))++; // correct
        //*(arr + i)++; // wrong
    }
}

int main(){
    int arr[5] = {0, 1, 2, 3, 4};
    increment(arr, 5);
    for (int i = 0; i < 5; ++i){
        cout << *(arr + i);
    }
    cout << endl;
}
```

Two important things to keep in mind here:

* Arrays are naturally passed by reference;
* Conversion formula between arrays and pointers: `*(arr + i) = arr[i]`

## References and Pointers

L-vals always corresponds to a fixed memory region. This gives rises to a special construct called references. 

Your familiarity of **non-constant references** is assumed in this course. Test yourself with the following example. What is the output?

```c++
int main(){
    int a = 1;
    int b = 5;
    int *p1 = &a;
    int *p2 = &b;
    int &x = a;
    int &y = b;
    p2 = &a;
    x = b;
    a++;
    b--;
    cout << x << " " << y << " " << *p1 << " " << *p2 << endl;
}
```

Try resist the temptation to think reference as an alias of variables, but remember they are alias for the memory region. References must be bind to a memory region when created: there is no way to re-bind of an existing reference.

## Structures

Your familiarity of structures is assumed in this course. 

```c++
struct Student{
    // represents a JI student.
    string name;
    string major;
    long long stud_id;
    bool graduated;
};

int main(){
    // Initialize a structrue
    struct Student s = {"martin", "undeclared", 517370910114, false};
    struct Student *ptr = &s;
    
    // Use . and -> notation to access and update
    cout << s.name << " " << ptr->stud_id << endl;
    s.major = "ece";
    ptr->graduated = true;    
}
```

Two facts to take away here:

* `struct` is in fact totally the same as `class`, instead the default is `public`.
* To save memory, place larger attributes first. You will understand and get used to this when you take VE/EECS 281 and VE/EECS 370.

## Undefined Behaviors

**Undefined behaviors (UB)** are program whose output depends on a specific platform, or a specific implementation of the compiler. Therefore, the outcome/answer of a process may be YES, NO...or UB.

Why UBs are still there throughout the years? It's not that the committee doesn't know how to eliminate them, but they leave room for compiler optimizations.

For a programmer, keep in mind that:

* It's an absolute waste of time trying to figure out what will happen given an code that contains UB.
* It's dangerous and to write code that contains UB, and it is your job to avoid them.

Any (zero or more) of the following may happen if you trigger any of UBs:

* Compiler refuse to compile;

* Compiler compiles but warns (Again, warnings are bugs);
* The compiler compiles silently, but...
  * Program crashes when executed;
  * Your program works out, but the output is wrong;
  * The compiler deletes your files in the systems;
  * Your program works perfectly on your computer but gets rejected by the JOJ.

Common examples of UBs:

- Integer overflow:

  ```c++
  int x = INT_MAX; 
  x++; // UB
  ```

  Many compilers would work out `x = -2147483648`, but that is not guaranteed.

- Dereferencing `nullptr`:

  ```c++
  int* x = nullptr; 
  *x = 1; // UB
  ```

  Most compilers compile it, but the program crashes. Yet, it is not guaranteed that the program crashes.

- Array out-of-bound:

  For most platforms, the following works perfectly, but is bad and not guaranteed to.

  ```c++
  int main(){
      int x[5] = {0};
      x[5] = 1; // UB
      cout << x[5] << endl;
  }
  ```

  Merely taking the address is UB.

  ```c++
  int main(){
      int x[5] = {0};
      int *p = &(x[5]); // UB
      *p = 1;
      cout << *p << endl;
  }
  ```

- Dangling references

   You could still get correct value, or not.

  ```c++
  int main(){
      auto x = new int[10];
      x[3] = 1;
      delete[] x;
      cout << x[3];
  }
  ```

# Lecture 5: `const` Qualifier

...我也忘完了。

# Credit

SU2019 & SU2020 VE280 Teaching Groups.

VE 280 Lecture 1-3 and EECS 201 Lecture 7

