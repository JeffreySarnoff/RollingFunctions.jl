module RollingFunctions

using Base: @kwdef

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

using KahanSummation: sum_kbn
using AccurateArithmetic: sum_oro

using LoopVectorization

const Sequence = Union{Vec, Tup} where {N, T, Vec<:AbstractVector{T}, Tup<:NTuple{N,T}}

include("support/utils.jl")
include("support/normalize_weights.jl")

# support for data vectors and 
# data matrices of independent columns
include("roll/base_padded.jl")  
# support for data matrices of dependent columns
include("roll/multicolumn_base_padded.jl")


#=
include("roll/rolling.jl")
include("run/running.jl")
include("roll/rollstats.jl")
include("run/runstats.jl")
include("roll/rolling2.jl")
include("run/running2.jl")
=#

end # RollingFunctions

