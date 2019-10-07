set terminal epslatex
#set terminal x11
set output "histo.tex"
#set format y "$%3.1f$"
#set format x "$% g$"
#set xlabel offset 0,0.3
set ylabel offset 2.7,0
set logscale y 10
set ylabel "Number of events"
set xrange [0:22]
set xlabel "Time $\\mu s$" rotate
#set key at 38, 3
#set style data points     

set boxwidth 1
# 1 relative
set style data histograms
set style fill pattern 
set style fill border -1
plot 'histo' using 3 title "$L_{act}$", '' using 2 title "$L_{irq}$"
set output
# set terminal pop
