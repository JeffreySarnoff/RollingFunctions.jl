module RollingFunctions

export rolling,
       rollmin,  rollmax,             # min, max
       rollmean, rollmedian,          # mean, median
       rollvar,  rollstd,             # variance, standard deviation
       rollskewness, rollkurtosis,    # skewness, kurtosis
       rollsem,                       # standard error of the mean
       rollmad,                       # mean absolute deviation
       rollmad_normalized,            # mean absolute deviation for normal data
       rollvariation,                 # coefficient of variation
       running,                       #      tapering versions
       runmin,  runmax,               # min, max
       runmean, runmedian,            # mean, median
       runvar,  runstd,               # variance, standard deviation
       runskewness, runkurtosis,      # skewness, kurtosis
       runsem,                        # standard error of the mean
       runmad,                        # mean absolute deviation
       runmad_normalized,             # mean absolute deviation for normal data
       runvariation,                  # coefficient of variation
                                      # with two data vectors
       rollcor, rollcov,
       runcor, runcov
 
using LinearAlgebra: normalize

using Statistics: mean, median, std, var, cor, cov
using StatsBase:  kurtosis, mad, sem, skewness, variation,
                  AbstractWeights, Weights,
                  FrequencyWeights, AnalyticWeights, ProbabilityWeights
       
include("roll/rolling.jl")
include("run/running.jl")
include("support.jl")
include("roll/rollstats.jl")
include("run/runstats.jl")
include("roll/rolling2.jl")
include("run/running2.jl")

end # RollingFunctions
