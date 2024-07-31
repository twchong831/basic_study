set term 'png'
set output 'image.png'

plot	"out.txt" using 1:2 title "signal" with boxes 

pause mouse any "Any key or button will terminate window"
