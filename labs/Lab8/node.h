//
// Created by zzebilly on 02/07/2020.
//

#ifndef LAB8_NODE_H
#define LAB8_NODE_H

class tooManyChildren{};
class invalidIndex{};
class Node {
    // OVERVIEW: a node in the n-Ary tree, can also represent a n-ary tree rooted at 'this'
private:
    int value;      // the integer value of this
    int child_num;  // the number of child of this
    int n;          // n for this n-Ary tree
    Node *parent;   // parent node of this, for root node, parent = NULL
    Node **children;
    // children is an array of pointer to Node. Therefore, children is a pointer of pointer
    int height;     // height of this node

    void addChild(Node *child);
    // REQUIRES: n of the child node is the same with n of this
    // EFFECTS: add the node child to the children array
    //          throw an exception tooManyChildren when child_num exceed n

public:
    Node(int _value, int _n = 2);
    // EFFECTS: create a root node with value and n

    ~Node();
    // EFFECTS: destroy the whole tree rooted at sub

    void addChild(int _value);
    // EFFECTS: create a child node with value and add it to the children array
    //			throw an exception tooManyChildren when child_num exceed n

    void traverse();
    // EFFECTS: print the value of the nodes using a pre-order traversal,
    //          separated by a space.
    //          A pre-order traversal print the value of the node
    //          and then traverse its child nodes
    //          according to the sequence in children array.
    //          For example, the output of the tree above is
    //          1 2 4 5 6 8 9 3 7
    //          And the output of the tree below is
    //          1 3 5 6 2 4

    bool contain(Node *sub);
    // EFFECTS: return whether the tree rooted at sub is a subtree of this

    int getHeight();
    // EFFECTS: return height of this

    Node &operator[](int i);
    // EFFECTS: return a reference of (i+1) th child node of this,
    //          e.g. node1[0] returns a reference of the first child node of node1
    //          if i is invalid, throw an invalidIndex
};


#endif //LAB8_NODE_H
