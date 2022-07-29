set term	png size 1000,1000
set output	'test_label5.png'

set tmargin 1
set lmargin 2
set bmargin 3
set rmargin 4

set xlabel	"x-tics" font ",20" offset 0,0,0
set ylabel	"y-tics" font ",40" offset 6,0,0

#set label "test label" at 2,2

f(x)=x
i=3.5
str=gprintf("test label : %g", i)
set label str at 2,2
plot [x=0:4] f(x) notitle with l

unset output

