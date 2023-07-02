module RollingFunctions

export rolling, tiling, running,
       rollmin, rollmax, rollextrema,
       rollmean, rollmedian,
       rollsum, rollvar, rollstd,
       rollskewness, rollkurtosis,
       rollcor, rollcov,
       tilemin, tilemax, tileextrema,
       tilemean, tilemedian,
       tilesum, tilevar, tilestd,
       tileskewness, tilekurtosis,
       tilecor, tilecov,
       runmin, runmax, runextrema,
       runmean, runmedian,
       runsum, runvar, runstd,
       runskewness, runkurtosis,
       runcor, runcov


#=
old version also exports

       rollsem,                       # standard error of the mean
       rollmad,                       # mean absolute deviation
       rollmad_normalized,            # mean absolute deviation for normal data
       rollvariation,                 # coefficient of variation
       runsem,                        # standard error of the mean
       runmad,                        # mean absolute deviation
       runmad_normalized,             # mean absolute deviation for normal data
       runvariation,                  # coefficient of variation
=#

using Base: @constprop, @propagate_inbounds, @_inline_meta

using LinearAlgebra: norm, normalize

using StatsBase: mean, median, std, var, cor, cov,
       kurtosis, mad, sem, skewness, variation,
       AbstractWeights, Weights,
       FrequencyWeights, AnalyticWeights, ProbabilityWeights

using VectorizedStatistics

include("support/types.jl")
include("support/exceptions.jl")
include("support/utils.jl")
include("support/vecmat_weights.jl")

include("roll/rolling.jl")
include("roll/roll_vectors.jl")
include("roll/roll_weighted_vectors.jl")
include("roll/roll_matrix.jl")
include("roll/roll_stats.jl")

include("tile/tiling.jl")
include("tile/tile_vectors.jl")
include("tile/tile_weighted_vectors.jl")
include("tile/tile_matrix.jl")
include("tile/tile_stats.jl")

include("run/running.jl")
include("run/run_vectors.jl")
include("run/run_weighted_vectors.jl")
include("run/run_matrix.jl")
include("run/run_stats.jl")

include("inlinedocs.jl")
include("deprecated.jl")

end # RollingFunctions

