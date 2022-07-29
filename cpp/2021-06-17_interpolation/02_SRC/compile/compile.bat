cd output
del *.exe
cd ..
cd codes 
gcc -c matrix.c
gcc -c poly_fit.c

gcc -o ..\output\matrix.exe matrix.o poly_fit.o

cd ..\output
matrix.exe
gnuplot bar.bat

cd ..

