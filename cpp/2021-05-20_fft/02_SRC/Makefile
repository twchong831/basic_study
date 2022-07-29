STYLE="{BasedOnStyle: llvm, IndentWidth: 8}"
FORMATTER=clang-format-3.8
LIB_PATH="/opt/amdgpu-pro/lib/x86_64-linux-gnu"

all: fft.c pgm.h
	gcc -g fft.c -o fft -L${LIB_PATH} -lOpenCL -lm

format:
	${FORMATTER} -style=${STYLE} -i fft.c
	${FORMATTER} -style=${STYLE} -i pgm.h

clean:
	rm -rf fft
