set datafile separator ","
set xdata time
set timefmt '%Y-%m-%d'
set xrange["2012-06-01":"2012-06-02"]

set style line 1 linetype 2
set grid
set multiplot

plot "timeline.csv" using 1:2 with lines
