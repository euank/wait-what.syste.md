set datafile separator ","
set xdata time
set timefmt '%Y-%m-%d'
set xrange["2012-06-01":"2012-06-02"]

plot 'timeline.csv' using 1:(1)
