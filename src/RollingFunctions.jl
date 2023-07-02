module RollingFunctions

export rolling, tiling, running,
       rollmin, rollmax, rollextrema,
       rollsum, rollmean, rollvar, rollstd, 
       rollcor, rollcov,
       tilemin, tilemax, tileextrema,
       tilesum, tilemean, tilevar, tilestd,
       tilecor, tilecov,
       runmin, runmax, runextrema,
       runsum, runmean, runvar, runstd, 
       runcor, runcov


#=
export rolling, running, tiling

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
       runcor, runcov
=#

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
include("roll/roll_tupled_vectors.jl")

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

using PrecompileTools

@setup_workload begin
  data = rand(25)
  winsize = 5
  fns = [sum, vsum, mean, vmean, vmedian, vminimum, vmaximum, vstd, vvar]
  for fn in fns
       r1 = rolling(fn, winsize, data)
       r2 = running(fn, winsize, data)
       r3 = tiling(fn, winsize, data)
  end
end

end # RollingFunctions

