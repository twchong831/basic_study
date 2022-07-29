
set xlabel	"x(n)"
set ylabel	"n"

plot	"out.txt" using 1:2 title "polynomial signal(sum of harmonics)" with lines

pause mouse any "Any key or button will terminate window"
