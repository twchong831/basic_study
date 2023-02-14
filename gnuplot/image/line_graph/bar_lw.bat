set term 'png'
set output 'image.png'

#set xlabel	"time t"
#set ylabel	"y=f(t)"


plot	"out.txt" using 1:2 title "signal 1" w l lw 1, \
		"" using 1:3 title "signal 2" w l linewidth 2, \
		"" using 1:4 title "signal 3" w l lw 3, \
		"" using 1:5 title "signal 4" w l lw 4

pause mouse any "Any key or button will terminate window"
