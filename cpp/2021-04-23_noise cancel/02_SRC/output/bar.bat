
set xlabel	"time t"
set ylabel	"y=f(t)"

#plot	"out.txt" using 1:2 title "noisy signal" lt rgb "red" with lines, \
#		"out.txt" using 1:3 title "cancelled signal" lt rgb "green" with lines, \
#		"out.txt" using 1:4 title "filtered signal" lt rgb "blue" with lines

plot	"out.txt" using 1:4 title "filtered signal" lt rgb "blue" with lines, \
		"out.txt" using 1:5 title "1Hz signal" lt rgb "purple" with lines

pause mouse any "Any key or button will terminate window"
