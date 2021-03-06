unset key
unset label
unset size
set encoding iso_8859_1
set xlabel "Task Length (sec)" font "Times-Roman, 18"
set ytics auto font "Times-Roman, 18"
#set format x "%L"
set logscale x 2
set logscale y 2
#set format y "%L"
set term post eps enhanced
set key top left
set xrange [0.8:2500]
set yrange [512:2500000]
set output 'overall_pt_avg_log.eps'
set ylabel "Average Process Time (msec)" font "Times-Roman, 18"
plot "overall_pt.dat" using 1:5 title "Avg. Process Time over Increasing Task Length" with linespoint
set term X11; replot;
unset key;

