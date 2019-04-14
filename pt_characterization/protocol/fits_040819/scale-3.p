unset key
unset label
unset size
set encoding iso_8859_1
set term post eps enhanced
set output 'sp-3.eps'
set key top right
set xrange [22:32]
set yrange [-0.1:1.1]
set xlabel "{/Times-Bold-Italic INC number}" font "Times-Roman, 18"
set ylabel "{/Times-Bold-Italic Strength(0-1)}" font "Times-Roman, 18"
set style line 1 lt 1 lw 1 pt 145 
set style line 2 lt 1 lw 3 pt 82
#set style line 3 lt 1 lw 1 pt 147
plot "FITS.txt" using 1:($8) title "SCALE1" with linespoint ls 1,\
     "FITS.txt" using 1:($9) title "SCALE2" with linespoint ls 2
#     "FITS.txt" using 1:($10-$11) title "(SCALE1-SCALE2)" with linespoint ls 3 
set terminal qt; replot;

