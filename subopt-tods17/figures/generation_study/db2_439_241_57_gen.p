unset label;
unset key;
unset size;
set size 1.5,0.75
#set size ratio 2 
set datafile missing "?"
set encoding iso_8859_1
set title "" font "Times-Roman, 20"
#set terminal postscript landscape color font "Times-Roman, 20"
set term post eps enhanced
set output 'db2_439_241_57_gen.eps'

## db2
set xrange [500000:2030000]
set yrange [1:13]
set xlabel "Cardinality" font "Times-Roman, 20"
set ylabel "Generation" font "Times-Roman, 20"
#set xtic nomirror ("" 90000, "" 100000, "" 130000, "" 140000, "" 720000, "" 730000, "" 1010000, "" 1020000, "" 1120000, "" 1130000, "" 2000000) font "Times-Roman, 15"
set format x "%.1t{/Symbol \264}10^{%T}"
#set format x "%2.0t{/Symbol \264}10^{%L}"
#set xtic nomirror auto font "Times-Roman, 10"
#set xtics (10000, 50000, 100000, 500000, 1000000, 1500000, 2000000) font "Times-Roman, 12"
set xtics (500000, 1000000, 1500000, 2000000) font "Times-Roman, 12"
set ytic nomirror auto font "Times-Roman, 13"
#set label 1 "Finance" at 0.5, graph -0.03, 0 centre norotate font "Times-Roman, 15"
#set label 10000 "10K" at 10000,1 font "Times-Roman, 11"
#set label 90000 "90K" at 90000,0.5 rotate by -90 font "Times-Roman, 11"
#set label 130000 "130K" at 130000,1 font "Times-Roman, 11"
#set label 720000 "720K" at 720000,1 right font "Times-Roman, 11"
#set label 1010000 "1.01M" at 1010000,1 right font "Times-Roman, 11"
#set label 1120000 "1.12M" at 1120000,1 font "Times-Roman, 11"
#set label 2000000 "2M" at 2000000,1 font "Times-Roman, 11"
set key top right
plot 'db2_439_241_57.dat' using 1:2 title "DB2" with linespoints ls 6
set term X11; replot;
