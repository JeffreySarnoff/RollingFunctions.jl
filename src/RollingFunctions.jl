module RollingFunctions.jl

export RollControl, rolling, rolling_ahead, rolling_behind, rolling_first, rolling_final

const Rollable = AbstractVector{T} where T
const Runnable = AbstractArray{T}  where T

struct RollControl
    keep_length::Bool
    taiper_ends::Bool
    look_ahead::Bool      #  ahead && around is around (even n extra obs after midpoint)
    look_around::Bool     # !ahead && around is around (even n extra obsbefore midpoint)
end

RollControl() = RollControl(true, false, true, false)
RollControl(tf::Bool) = RollControl(tf, tf, true, false)


include("rolling.jl")
include("running.jl")


end # module
