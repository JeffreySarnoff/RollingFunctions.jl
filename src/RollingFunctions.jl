module RollingFunctions.jl

export RollControl, rolling, rolling_ahead, rolling_behind, rolling_first, rolling_final

const Rollable = AbstractVector{T} where T
const Runnable = AbstractArray{T}  where T

"""
    roller{**S**}( fn, data )    

    A cannonical rolling function, it applies 
      fn to contiguous data subsbans of extent **S**.
"""
function roller{S}( ::Type{Val{S}}, fn::Function, data::AbstractArray ) 
    rolling( fn, S, data )
end    

roll20(fn, data) = roller(Val{20}, fn, data)
roll5(fn, data) = roller(Val{5}, fn, data)


struct RollControl
    keep_length::Bool
    taiper_ends::Bool
    look_ahead::Bool     #  about && around is around (even n extra obs after midpoint)
    look_about::Bool     # !about && around is around (even n extra obsbefore midpoint)
end

RollControl() = RollControl(true, false, true, false)
RollControl(tf::Bool) = RollControl(tf, tf, true, false)


include("rolling.jl")
include("running.jl")


end # module
