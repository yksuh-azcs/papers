unset key
unset label
unset size
set log x 2
set log y 10 
set encoding iso_8859_1
#set xlabel "Task length (sec) in log scale" font "Times-Roman, 20"
set xlabel "Task length (sec)" font "Times-Roman, 20"
set xtics auto font "Times-Roman, 20"
set ytics auto font "Times-Roman, 18"
set term post eps enhanced
set key top right font "Times-Roman, 22"
#set xrange [-20:4200]
set xrange [0.8:20000]
set yrange [0.0000001:0.001]
set output 'overall_pt_re.eps'
set format y "%.1t{/Symbol \264}10^{%T}"
set ylabel "Relative error in log scale" font "Times-Roman, 22"
plot "overall_pt_re.dat" using 1:($7) title "EMP(v6)" with linespoint ls 6 
set term X11; replot;
unset key;
