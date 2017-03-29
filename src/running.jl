running_minimum(n, data) = Runner(FinalSpansRoller(minimum,n), data)
running_maximum(n, data) = Runner(FinalSpansRoller(maximum,n), data)

running_median(n, data)  = Runner(FinalSpansRoller(median,n), data)
running_mean(n, data)    = Runner(FinalSpansRoller(mean,n), data)
