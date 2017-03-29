module RollingFunctions.jl

export rolling, rolling_ahead, rolling_behind, rolling_first, rolling_final

const Rollable = AbstractVector{T} where T
const Runnable = AbstractArray{T}  where T

include("rolling.jl")
include("running.jl")


end # module
