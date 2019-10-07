# delay = 50 ms
set terminal epslatex
set output "ker19SemSched.tex"
#set title "Kernel Linux - Lat\\^encia de interrup\\c{c}\\~ao"
set format y "$%3.1f$"
set format x "$% g$"
set xlabel "Tempo de observa\\c{c}\\~ao em $s$"
set xrange [:60]
set ylabel "Lat\\^encia em $\\mu s$" rotate
set yrange [0:30]
#set key at 38, 3
set style data points
set pointsize 1
#plot 'data' using ($0/16):1 notitle "" with points pointtype 1
plot 'data/str_sem' using 1:($3<30 ? $3 : 1/0) notitle "" with points pt 1 lt -1 ,\
       'data/str_sem' using 1:($3>30 ? 28 : 1/0) notitle "" with points pt 8 lt -1 ps 2
set output
set terminal pop
