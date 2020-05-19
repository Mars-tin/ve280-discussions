# Lecture 4: C++ Basics

## L-value and R-value

L/R-value refers to memory location which identifies an object. 

* L-value may appear as **either left hand or right hand** side of an assignment operator(=). l-value often represents as identifier.
  * Any non-constant variable is lval.
* R-value may appear as **only right hand** side of an assignment operator(=).
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

Fun Question (Optional):

```c++
int main(){
    vector<int> v = {0, 1, 2, 3, 4};
    auto output_iterator = back_inserter(v);
    *output_iterator = 5;
    cout << *output_iterator << endl;
}
```

What’s the output of this function? Or will this program compile? Is `*output_iterator` a lvalue or rvalue? Why?

## Function Declaration and Definition

Consider the following codes.

```c++
int getArea(int length, int width);

int main()
{
    cout << getArea(2, 5) << endl;
}

int getArea(int length, int width)
{
    return length*width;
}
```

### Function Declaration

Function declaration (prototype) shows how the function is called. It must appear in the code before function can be called.

A Function declaration tells you about:

* Type signature:
  * Return type
  * \# arguments
  * Types of arguments

* Name of the function
* Formal Parameter Names (\*) 

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
{									// -+
    return length*width;			//  |--> Function Body
}									// -+
```



## Function Call Mechanism



## Arrays and Pointer



## References and Pointers



## Structures



## Undefined Behaviors



# Lecture 5: `const` Qualifier



# Credit

SU2019 & SU2020 VE280 Teaching Groups.

VE 280 Lecture 1-3 and EECS 201 Lecture 7

