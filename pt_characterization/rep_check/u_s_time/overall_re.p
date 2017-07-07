unset key
unset label
unset size
set log x 2
set log y 10 
set encoding iso_8859_1
set xlabel "Task length (sec) in log scale" font "Times-Roman, 20"
set xtics auto font "Times-Roman, 17"
set ytics auto font "Times-Roman, 17"
set term post eps enhanced
set key top right font "Times-Roman, 22"
set xrange [0.8:5000]
set yrange [0.0000001:0.01]
set output 'overall_re.eps'
#set format y "%.1t{/Symbol \264}10^{%T}"
set format y "10^{%T}"
set ylabel "Coefficient of variation (CV) in log scale" font "Times-Roman, 20"
plot "overall_re.dat" using 1:($3) title "ET" with linespoint ls 4,\
     "overall_re.dat" using 1:($2) title "PT" with linespoint ls 7 
set term X11; replot;
unset key;
