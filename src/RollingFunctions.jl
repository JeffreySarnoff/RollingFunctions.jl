module RollingFunctions

export rollmin,  rollmax,             # min, max
       rollmean, rollmedian,          # mean, median
       rollvar,  rollstd,             # variance, standard deviation
       rollskewness, rollkurtosis,    # skewness, kurtosis
       rollsem,                       # standard error of the mean
       rollmad,                       # mean absolute deviation
       rollmad_normalized,            # mean absolute deviation for normal data
       rollvariation,                 # coefficient of variation
                                      #      tapering versions
       runmin,  runmax,               # min, max
       runmean, runmedian,            # mean, median
       runvar,  runstd,               # variance, standard deviation
       runskewness, runkurtosis,      # skewness, kurtosis
       runsem,                        # standard error of the mean
       runmad,                        # mean absolute deviation
       runmad_normalized,             # mean absolute deviation for normal data
       runvariation                   # coefficient of variation



using StatsBase

include("rolling.jl")
include("running.jl")
include("rollstats.jl")

end # RollingFunctions
