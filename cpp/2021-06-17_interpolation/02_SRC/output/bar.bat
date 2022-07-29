

plot "point.txt" using 1:2 title "training points" w p pt 3 

replot 'fit.txt' using 1:2 title "regression result" with line


pause mouse any "Any key or button will terminate"
