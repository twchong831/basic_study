ifeq ( $(OS), Windows_NT )
all:
	gcc -o writer writer.c
	gcc -o reader reader.c
clean:
	del writer
	del reader

else
all:
	gcc -o writer writer.c
	gcc -o reader reader.c

clean:
	rm writer
	rm reader
	
endif

