unset key
unset label
unset size
set encoding iso_8859_1
#set ytics auto 10 font "Times-Roman, 18"
set xtics 0,10,130 font "Times-Roman, 18"
set ytics 0,10,100 font "Times-Roman, 18"
#set format x "%L"
#set format x "%g"
set term post eps enhanced
#set output '| epstopdf --filter --outfile=org_ncpq.pdf'
set output 'org_ncpq.eps'
set key top left
set xrange [-4:135]
set yrange [0:110]
set xlabel "Number of Change Points" font "Times-Roman, 18"
set ylabel "Cumulative Percentage" font "Times-Roman, 18" 
plot "ncpq.dat" using 1:4 notitle pt 2 with linespoint
set term X11; replot;
unset key;

