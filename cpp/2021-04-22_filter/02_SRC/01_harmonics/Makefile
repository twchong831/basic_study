OS:=$(shell uname -s)

all:
	@echo "Detect OS : ${OS}"

ifeq ($(OS),Linux)
	@echo "linux"
	(cd codes;		make all)
	(cd output;		./filter)
	(cd output;		gnuplot bar.bat)
else
	@echo "windows"
	(cd codes	&	make all)
	(cd output	&	filter)
	(cd output	&	gnuplot bar.bat)
endif
