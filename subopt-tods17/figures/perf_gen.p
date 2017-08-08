unset key
unset label
unset size
unset ytics
set size 0.48,1
set encoding iso_8859_1
set xtics 3,1,13 font "Times-Roman, 18"
set term post eps enhanced
set output 'perf_gen.eps'
#set key at 7.5,0.28
#set format y "%.4f"
set xrange [3.5:13.5]
#set yrange [6:62]
#set yrange [-0.54:0.02]
#set yrange [0.2:0.54]
set yrange [-0.055:0.27]
set xlabel "{/Times-Bold-Italic Generation}" font "Times-Roman, 18"
set ylabel "{/Times-Bold-Italic Performance}" font "Times-Roman, 18" 
set style line 1 lt 1 lw 1 pt 145 
set style line 2 lt 1 lw 3 pt 82
set style line 3 lt 1 lw 1 pt 147
#set xzeroaxis lt 4
#plot "gen_benefit.dat" using 1:($2) title "Net Cumulative Relative Delta" with linespoint ls 2
plot "perf_gen.dat" using 1:($2) with linespoint ls 2
set term X11; replot;
unset key;
