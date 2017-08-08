unset key
unset label
unset size
set encoding iso_8859_1
set xlabel "Percentage Difference (log scale)" font "Times-Roman, 18"
set ytics 0,10,100 font "Times-Roman, 18"
set format x "%g"
set logscale x 10
set term post eps enhanced
#set output '| epstopdf --filter --outfile=rel_diff.pdf'
set output 'rel_diff.eps'
set key top left
set yrange [-5:105]
#set xrange [0.05:25000]
set xrange [0.05:100000]
set ylabel "Cumulative Percentage" font "Times-Roman, 18" 
plot "subopt_data.dat" using 1:5 notitle pt 2 with linespoint
set term X11; replot;
unset key;

