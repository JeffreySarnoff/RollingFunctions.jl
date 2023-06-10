using RollingFunctions
using Statistics
using StatsBase
using LinearAlgebra
using Test

clean(x) = x
clean(x::Missing) = Missing

include("wholesparts.jl")

include("roll/rolling.jl")
include("roll/roll_vectors.jl")
include("roll/roll_weighted_vectors.jl")
include("roll/roll_matrix.jl")
include("roll/roll_stats.jl")

include("tile/tile_vectors.jl")
include("tile/tile_weighted_vectors.jl")
include("tile/tile_matrix.jl")

#=
include("tile/tiling.jl")
include("tile/tile_stats.jl")
=#

include("run/run_vectors.jl")
include("run/run_weighted_vectors.jl")
include("run/run_matrix.jl")

#=

include("run/running.jl")
include("run/run_stats.jl")
=#
