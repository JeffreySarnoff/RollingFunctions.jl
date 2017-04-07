module RollingFunctions

export Roller, runner,
       rolling, rolling_backfill, rolling_forwardfill, rolling_centerfill,
       rollminimum, rollmaximum, rollspan,
       rollmedian, rollmode, rollmean,
       rollstd, rollvar, 
       rollminimum_backfill, rollmaximum_backfill, rollspan_backfill,
       rollmedian_backfill, rollmode_backfill, rollmean_backfill,
       rollstd_backfill, rollvar_backfill
       
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
