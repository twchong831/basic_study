
set xlabel	"freq"
set ylabel	"X(f)"

plot	"out.txt" using 1:2 title "Signal Spectrum" w impulses lw 2, \
		"out.txt" using 1:2 title "Signal Spectrum" w p pt 6

pause mouse any "Any key or button will terminate window"
