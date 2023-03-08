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

for T in (:Int8, :Int16, :Int32, :Int64, :Int128,
          :UInt8, :UInt16, :UInt32, :UInt64, :UInt128,
          :Float16, :Float32, :Float64)
  @eval LoopVectorization.check_args(x::Union{Missing,$T}) = true
end

const Seq = Union{V, NT} where {N, T, V<:AbstractVector{T}, NT<:NTuple{N,T}}
seq(x::AbstractVector{T}) where {T} = x
seq(x::NTuple{N,T}) where {N,T} = x

include("support/exceptions.jl")
include("support/utils.jl")
include("support/normalize_weights.jl")

include("roll/roll.jl")
include("roll/rollvectors.jl")
include("roll/rollvectors_weighted.jl")
include("roll/rollmatrix.jl")
include("roll/rollstats.jl")

include("support/tapers.jl")
include("run/run.jl")
include("run/runvectors.jl")
include("run/runvectors_weighted.jl")
include("run/runmatrix.jl")
include("run/runstats.jl")


end # RollingFunctions

