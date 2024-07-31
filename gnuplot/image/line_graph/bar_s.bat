set term 'png'
set output 'image.png'

#set xlabel	"time t"
#set ylabel	"y=f(t)"

set boxwidth	0.1

#plot "out_bar.txt"	using 2:xtic(1) title "signal 1" col fc,\
#				""	using 3			title "signal 2" col fc

plot	"out_bar.txt" using 1:2 title "signal 1" with boxes fill pattern 1
		"" using 1:3 title "signal 2" with boxes fill pattern 2, \
		"" using 1:4 title "signal 3" with boxes fill pattern 3 


#pause mouse any "Any key or button will terminate window"
