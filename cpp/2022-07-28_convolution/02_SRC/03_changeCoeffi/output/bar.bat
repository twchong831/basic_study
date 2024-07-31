
set xlabel	"time t"
set ylabel	"y=f(t)"

plot	"out.txt" using 1:2 title "noisy signal" lt rgb "red" with lines, \
		"out.txt" using 1:3 title "convloution signal" lt rgb "green" with lines, \
		"out.txt" using 1:4 title "h changed signal" lt 1 with lines, \
		"out.txt" using 1:5 title "h[0] 2nd changed signal" ls 2 with lines, \
		"out.txt" using 1:6 title "h[0] 3rd changed signal" ls 3 with lines, \
		"out.txt" using 1:7 title "h[0] 4th changed signal" ls 4 with lines, \
		"out.txt" using 1:8 title "h[0] 5th changed signal" ls 5 with lines, \

pause mouse any "Any key or button will terminate window"
