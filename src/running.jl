running_minimum(n, data)  = Runner(FinalSpansRoller(minimum,n), data)
running_maximum(n, data)  = Runner(FinalSpansRoller(maximum,n), data)
running_span(n, data)     = Runner(FinalSpansRoller(span,n), data)

running_median(n, data)   = Runner(FinalSpansRoller(median,n), data)
running_mode(n, data)     = Runner(FinalSpansRoller(mode,n), data)
running_mean(n, data)     = Runner(FinalSpansRoller(mean,n), data)
running_geomean(n, data)  = Runner(FinalSpansRoller(geomean,n), data)
running_harmmean(n, data) = Runner(FinalSpansRoller(harmmean,n), data)

running_sem(n, data)      = Runner(FinalSpansRoller(sem,n), data)
running_mad(n, data)      = Runner(FinalSpansRoller(mad,n), data)
running_variation(n, data)= Runner(FinalSpansRoller(variation,n), data)
running_entropy(n, data)  = Runner(FinalSpansRoller(entropy,n), data)
