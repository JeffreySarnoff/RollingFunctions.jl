module RollingFunctions

export rollminimum, rollmaximum, rollspan,
       rollmedian, rollmode, rollmean, rollstd, rollvar,
       Roller, rolling, runner,
       rolling_backfill, rolling_forwardfill, rolling_centerfill,
       AtFirst, AtLast, AtBoth
       
       
using StatsBase


struct Roller
    roll::Function
    apply::Function
end

function runner(roller::Roller, span::Int, data::Vector{T}) where T<:Number
    roller.roll(roller.apply, span, data)
end

struct FillAt{T} end

AtFirst = FillAt{Val{:first}}
AtLast  = FillAt{Val{:last}}
AtBoth  = FillAt{Val{:both}}


include("rolling.jl")
include("running.jl")

end # module
