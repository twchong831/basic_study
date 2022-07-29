set term 'png'
set output 'image.png'

#set xlabel	"time t"
#set ylabel	"y=f(t)"

set boxwidth	0.5

plot	"out.txt" using 1:2 title "signal 1" with boxes
#		"" using 1:3 title "signal 2" with boxes bw 0.5, \
#		"" using 1:4 title "signal 3" with boxes, \
#		"" using 1:5 title "signal 4" with boxes, \
#		"" using 1:6 title "signal 5" with boxes, \
#		"" using 1:7 title "signal 6" with boxes, \
#		"" using 1:8 title "signal 7" with boxes

#pause mouse any "Any key or button will terminate window"
