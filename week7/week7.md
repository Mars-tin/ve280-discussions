# Lecture 19: Dynamic Resizing

In many applications, we do not know the length of a list in advance, and may need to grow the size of it when running the program. In this kind of situation, we may need dynamic resizing. 

## Array

If the implementation of the list is a dynamically allocated array, we need the following steps to grow it:

- Make a new array with desired size. For example, 

  ```c++
  int *tmp = new int[new_size];
  ```

- Copy the elements from the original array to the new array iteratively. Suppose the original array is `arr` with size `size`.

  ```c++
  for (int i = 0; i < size; i++){
      tmp[i] = arr[i];
  }
  ```

- Replace the variable with the new array and delete the original array. Suppose the original array is `arr`:

  ```c++
  delete [] arr;
  arr = tmp;
  ```

- Make sure all necessary parameters are updated. For example, if the `size` of array is maintained, then we can do:

  ```cpp
  size = new_size;
  ```

Common selections of `new_size` can be:

- `size + 1`: This approach is simplest but most inefficient. Inserting `N` elements from capacity 1 needs `N(N-1)/2` number of copies.
- `2*size`: Much more efficient than `size+1`. The number of copies for inserting `N` elements becomes smaller than `2N`.
- What about even larger (eg: `size^2`)? Usually not good, for it occupies far too much memory.

Learn more about amortized complexity in VE281/EECS281.

## Linked lists

To enlarge a list implemented by linked list, you can simply add a node at the end of the linked list. 

The good thing about this is that no copy is required. Details in later discussions.



# Lecture 20: Linked List

Recall what you have implemented in lab 9-10 & project 5.

## Single-Ended & Doubly-Ended

Linked lists could be either single ended or doubly linked, depending on the the number of node pointers in the container.

In a singly ended list, we only need a `first`.

```c++
class IntList {
    node *first;
    //...
};
```

In a doubly ended list, we need also a `last`.

```c++
class IntList {
    node *first;
    node *last;
    //...
};
```

Especially, when handling a singly ended list, you need to be concerned about the special situation where

- size = 0: `first` is `nullptr`
- size = 1: `first` is the last and only node in the list. 

In a doubly ended list, the `last` makes it slightly more complicated:

- size = 0: `first` and `last` is `nullptr`
- size = 1: `first` is connecting to `last`. 

## Singly-Linked & Doubly-Linked

Linked lists could be either single linked or doubly linked, depending on the the number of directional pointers in `node`.

In a singly linked list, we only need a `next`.

```c++
struct node {
	node *next;
	int value;
};
```

![Singly-linked-list.svg](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Singly-linked-list.svg/408px-Singly-linked-list.svg.png)

In a doubly linked list, we need also a `prev`.

```c++
struct node {
	node *next;
	node *prev;
	int value;
};
```

![Doubly-linked-list.svg](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Doubly-linked-list.svg/610px-Doubly-linked-list.svg.png)



## Linked List Methods

### Insertion

Insertion at ends:

![img](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Linked%20Lists/pix/prepend.bmp)

Insertion after:

![img](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Linked%20Lists/pix/after.bmp)

Insertion before:

![img](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Linked%20Lists/pix/before.bmp)



### Deletion

![img](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Linked%20Lists/pix/delete.bmp)