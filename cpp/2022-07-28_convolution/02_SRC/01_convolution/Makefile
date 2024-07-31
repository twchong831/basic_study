APP_NAME=app

all: main.o
	gcc -o ${APP_NAME} main.c

main.o: main.c
	gcc -c main.c
	
clean:
	rm -rf *.o
	rm ${APP_NAME}
