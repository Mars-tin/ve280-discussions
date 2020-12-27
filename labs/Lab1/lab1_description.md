# VE 280 Lab 1

**Out**: 00:01 am, May 19, 2020;  **Due**: 11:59 pm, May 26, 2020.

## Ex1. Scripting Web Server

Related Topics: *Linux*.

Martin decides to develop his personal website and implement a convenient shell script to automate command line tasks. These tasks include:

- Create: create the working directory of the database and webserver, and initialize the database;
- Dump: dump the data in the database into the webserver;
- List: list all the files stored in the webserver;
- Display: display the data in the webserver;
- Destroy: remove the working directory of database and webserver.

He has already implemented the skeleton of `ex1.sh`, but he forgets to add some basic commands. There are 5 of such lines in the script that are marked as `TODO` comments:

```shell
# TODO: Replace this line with a linux command line.
```

Please help him finish this script by replacing the `TODO`s with a Linux command line you learned from lecture.

1. Create a directory named `sql/`.

2. Copy the file `sql/database.txt` to the directory `webserver/`

3. List all files in directory `webserver/`.

4. Display `webserver/database.txt` in `stdout`.

5. Remove the `webserver/` and `sql/` directories.

### Testing

To test the script, please first [make it executable](<https://askubuntu.com/questions/443789/what-does-chmod-x-filename-do-and-how-do-i-use-it>) by running:

```shell
chmod +x ./ex1.sh
```

Then, you can test the script by running the following commands and observe the results.

```shell
./ex1.sh create
./ex1.sh dump
./ex1.sh list
./ex1.sh display
./ex1.sh destroy
```

## Ex2. Validating Password

Related Topics: *loops*, *arrays*, *boolean*, *ASCII*.

Martin is taking EECS489: Computer Networks, and is asked to develop the back-end of the sign-up page for jAccount. In one of his programs, he has to write a function that checks if the password user submitted to the webserver is valid: 

* Contains at least 1 alphabetic characters;
* Contains at least 1 numerical characters;
* Contains at least 1 non-alphanumeric characters.

The function takes a password (an array of chars) as input, returns true if the password is valid and returns false if not.

```c++
bool isValidPassword(char password[]){
    // TODO: Implement this function.
}
```

You are told that no password contains more than 50 characters. Please help him implement the function.

### Example

Example input:

```shell
marstin-0607
```

Example output:

```shell
1
```

## Ex3. Programming Algebra

Related Topics: *loops*, *array*s, *math*.

Martin is taking VE445: Machine Learning, and is asked to develop a model to recommend courses for a student based on the dataset of students’ ratings of JI courses.

One of his tasks is to write a function that takes a $n\times n$ weight matrix $W$ (a 2D square array of int) and the size of the weight matrix $n$ as input, and returns the trace of the Laplacian of the weight matrix. 

```c++
int traceLaplacian(int weight[][50], int size){
    // TODO: Implement this function.
}
```

The formulas are given as follows.

* The degree matrix $D$ is a diagonal matrix, whose $i^{th}$ diagonal element is the sum of the $i^{th}$ row of the weight matrix $W$:

$$D_{i,i} = \sum_{j=1}^n W_{i,j},\ D_{i,j}=0 \text{ if } i \neq j$$

* The Laplacian $\mathcal{L}$ of the weight matrix $W$:

$$\mathcal{L} = D - W. \text{ That is, } \mathcal{L}_{i,j} = D_{i,j} - W_{i,j}$$

* The trace of the Laplacian $\mathcal{L}$ is the sum of the diagonal of $\mathcal{L}$:

$$tr(\mathcal{L}) = \sum_{i=1}^n \mathcal{L}_{i,i}$$

If an empty weight matrix is passed in ($n=0$), the Laplacian should be empty and its trace should be 0. You don't need to worry about the case where $n>50$ and ignore integer overflow. Please help Martin implement this function.

If you are interested in why we need such a function, you can further read about [Spherical Clustering](https://towardsdatascience.com/spectral-clustering-aba2640c0d5b).

### Example

Example input: 

The first line contains a single int, which is the size $n$ of the matrix.

The following lines encodes the matrix, each row separated by a `\n` and each column separated by space.

```
3
1 2 3
3 2 4
2 1 0
```

* The weight matrix $W$ ($n=3$) is then: 

$$W = \begin{bmatrix}1 & 2 & 3 \\ 3 & 2 & 4 \\ 2 & 1 & 0\end{bmatrix}$$.

* The Degree matrix $D$ is then:

$$D = \begin{bmatrix}1 + 2 + 3 & 0 & 0 \\ 0 & 3 + 2 + 4 & 0 \\ 0 & 0 & 2 + 1 + 0\end{bmatrix} = \begin{bmatrix}6 & 0 & 0 \\ 0 & 9 & 0 \\ 0 & 0 & 3\end{bmatrix}$$.

* The Laplacian $\mathcal{L}$ is then:

$$L = \begin{bmatrix}6 & 0 & 0 \\ 0 & 9 & 0 \\ 0 & 0 & 3\end{bmatrix}  - \begin{bmatrix}1 & 2 & 3 \\ 3 & 2 & 4 \\ 2 & 1 & 0\end{bmatrix} = \begin{bmatrix}5 & -2 & -3 \\ -3 & 7 & -4 \\ -2 & -1 & 3\end{bmatrix}$$.

* The trace is then:

$$tr(\mathcal{L}) = 5+7+3 = 15$$

Example output:

```
15
```

-------

Created by Ziqiao Ma.

Last update: May 17, 2020 

@UM-SJTU Joint Institute