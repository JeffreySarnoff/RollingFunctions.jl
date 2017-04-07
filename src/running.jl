running_minimum(n, data)  = Runner(rolling(minimum,n), data)
running_maximum(n, data)  = Runner(rolling(maximum,n), data)
running_span(n, data)     = Runner(rolling(span,n), data)

running_median(n, data)   = Runner(rolling_focb(median,n), data)
running_mode(n, data)     = Runner(rolling_focb(mode,n), data)
running_mean(n, data)     = Runner(rolling_focb(mean,n), data)
running_geomean(n, data)  = Runner(rolling_focb(geomean,n), data)
running_harmmean(n, data) = Runner(rolling_focb(harmmean,n), data)

running_std(n, data)      = Runner(rolling_boca(std,n), data)
running_var(n, data)      = Runner(rolling_boca(var,n), data)

running_sem(n, data)      = Runner(rolling_locf(sem,n), data)
running_mad(n, data)      = Runner(rolling_locf(mad,n), data)
running_variation(n, data)= Runner(rolling_locf(variation,n), data)
running_entropy(n, data)  = Runner(rolling_locf(entropy,n), data)
