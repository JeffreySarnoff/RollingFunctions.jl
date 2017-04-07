running_minimum(n, data)  = Runner(Roller(rolling, minimum, n), data)
running_maximum(n, data)  = Runner(Roller(rolling, maximum, n), data)
running_span(n, data)     = Runner(Roller(rolling, span, n), data)

running_median(n, data)   = Runner(Roller(rolling_focb, median, n), data)
running_mode(n, data)     = Runner(Roller(rolling_focb, mode, n), data)
running_mean(n, data)     = Runner(Roller(rolling_focb, mean, n), data)
running_geomean(n, data)  = Runner(Roller(rolling_focb, geomean, n), data)
running_harmmean(n, data) = Runner(Roller(rolling_focb, harmmean, n), data)

running_std(n, data)      = Runner(Roller(rolling_focb, std, n), data)
running_var(n, data)      = Runner(Roller(rolling_focb, var, n), data)

running_sem(n, data)      = Runner(Roller(rolling_locf, sem, n), data)
running_mad(n, data)      = Runner(Roller(rolling_locf, mad, n), data)
running_variation(n, data)= Runner(Roller(rolling_locf, variation, n), data)
running_entropy(n, data)  = Runner(Roller(rolling_locf, entropy, n), data)
