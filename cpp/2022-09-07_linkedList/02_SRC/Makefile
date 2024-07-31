TARGET:=linkedList
CC:=g++
CFLAGS   = -Wall
LINKER   = g++ -o
CXXFLAGS:=
LIBS:=

OS_NAME:=$(OS)
UNAME_S:= $(shell uname -s)
ifeq ($(OS), Windows_NT)
else
ifeq (${UNAME_S}, Linux)
	OS_NAME="linux"
endif

ifeq (${UNAME_S}, Darwin)
	OS_NAME="mac"
endif
endif

OBJECTS:=main.o
 
all: ${TARGET}

${TARGET}: ${OBJECTS}
	${CC} -o $@ $< ${LIBS} -g

.cpp.o:
	${CC} -std=c++11 -c ${CXXFLAGS} $<

clean:
	rm -rf *.o
	rm -rf ${TARGET}