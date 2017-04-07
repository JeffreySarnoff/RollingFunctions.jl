runspan(n, data) = runner(Roller(rolling, span, n), data)
runstd(n, data)  = runner(Roller(rolling, std, n), data)
runvar(n, data)  = runner(Roller(rolling, var, n), data)
runmad(n, data)  = runner(Roller(rolling, mad, n), data)

runminimum(n, data)   = runner(Roller(rolling, minimum, n), data)
runmaximum(n, data)   = runner(Roller(rolling, maximum, n), data)
runmedian(n, data)    = runner(Roller(rolling, median, n), data)
runmode(n, data)      = runner(Roller(rolling, mode, n), data)
runmean(n, data)      = runner(Roller(rolling, mean, n), data)


runspan_backfill(n, data) = runner(Roller(rolling_backfill, span, n), data)
runstd_backfill(n, data)  = runner(Roller(rolling_backfill, std, n), data)
runvar_backfill(n, data)  = runner(Roller(rolling_backfill, var, n), data)
runmad_backfill(n, data)  = runner(Roller(rolling_backfill, mad, n), data)

runminimum_backfill(n, data)   = runner(Roller(rolling_backfill, minimum, n), data)
runmaximum_backfill(n, data)   = runner(Roller(rolling_backfill, maximum, n), data)
runmedian_backfill(n, data)    = runner(Roller(rolling_backfill, median, n), data)
runmode_backfill(n, data)      = runner(Roller(rolling_backfill, mode, n), data)
runmean_backfill(n, data)      = runner(Roller(rolling_backfill, mean, n), data)

