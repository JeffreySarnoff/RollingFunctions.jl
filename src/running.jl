running_minimum(n, data)  = runner(Roller(rolling, minimum, n), data)
running_maximum(n, data)  = runner(Roller(rolling, maximum, n), data)
running_span(n, data)     = runner(Roller(rolling, span, n), data)

running_median(n, data)   = runner(Roller(rolling_focb, median, n), data)
running_mode(n, data)     = runner(Roller(rolling_focb, mode, n), data)
running_mean(n, data)     = runner(Roller(rolling_focb, mean, n), data)
running_geomean(n, data)  = runner(Roller(rolling_focb, geomean, n), data)
running_harmmean(n, data) = runner(Roller(rolling_focb, harmmean, n), data)

running_std(n, data)      = runner(Roller(rolling_focb, std, n), data)
running_var(n, data)      = runner(Roller(rolling_focb, var, n), data)

running_sem(n, data)      = runner(Roller(rolling_locf, sem, n), data)
running_mad(n, data)      = runner(Roller(rolling_locf, mad, n), data)
running_variation(n, data)= runner(Roller(rolling_locf, variation, n), data)
running_entropy(n, data)  = runner(Roller(rolling_locf, entropy, n), data)
