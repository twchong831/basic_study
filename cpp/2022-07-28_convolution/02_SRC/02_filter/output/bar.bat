
set xlabel	"time t"
set ylabel	"y=f(t)"

plot	"out.txt" using 1:2 with lines, \
		"out.txt" using 1:3 with lines

pause mouse any "Any key or button will terminate window"
