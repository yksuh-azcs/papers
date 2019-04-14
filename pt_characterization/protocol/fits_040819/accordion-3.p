unset key
unset label
unset size
set encoding iso_8859_1
set term post eps enhanced
set output 'ap-3.eps'
set key top right
set xrange [22:32]
set yrange [-9:9]
set xlabel "{/Times-Bold-Italic INC number}" font "Times-Roman, 18"
set ylabel "{/Times-Bold-Italic Relative to 1002.1*INC number}" font "Times-Roman, 18"
set style line 1 lt 1 lw 1 pt 145 
set style line 2 lt 1 lw 3 pt 82
set style line 3 lt 1 lw 1 pt 147
plot "FITS.txt" using 1:($3) title "Mean 1" with linespoint ls 1,\
     "FITS.txt" using 1:($4) title "Mean 2" with linespoint ls 2 
set terminal qt; replot;

