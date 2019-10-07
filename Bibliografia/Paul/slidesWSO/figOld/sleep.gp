set terminal epslatex
set output "sleep.tex"
set title "Chamada  \\texttt{sleep} de 6 $m s$"
set format y "$%3.1f$"
set format x "$%3.1f$"
set xlabel "Instante da chamada em $m s$"
set ylabel "Duração real do \\texttt{sleep} em $m s$" rotate
set key at 38, 3
set style data points
set pointsize 2
plot 'sai1' using 1:($2>1 ? $2 : 1/0) title "Execu\\c{c}\\~ao 1" with points pointtype 3 ,\
       'sai2' using 1:($2>1 ? $2 : 1/0) title "Execu\\c{c}\\~ao 2" with points pointtype 4
set output
set terminal pop
