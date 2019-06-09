unset key
unset label
unset size
set encoding iso_8859_1
set term post eps enhanced
set output 'new80_ptsum.eps'
set key top right 
set xrange [80160:80186]
set yrange [-1:140]
set xlabel "{/Times-Bold-Italic INC Program Time (ms)}" font "Times-Roman, 18"
set ylabel "{/Times-Bold-Italic PT Total (msec))}" font "Times-Roman, 18"
plot "inc80_new_daemon_stat.txt" using ($3):($8) title "INC PT vs. PT Total in the new INC80" pt 7 
set terminal qt; replot;
