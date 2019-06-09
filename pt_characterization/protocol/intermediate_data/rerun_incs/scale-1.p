unset key
unset label
unset size
set encoding iso_8859_1
set term post eps enhanced
set output 'old80_kslowd000.eps'
set key top right 
set xrange [80160:80186]
set yrange [-1:6]
set xlabel "{/Times-Bold-Italic INC PT}" font "Times-Roman, 18"
set ylabel "{/Times-Bold-Italic Time(msec))}" font "Times-Roman, 18"
plot "inc80_old_daemon_stat.txt" using ($3):($4) pt 7 
set terminal qt; replot;

