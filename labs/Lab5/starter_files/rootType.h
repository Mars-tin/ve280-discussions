//
// Created by Zhuoer Zhu on 10/06/2020.
//

#ifndef LAB5_ROOTTYPE_H
#define LAB5_ROOTTYPE_H
typedef struct complexNum_t{
    // Used to represent a complex number = real + i*imaginary
    float real;
    float imaginary;
}complexNum;

typedef struct root_t{
    // Used to describe the root of a quadratic function
    // realRootNum: the number of the real roots
    // roots: an array of the two roots of the quadratic function,
    //        please follow the sequence in the description
    unsigned int realRootNum;
    complexNum roots[2];
}root;
#endif //LAB5_ROOTTYPE_H
