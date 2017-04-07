module RollingFunctions

export rollminimum, rollmaximum, rollspan,
       rollmedian, rollmode, rollmean, rollstd, rollvar,
       Roller, rolling, runner,
       rolling_backfill, rolling_forwardfill, rolling_centerfill
       
       
using StatsBase


struct Roller
    roll::Function
    apply::Function
end

function runner(roller::Roller, span::Int, data::Vector{T}) where T<:Number
    roller.roll(roller.apply, span, data)
end


include("rolling.jl")
include("running.jl")

end # module
