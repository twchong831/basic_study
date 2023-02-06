set term 'png'
set output 'image.png'

#set xlabel	"time t"
#set ylabel	"y=f(t)"

#plot	"out.txt" using 1:2 title "signal 1" lt rgb "red" with lines, \
#		"out.txt" using 1:3 title "signal 2" lt rgb "green" with lines, \
#		"out.txt" using 1:4 title "signal 3" lt 1 with lines, \
#		"out.txt" using 1:5 title "signal 4" ls 2 with lines, \
#		"out.txt" using 1:6 title "signal 5" ls 3 with lines, \
#		"out.txt" using 1:7 title "signal 6" ls 4 with lines, \
#		"out.txt" using 1:8 title "signal 7" ls 5 with lines, \

plot	"out.txt" using 1:2 title "signal 1" with lp, \
		"" using 1:3 title "signal 2" with lp, \
		"" using 1:4 title "signal 3" with lp, \
		"" using 1:5 title "signal 4" with lp  
#		"" using 1:6 title "signal 5" with lines, \
#		"" using 1:7 title "signal 6" with lines, \
#		"" using 1:8 title "signal 7" with lines 

pause mouse any "Any key or button will terminate window"
