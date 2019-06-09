unset key
unset label
unset size
set encoding iso_8859_1
set term post eps enhanced
set output 'old80_md0_raid1.eps'
set key top right 
set xrange [80160:80186]
set yrange [-1:10]
set xlabel "{/Times-Bold-Italic INC Program Time (ms)}" font "Times-Roman, 18"
set ylabel "{/Times-Bold-Italic md0_raid1 Time(msec))}" font "Times-Roman, 18"
plot "inc80_old_daemon_stat.txt" using ($3):($6) title "INC PT vs. md0_raid1 PT" pt 7 
set terminal qt; replot;
