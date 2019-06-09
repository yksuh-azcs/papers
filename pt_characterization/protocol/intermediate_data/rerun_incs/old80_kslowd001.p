unset key
unset label
unset size
set encoding iso_8859_1
set term post eps enhanced
set output 'old80_kslowd001.eps'
set key top right 
set xrange [80160:80186]
set yrange [-1:10]
set xlabel "{/Times-Bold-Italic INC Program Time (ms)}" font "Times-Roman, 18"
set ylabel "{/Times-Bold-Italic kslowd001 Time(msec))}" font "Times-Roman, 18"
plot "inc80_old_daemon_stat.txt" using ($3):($5) title "INC PT vs. kslowd001 PT" pt 7 
set terminal qt; replot;
