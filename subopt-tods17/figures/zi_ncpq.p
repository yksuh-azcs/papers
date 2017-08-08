unset key
unset label
unset size
set encoding iso_8859_1
#set xtics 0,5,50 font "Times-Roman, 18"
set xtics 0,10,140 font "Times-Roman, 18"
set ytics 0,10,100 font "Times-Roman, 18"
set term post eps enhanced
#set output '| epstopdf --filter --outfile=zi_ncpq.pdf'
set output 'zi_ncpq.eps'
set key top left
#set xrange [-1:39]
set xrange [-1:140]
set yrange [0:110]
set xlabel "Number of Suboptimal Change Points" font "Times-Roman, 18"
set ylabel "Cumulative Percentage" font "Times-Roman, 18" 
#plot "zi_ncpq.dat" using 1:3 notitle pt 2 with linespoint
plot "zi_ncpq.dat" using 1:4 notitle pt 2 with linespoint
set term X11; replot;
unset key;

