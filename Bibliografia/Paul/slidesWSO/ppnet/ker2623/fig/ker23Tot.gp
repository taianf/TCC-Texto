# delay = 50 ms
set terminal epslatex
set output "ker23Tot.tex"
#set title "Kernel Linux - Lat\\^encia de interrup\\c{c}\\~ao"
set format y "$%3.1f$"
set format x "$% g$"
set xlabel offset 0,0.3
set ylabel offset 3,0
set xlabel "Tempo de observa\\c{c}\\~ao em $s$"
set xrange [0:60]
set ylabel "Lat\\^encia em $\\mu s$" rotate
set yrange [0:40]
#set key at 38, 3
set style data points
set pointsize 1
plot 'data/str_tot_udp' using ($1-300):($2<95 ? $2 : 1/0) notitle "" with points pt 1 lt -1 ,\
       'data/str_tot_udp' using ($1-300):($2>95 ? 95 : 1/0) notitle "" with points pt 8 lt -1 ps 2
set output
set terminal pop