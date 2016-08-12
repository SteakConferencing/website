#!/usr/bin/gnuplot
#
# <+DESCRIPTION+>
#
# AUTHOR: Hagen Wierstorf
# gnuplot 5.0 patchlevel 3

reset
set macros

# png
set terminal pngcairo size 350,264 enhanced font 'Verdana,10'


set border 0 
set style line 101 lc rgb '#808080' lt 1 lw 1
unset xlabel
unset ylabel
set format x ''
set format y ''
set tics scale 0


# Blue figures
load 'blues.pal'

unset key
set size ratio -1

set xrange [-2.0:2.0]
set yrange [-1.0:2.0]
set cbrange [-100:0]
set tics scale 0.75 out nomirror
set xtics 1 offset 0,0.5
set ytics 1 offset 0.5,0
set cbtics 10 offset -0.5,0
set cbtics add ('60 dB' 60)
#set xlabel 'x / m' offset 0,1
#set ylabel 'y / m' offset 1.5,0
unset colorbox

set lmargin 0
set rmargin 0
set tmargin 0
set bmargin 0

n=0
do for [ii=3000:5000:10] {
    n=n+1
    set output sprintf('rendered/%03.0f.png',n)
    plot sprintf('data/sfs%04.0f.dat',ii) binary matrix u 1:2:(20*log10($3)) w image
}
