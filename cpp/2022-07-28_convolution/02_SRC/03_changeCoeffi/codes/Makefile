APP_NAME=signalProcessor
APP_HOME=../output

SRC_HOME=.

vpath %.h	${SRC_HOME}
vpath %.c	${SRC_HOME}


all: ${APP_NAME}

${APP_NAME}:
	gcc -o ${APP_HOME}/$@ main.c convolutionFilter.c noiseFilter.c signalProcess.c -lm
#	cp $@ ${APP_HOME}

clean:
	rm -rf ${APP_HOME}/${APP_NAME}
	rm -rf *.o
	rm -rf ${APP_NAME}
