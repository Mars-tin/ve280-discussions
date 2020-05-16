// main.cpp
#include <iostream>
#include "add.h"
#include "minus.h"

int main(){
	int a = add(2, 3);
	int b = minus(3, 2);
	std::cout << a << ", " << b << std::endl;
	return 0;
}
