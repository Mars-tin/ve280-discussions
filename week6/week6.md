# Lecture 17: Dynamic Memory Allocation

## Memory Management

Each running program has its own memory layout, separated from other programs. The layout consists of a lot of segments, including:

- `stack`: stores local variables
- `heap`: dynamic memory for programmer to allocate
- `data`: stores global variables, separated into initialized and uninitialized
- `text`: stores the code being executed

In order to pinpoint each memory location in a program’s memory, we assign each byte of memory an “address”. The addresses go from 0 all the way to the largest possible address, depending on the machine. As the figure below, the `text`, `data`, and `stack` segments have low address numbers, while the `stack` memory has higher addresses.

![img](https://courses.engr.illinois.edu/cs225/sp2020/assets/notes/stack_heap_memory/memory_layout.png)

## `new` & `delete`

Mostly, a fixed-sized structure is undesired. Yet, VLA is forbidden in c++.

```c++
int num = 100;
int array[num]; // Error
```

This leads to:

```bash
warning: ISO C++ forbids variable length array 'array' [-Wvla]
```

In ISO c++ standard, it's not allowed to have variable length array. Although G++ allows this as an "extension" (because C allows it), if you add `-pedantic` to the compiling option, it will have warning.

`man g++`:

```bash
-Wpedantic
	-pedantic
  	Issue all the warnings demanded by strict ISO C and ISO C++; reject
    all programs that use forbidden extensions, and some other programs
		that do not follow ISO C and ISO C++.
```

It's not allowed to use variable length array in c++, especially if you want your code to be as portable as possible. This is where we need dynamic length array.

```c++
int num = 100;
int *array = new intnum;
delete [] array;
```

`new` and `new[]` does the following:

- Allocates space in heap (for one or a number of objects).
- Constructs object in-place (including, but not limited to ctor).
- Returns the “first” address.

The syntax for new operator are very simple.

```c++
Type* obj0 = new Type; // Default construction
Type* obj1 = new Type(); // Default construction
Type* obj2 = new Type(arg1, arg2);
Type* objA0 = new Type[size]; // Default cons each elt
Type* objA1 = new Type[size](); // Same as obj A0
```

Since `new` allocates memory from the heap, they essentially requested (and occupies) resources from the system. For long running programs resources must always be returned (or released) when the program is finished with them, otherwise the program will end up draining all system resources, in our case running out of memory.

`delete` and `delete[]` releases the objects allocated from `new` and `new[]` respectively. They does the following:

- Destroy the object (each object in the array) being released (by calling the destructor of the object).
- Returns the memory to the system. 

We must emphasize that deletion is not idempotent, i.e. `delete` an object more than once, or delete an array allocated using `new[]` by `delete` instead of `delete[]` cause UB! 

### Destructor

The destructors for any ADTs declared locally within a block of code are called automatically when the block ends.

```c++
{
	IntSet ip = IntSet(50);
	...		
} // ip will be destroyed by calling its destructor
```

Destructor of ADT will also be called when using `delete`. A effective destructors should:

- Be named as `~ClassName`
- Takes no argument and returns nothing (not even void)
- If one expect the class to be inherited the destructor should be declared as `virtual`
- Release resource allocated only in this class, do not release base class resources!!!

Consider that in lab8:

```c++
Node::~Node() {
  	// EFFECTS: destroy the whole tree rooted at sub
    // MODIFIES: this
    for(int i = 0; i < this->child_num; i++) { delete(children[i]); }
    delete[] children;
}
```

## Memory Leaks

If an object is allocated, but not released after the program is done with it, the system would assume the resource is still being used (since it won’t examine the program), but the program will never use it. Thus resource is “leaked”, i.e. no longer available for using. In our case the leaked resource is memory.

`valgrind` is not a tool that only looks for memory leaks. It actually looks for for all sorts of memory related problems, including:

- Memory Leaks
- Invalid accesses
  - Array out-of-range
  - Use of freed memory
- Double free problems

Consider the following examples. Which implementation if free of leakage and why?

1. Memory Leaks.

```c++
class Base {
protected:
	int *p;
public:
	Base() : p(new int(10)) {}
	~Base() {delete p;}
};

class Derived : public Base {
	int *q;
public:
	Derived() : Base(), q(new int(20)) {}
	~Derived() {delete q;}
};

/* A */
void main() {
	Base* ptrA = new Derived;
	delete ptrA;
}

/* B */
void main() {
	Derived* ptrB = new Derived;
	delete ptrB;
}
```

1. Double Deletion.

```c++
class Base {
protected:
    int *p;
public:
    Base() : p(new int(10)) {}
    virtual ~Base() {delete p;}
};

class Derived : public Base {
    int *q;
public:
    Derived() : Base(), q(new int(20)) {}
    virtual ~Derived() override {delete p; delete q;}
};

/* A */
void main() {
	Base* ptrA = new Derived;
	delete ptrA;
}

/* B */
void main() {
	Derived* ptrB = new Derived;
	delete ptrB;
}
```

How to correct the codes?

```c++
class Base {
protected:
    int *p;
public:
    Base() : p(new int(10)) {}
    virtual ~Base() {delete p;}
};

class Derived : public Base {
    int *q;
public:
    Derived() : Base(), q(new int(20)) {}
    virtual ~Derived() override {delete q;}
};
```



# Lecture 18: Deep Copy

## Shallow Copy & Deep Copy

Because C++ does not know much about your class, the default copy constructor and default assignment operators it provides use a copying method known as a member-wise copy, also known as a *shallow copy*.

![Shallow](https://media.geeksforgeeks.org/wp-content/uploads/shallow-copy.jpg)

This works well if the fields are values, but may not be what you want for fields that point to dynamically allocated memory. The pointer will be copied. but the memory it points to will not be copied: the field in both the original object and the copy will then point to the same dynamically allocated memory, this causes problem at erasure, causing **dangling pointers**.

Instead, a *deep copy* copies all fields, and makes copies of dynamically allocated memory pointed to by the fields.



![Deep](https://media.geeksforgeeks.org/wp-content/uploads/deep-copy.jpg)

### The Rule of the Big 3/5

If you have any dynamically allocated storage in a class, you must follow this Rule of the Big X, where X = 3 traditionally and X = 5 after c++11.

> Whenever an object owns resources, any resources, not just memory, it should implement 5 methods: A ctor and a dtor, A copy ctor, a move ctor, a copy assignment operator, and a move assignment operator.

These are 5 typical situations where resource management and ownership is critical. You should never leave them unsaid whenever dynamic allocation is involved. Traditionally **constructor/destructor/copy assignment operator** forms a rule of 3. Move semantics is a feature available after C++11, which is not in the scope of this course. Learn more about them in EECS 381.

If you want to use the version synthesized by the compiler, you can use `= default`:

```c++
Type(const Type& type) = default;
Type& operator=(Type&& type) = default;
```

Usually, we would need to implement some private helper functions `removeAll()` and `copyFrom()`, and use them in the big 3. Consider the `Dlist` example.

- A destructor

```c++
template <class T>
Dlist<T>::~Dlist() {
    removeAll();
}
```

- A copy constructor

```c++
template <class T> 
Dlist<T>::Dlist(const Dlist &l): first(nullptr), last(nullptr) {
  copyAll(l); 
}
```

- An assignment operator

```c++
template <class T>
Dlist<T> &Dlist<T>::operator=(const Dlist &l) {
    if (this != &l) {
        removeAll();
        copyAll(l);
    }
    return *this;
}
```

### Example

Recall binary tree and in-order traversal. We define that a good tree is a binary tree with ascending in-order traversal. How to deep copy a template good tree provided interface:

```c++
template <class T> 
class GoodTree { 
		T *op; 
		GoodTree *left; 
		GoodTree *right; 
public:
  	void removeAll(); 
  	// EFFECTS: remove all things of "this" 
  	void insert(T *op); 
  	// REQUIRES: T type has a linear order "<" 
  	// EFFECTS: insert op into "this" with the correct location
  	//					Assume no duplicate op.
};
```

You may use `removeAll` and `insert` in your `copyAll` method.

------

The sample answer is as follows.

```c++
template <class T> 
void GoodTree<T>::copy_helper(const GoodTree<T> *t) { 
  	if (t == nullptr) 
      	return; 
  	T *tmp = new(t->op); 
  	insert(tmp); 
  	copy_helper(t->left); 
  	copy_helper(t->right); 
}

template <class T> 
void GoodTree<T>::copyAll(const GoodTree<T> &t) {
		removeAll();
  	copy_helper(&t); 
}
```

### ~~Exception Safety~~

~~Skipped. See [Lessons Learned from Specifying Exception-Safety for the C++ Standard Library](<https://www.boost.org/community/exception_safety.html>).~~



