module RollingFunctions

export rollmin, rollmax, rollmean, rollmedian, rollstd

import StatsBase

include("rolling.jl")
include("rollstats.jl")

end # RollingFunctions
