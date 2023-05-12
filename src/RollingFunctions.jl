module RollingFunctions

using Base: @kwdef

export rolling, tiling,
       # functions using VectorizedStatistics
       rollmin, rollmax, rollmean, rollsum,
       rollvar, rollstd, rollcor, rollcov

export rolling,
       rollmin, rollmax,             # min, max
       rollmean, rollmedian,          # mean, median
       rollvar, rollstd,             # variance, standard deviation
       rollskewness, rollkurtosis,    # skewness, kurtosis
       rollsem,                       # standard error of the mean
       rollmad,                       # mean absolute deviation
       rollmad_normalized,            # mean absolute deviation for normal data
       rollvariation,                 # coefficient of variation
       running,                       #      tapering versions
       runmin, runmax,               # min, max
       runmean, runmedian,            # mean, median
       runvar, runstd,               # variance, standard deviation
       runskewness, runkurtosis,      # skewness, kurtosis
       runsem,                        # standard error of the mean
       runmad,                        # mean absolute deviation
       runmad_normalized,             # mean absolute deviation for normal data
       runvariation,                  # coefficient of variation
       # with two data vectors
       rollcor, rollcov,
       runcor, runcov,
       wholesparts

using LinearAlgebra: normalize

using Statistics: mean, median, std, var, cor, cov
using StatsBase: kurtosis, mad, sem, skewness, variation,
       AbstractWeights, Weights,
       FrequencyWeights, AnalyticWeights, ProbabilityWeights
using VectorizedStatistics

using KahanSummation: sum_kbn
using AccurateArithmetic: sum_oro

include("inlinedocs.jl")

include("support/types.jl")
include("support/exceptions.jl")
include("support/utils.jl")

include("support/normalize_weights.jl")
include("support/tapers.jl")

include("roll/roll.jl")
include("roll/roll_vectors.jl")
include("roll/roll_weighted_vectors.jl")
include("roll/roll_matrix.jl")
include("roll/roll_stats.jl")
include("roll/roll_tupled_vectors.jl")


include("tile/tile.jl")
include("tile/tile_vectors.jl")
include("tile/tile_weighted_vectors.jl")
include("tile/tile_matrix.jl")
include("tile/tile_stats.jl")


include("run/run.jl")
include("run/run_vectors.jl")
include("run/run_weighted_vectors.jl")
# include("run/run_matrix.jl")
include("run/run_stats.jl")


end # RollingFunctions

