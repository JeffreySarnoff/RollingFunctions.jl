rollspan(n, data) = runner(Roller(rolling, span), n, data)
rollstd(n, data)  = runner(Roller(rolling, std), n, data)
rollvar(n, data)  = runner(Roller(rolling, var), n, data)
rollmad(n, data)  = runner(Roller(rolling, mad), n, data)

rollminimum(n, data)   = runner(Roller(rolling, minimum), n, data)
rollmaximum(n, data)   = runner(Roller(rolling, maximum), n, data)
rollmedian(n, data)    = runner(Roller(rolling, median), n, data)
rollmode(n, data)      = runner(Roller(rolling, mode), n, data)
rollmean(n, data)      = runner(Roller(rolling, mean), n, data)


rollspan_backfill(n, data) = runner(Roller(rolling_backfill, span), n, data)
rollstd_backfill(n, data)  = runner(Roller(rolling_backfill, std), n, data)
rollvar_backfill(n, data)  = runner(Roller(rolling_backfill, var), n, data)
rollmad_backfill(n, data)  = runner(Roller(rolling_backfill, mad), n, data)

rollminimum_backfill(n, data)   = runner(Roller(rolling_backfill, minimum), n, data)
rollmaximum_backfill(n, data)   = runner(Roller(rolling_backfill, maximum), n, data)
rollmedian_backfill(n, data)    = runner(Roller(rolling_backfill, median), n, data)
rollmode_backfill(n, data)      = runner(Roller(rolling_backfill, mode), n, data)
rollmean_backfill(n, data)      = runner(Roller(rolling_backfill, mean), n, data)

