ifeq ($(OS), WINDOWS_NT)
all:
	gcc -o app main.c
clean:
	del app*
else
all:
	gcc -o app main.c
clean:
	rm app
endif
