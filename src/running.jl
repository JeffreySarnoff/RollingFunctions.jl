runmin(n, data)  = runner(Roller(rolling, minimum, n), data)
runmax(n, data)  = runner(Roller(rolling, maximum, n), data)
runspan(n, data) = runner(Roller(rolling, span, n), data)

runstd(n, data)  = runner(Roller(rolling, std, n), data)
runvar(n, data)  = runner(Roller(rolling, var, n), data)
runmad(n, data)  = runner(Roller(rolling, mad, n), data)
runsem(n, data)  = runner(Roller(rolling, sem, n), data)

runmedian(n, data)    = runner(Roller(rolling, median, n), data)
runmode(n, data)      = runner(Roller(rolling, mode, n), data)
runmean(n, data)      = runner(Roller(rolling, mean, n), data)
rungeomean(n, data)   = runner(Roller(rolling, geomean, n), data)
runharmmean(n, data)  = runner(Roller(rolling, harmmean, n), data)

runvariation(n, data) = runner(Roller(rolling, variation, n), data)
runentropy(n, data)   = runner(Roller(rolling, entropy, n), data)


runmin_backfill(n, data)  = runner(Roller(rolling_backfill, minimum, n), data)
runmax_backfill(n, data)  = runner(Roller(rolling_backfill, maximum, n), data)
runspan_backfill(n, data) = runner(Roller(rolling_backfill, span, n), data)

runstd_backfill(n, data)  = runner(Roller(rolling_backfill, std, n), data)
runvar_backfill(n, data)  = runner(Roller(rolling_backfill, var, n), data)
runmad_backfill(n, data)  = runner(Roller(rolling_backfill, mad, n), data)
runsem_backfill(n, data)  = runner(Roller(rolling_backfill, sem, n), data)

runmedian_backfill(n, data)    = runner(Roller(rolling_backfill, median, n), data)
runmode_backfill(n, data)      = runner(Roller(rolling_backfill, mode, n), data)
runmean_backfill(n, data)      = runner(Roller(rolling_backfill, mean, n), data)
rungeomean_backfill(n, data)   = runner(Roller(rolling_backfill, geomean, n), data)
runharmmean_backfill(n, data)  = runner(Roller(rolling_backfill, harmmean, n), data)

runvariation_backfill(n, data) = runner(Roller(rolling_backfill, variation, n), data)
runentropy_backfill(n, data)   = runner(Roller(rolling_backfill, entropy, n), data)
