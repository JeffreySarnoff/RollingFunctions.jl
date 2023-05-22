using RollingFunctions
using Statistics
using StatsBase
using LinearAlgebra
using Test

clean(x) = x
clean(x::Missing) = Missing

include("wholesparts.jl")

include("roll/roll.jl")
include("roll/roll_vectors.jl")
include("roll/roll_weighted_vectors.jl")
include("roll/roll_matrix.jl")
include("roll/roll_stats.jl")

include("tile/tile_vectors.jl")
include("tile/tile_weighted_vectors.jl")
include("tile/tile_matrix.jl")

#=
include("tile/tile.jl")
include("tile/tile_stats.jl")
=#

include("run/run_vectors.jl")
include("run/run_weighted_vectors.jl")
include("run/run_matrix.jl")

#=

include("run/run.jl")
include("run/run_stats.jl")
=#
