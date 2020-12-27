#include "node.h"
#include <iostream>
using namespace std;
int main() {
    Node A = Node(1,3);
    A.addChild(2);
    A.addChild(3);
    A[0].addChild(4);
    A[0].addChild(5);
    A[0].addChild(6);
    A[0][2].addChild(8);
    A[0][2].addChild(9);
    A[1].addChild(7);

    A.traverse();
    cout << endl;
    cout << A.getHeight() << " " << A[0].getHeight() << " " << A[1].getHeight()
         << " " << A[0][0].getHeight()<< endl;

    Node B = Node(1,3);
    B.addChild(3);
    B[0].addChild(5);
    B[0].addChild(6);
    B.addChild(2);
    B.addChild(4);

    B.traverse();
    cout << endl;

    Node C = Node(2,3);
    C.addChild(4);
    C.addChild(5);
    C.addChild(6);
    C[2].addChild(8);
    C[2].addChild(9);

    cout << A.contain(&C) << endl;
    cout << A.contain(&B) << endl;
    return 0;
}