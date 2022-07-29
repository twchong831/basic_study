clean:
	rm -rf output/filter
all:
	(cd codes;		make all)
	(cd output;		./filter)
	(cd output;		gnuplot bar.bat)
