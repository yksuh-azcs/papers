unset key
unset label
unset size
set encoding iso_8859_1
set term post eps enhanced
set output 'new80_rhs.eps'
set key top right 
set xrange [80160:80186]
set yrange [-1:130]
set xlabel "{/Times-Bold-Italic INC Program Time (ms)}" font "Times-Roman, 18"
set ylabel "{/Times-Bold-Italic rhsmcertd-worke Time(msec))}" font "Times-Roman, 18"
plot "inc80_new_daemon_stat.txt" using ($3):($7) title "INC PT vs. rhsmcertd-worke PT in the new INC80" pt 7 
set terminal qt; replot;
