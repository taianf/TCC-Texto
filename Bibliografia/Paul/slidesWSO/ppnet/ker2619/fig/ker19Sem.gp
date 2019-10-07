# delay = 50 ms
set terminal epslatex
set output "ker19Sem.tex"
#set title "Kernel Linux - Lat\\^encia de interrup\\c{c}\\~ao"
set format y "$%3.1f$"
set format x "$% g$"
set xlabel "Tempo de observa\\c{c}\\~ao em $s$"
set xrange [:60]
set ylabel "Lat\\^encia em $\\mu s$" rotate
set yrange [5:35]
#set key at 38, 3
set style data points
set pointsize 1
#plot 'data' using ($0/16):1 notitle "" with points pointtype 1
plot 'data/str_sem' using 1:($2<35 ? $2 : 1/0) notitle "" with points pt 1 lt -1 ,\
       'data/str_sem' using 1:($2>35 ? 32 : 1/0) notitle "" with points pt 8 lt -1 ps 2
set output
set terminal pop
