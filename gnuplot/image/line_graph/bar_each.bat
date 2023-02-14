set term 'png'
set output 'image.png'

#set xlabel	"time t"
#set ylabel	"y=f(t)"

set boxwidth	0.7
set style data histograms
plot "out_bar.txt"	using 2:xtic(1) title "signal 1",\
				""	using 3 title "signal 2"

