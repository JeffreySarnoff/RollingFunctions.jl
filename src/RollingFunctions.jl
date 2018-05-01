module RollingFunctions

export rollmin,  rollmax,             # min, max
       rollmean, rollmedian,          # mean, median
       rollvar,  rollstd,             # variance, standard deviation
       rollskewness, rollkurtosis,    # skewness, kurtosis
       rollsem,                       # standard error of the mean
       rollmad,                       # mean absolute deviation
       rollvariation                  # coefficient of variation



using StatsBase

include("rolling.jl")
include("rollstats.jl")

end # RollingFunctions
