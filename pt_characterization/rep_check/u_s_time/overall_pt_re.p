unset key
unset label
unset size
set log x 2
set log y 10 
set encoding iso_8859_1
set ylabel "Coefficient of variation (CV) in log scale" font "Times-Roman, 20"
set xlabel "Task length (sec) in log scale" font "Times-Roman, 20"
set xtics auto font "Times-Roman, 17"
set ytics auto font "Times-Roman, 17"
set term post eps enhanced
set key top right font "Times-Roman, 22"
#set xrange [0.8:5000]
set xrange [0.8:20000]
set yrange [0.0000001:0.01]
#set format y "%.1t{/Symbol \264}10^{%T}"
set format y "10^{%T}"

#####  mean divisor ### 
set output 'overall_pt_re.eps'
f(x) = a*x+b
title_f(a,b) = sprintf('f(x) = %.7fx+ %f', a, b)
fit f(x) 'overall_pt_re.dat' u  1:($2) via a, b
plot "overall_pt_re.dat" using 1:($3) title "ET" with linespoint ls 4,\
     "overall_pt_re.dat" using 1:($2) title "PT" with linespoint ls 7,\
      f(x) lt 1 t title_f(a,b)

#####  mean task length  ###
#set output 'new_overall_pt_re.eps'
#f(x) = a*x+b
#title_f(a,b) = sprintf('f(x) = %fx+ %f', a, b)
#fit f(x) 'new_overall_pt_re.dat' u  1:($2) via a, b
#plot "new_overall_pt_re.dat" using 1:($3) title "ET" with linespoint ls 4,\
#     "new_overall_pt_re.dat" using 1:($2) title "PT" with linespoint ls 7,\
#      f(x) lt 1 t title_f(a,b)

set term X11; replot;
unset key;
