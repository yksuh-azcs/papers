unset key
unset label
unset size
set datafile missing "?"
set logscale x 2
set logscale y 2
set encoding iso_8859_1
set xlabel "Task length (sec) in log scale" font "Times-Roman, 20"
set xtics auto font "Times-Roman, 17"
set ytics auto font "Times-Roman, 17"
set term post eps enhanced
#set key top right font "Times-Roman, 22"
set key bottom right font "Times-Roman, 22"
#set xrange [0.8:20000]
#set output 'new_overall_pt_std.eps'
#set ylabel "Standard deviation (msec)" font "Times-Roman, 20"
set xrange [0.8:20000]
set output 'new_overall_pt_std_log.eps'
set ylabel "Standard deviation (msec) in log scale" font "Times-Roman, 20"
plot     "overall_pt_std.dat" using 1:($3) title "ET" with linespoint ls 4,\
         "overall_pt_std.dat" using 1:($2) title "PT" with linespoint ls 7 
set term X11; 
replot;
unset key;
