unset key
unset label
unset size
set datafile missing "?"
set logscale x 2
set encoding iso_8859_1
set xrange [0.8:20000]
set xlabel "Task length (sec) in log scale" font "Times-Roman, 20"
set xtics auto font "Times-Roman, 17"
set ytics auto font "Times-Roman, 17"
set term post eps enhanced
set key bottom right font "Times-Roman, 22"
#set logscale y 2
#f(x) = a*x+b
f(x) = a*log(x)+b
set output 'new_overall_pt_std.eps'
#set output 'new_overall_pt_std_log.eps'
set ylabel "Standard deviation (msec)" font "Times-Roman, 20"
#set ylabel "Standard deviation (msec) in log scale" font "Times-Roman, 20"
title_f(a,b) = sprintf('f(x) = %.2flog(x)+ %.2f', a, b)
#title_f(a,b) = sprintf('f(x) = %.2fx+ %.2f', a, b)
fit f(x) 'new_overall_pt_std.dat' u  1:($2) via a, b
#fit f(x) 'new_overall_pt_std.dat' u (log($1)):(log($2)) via a, b
plot     "overall_pt_std.dat" using 1:($3) title "ET" with linespoint ls 4,\
         "new_overall_pt_std.dat" using 1:($2) title "PT" with linespoint ls 7, f(x) lt 1 t title_f(a,b) 
set term X11; 
replot;
unset key;
