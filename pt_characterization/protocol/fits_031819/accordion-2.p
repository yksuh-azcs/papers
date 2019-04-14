unset key
unset label
unset size
set encoding iso_8859_1
set term post eps enhanced
set output 'ap-2.eps'
set key top right
set xrange [16:22]
set yrange [-4:14]
set xlabel "{/Times-Bold-Italic INC number}" font "Times-Roman, 18"
set style line 1 lt 1 lw 1 pt 145 
set style line 2 lt 1 lw 3 pt 82
set style line 3 lt 1 lw 1 pt 147
plot "FITS.txt" using 1:($6) title "Mean 1" with linespoint ls 1,\
     "FITS.txt" using 1:($7) title "Mean 2" with linespoint ls 2 
set terminal qt; replot;

