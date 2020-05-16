all: main

main: main.o add.o minus.o
	g++ -o main main.o add.o minus.o

main.o: main.cpp 
	g++ -c main.cpp

add.o: add.cpp 
	g++ -c add.cpp

minus.o: minus.cpp 
	g++ -c minus.cpp

clean:
	rm -f main *.o

.PHONY: all clean
