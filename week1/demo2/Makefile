CXX	=	gcc
BIN	=	main
SRCS 	=	$(wildcard src/*.cpp)
OBJS	=	$(SRCS:.cpp=.o)

all: $(OBJS)
	$(CXX) $(OBJS) -o $(BIN)

clean: 
	rm -f $(OBJS) $(BIN)

.PHONY: all clean

