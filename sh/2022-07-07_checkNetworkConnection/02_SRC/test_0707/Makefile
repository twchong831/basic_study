#main source code Path
SRC_HOME=.

APP_NAME=test_connect_check

BASE_PATH=/usr/local/
LIB_INC=${BASE_PATH}/include/CARNAVICOM_LIB
LIB_PATH=${BASE_PATH}/lib

LIBS=-L${LIB_PATH} -lCarnaviUDP

vpath %.h	${SRC_HOME}
vpath %.cpp	${SRC_HOME}

vpath %.h	${LIB_INC}/UDP
vpath %.h	${LIB_INC}/include

OBJ = main.o

all: ${APP_NAME}

#generate & compile active file file
${APP_NAME}: ${OBJ}	#dependency *.o
	g++ -o $@ $< ${LIBS}

#generate & compile *.o file
.cpp.o:					#generate *.o using .cpp
	g++ -std=c++11 -c -I${LIB_INC} $<

clean:
	@rm -rf *.o
	rm -rf ${APP_NAME}