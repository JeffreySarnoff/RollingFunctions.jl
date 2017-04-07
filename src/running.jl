running_minimum(n, data)  = Roller(rolling(minimum,n), data)
running_maximum(n, data)  = Roller(rolling(maximum,n), data)
running_span(n, data)     = Roller(rolling(span,n), data)

running_median(n, data)   = Roller(rolling_focb(median,n), data)
running_mode(n, data)     = Roller(rolling_focb(mode,n), data)
running_mean(n, data)     = Roller(rolling_focb(mean,n), data)
running_geomean(n, data)  = Roller(rolling_focb(geomean,n), data)
running_harmmean(n, data) = Roller(rolling_focb(harmmean,n), data)

running_std(n, data)      = Roller(rolling_boca(std,n), data)
running_var(n, data)      = Roller(rolling_boca(var,n), data)

running_sem(n, data)      = Roller(rolling_locf(sem,n), data)
running_mad(n, data)      = Roller(rolling_locf(mad,n), data)
running_variation(n, data)= Roller(rolling_locf(variation,n), data)
running_entropy(n, data)  = Roller(rolling_locf(entropy,n), data)
