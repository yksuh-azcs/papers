unset key
unset label
unset size
set encoding iso_8859_1
set xtics 4,1,13 font "Times-Roman, 18"
set ytics -0.30,0.03,0.30 font "Times-Roman, 18"
set term post eps enhanced
set output 'gen_benefit.eps'
#set key top left
set key at 7,0.28
set format y "%.2f"
set xrange [3:14]
set yrange [-0.30:0.30]
set xlabel "{/Times-Bold-Italic Generation}" font "Times-Roman, 18"
set ylabel "{/Times-Bold-Italic Cumulative average relative delta}" font "Times-Roman, 18" 
set style line 1 lt 1 lw 1 pt 145 
set style line 2 lt 1 lw 3 pt 82
set style line 3 lt 1 lw 1 pt 147
set xzeroaxis lt 4
plot "gen_benefit.dat" using 1:($2) title "Not suboptimal" with linespoint ls 1,\
     "gen_benefit.dat" using 1:($3) title "Weighted (Net benefit)" with linespoint ls 2,\
     "gen_benefit.dat" using 1:($4) title "Suboptimal" with linespoint ls 3
set term X11; replot;
unset key;
