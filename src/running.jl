running_minimum(n, data)  = Runner(LastSpansRoller(minimum,n), data)
running_maximum(n, data)  = Runner(LastSpansRoller(maximum,n), data)
running_span(n, data)     = Runner(LastSpansRoller(span,n), data)

running_median(n, data)   = Runner(LastSpansRoller(median,n), data)
running_mode(n, data)     = Runner(LastSpansRoller(mode,n), data)
running_mean(n, data)     = Runner(LastSpansRoller(mean,n), data)
running_geomean(n, data)  = Runner(LastSpansRoller(geomean,n), data)
running_harmmean(n, data) = Runner(LastSpansRoller(harmmean,n), data)

running_sem(n, data)      = Runner(StartSpansRoller(sem,n), data)
running_mad(n, data)      = Runner(StartSpansRoller(mad,n), data)
running_variation(n, data)= Runner(StartSpansRoller(variation,n), data)
running_entropy(n, data)  = Runner(StartSpansRoller(entropy,n), data)
