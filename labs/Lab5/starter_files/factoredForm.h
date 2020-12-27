//
// Created by Zhuoer Zhu on 10/06/2020.
//

#ifndef LAB5_FACTOREDFORM_H
#define LAB5_FACTOREDFORM_H

#include "rootType.h"
#include <cmath>
class quadraticFunction {
    // OVERVIEW: the factored form of a quadratic function f(x) = ax^2 + bx + c
    float a;
    complexNum r1;
    complexNum r2;

public:
    quadraticFunction(float a_in, float b_in, float c_in);
    // REQUIRES: a_in is not 0
    // EFFECTS: creates a quadratic function in factored form

    float getA()const;
    // EFFECTS: returns the value of a

    float getB()const;
    // EFFECTS: returns the value of b

    float getC()const;
    // EFFECTS: returns the value of c

    float evaluate(float x);
    // EFFECTS: returns the value of f(x)

    root getRoot();
    // EFFECTS: returns the roots of the quadratic function

    int intersect(quadraticFunction g);
    // EFFECTS: returns whether g and this intersect
    // if true, return 1
    // if false, return 0
};


#endif //LAB5_FACTOREDFORM_H
