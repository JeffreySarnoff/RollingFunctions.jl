module RollingFunctions

export rollmin, rollmax,              # min, max
       rollmean, rollmedian,          # mean, median
       rollwmean, rollwmedian         # weighted mean, weighted median


import StatsBase

include("rolling.jl")
include("rollstats.jl")

end # RollingFunctions
