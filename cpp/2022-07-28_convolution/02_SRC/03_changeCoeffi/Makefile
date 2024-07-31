clean:
	(cd codes;		make clean)
	rm -rf output/signalProcessor
all:
	(cd codes;		make all)
	(cd output;		./signalProcessor)
	(cd output;		gnuplot bar.bat)
