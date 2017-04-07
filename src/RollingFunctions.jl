module RollingFunctions

export Roller, runner,
       rolling, rolling_backfill, rolling_forwardfill, rolling_centerfill,
       rollminimum, runmaximum, runspan,
       rollmedian, runmode, runmean,
       rollstd, runvar, 
       rollminimum_backfill, runmaximum_backfill, runspan_backfill,
       rollmedian_backfill, runmode_backfill, runmean_backfill,
       rollstd_backfill, runvar_backfill
       
using StatsBase


struct Roller
    roll::Function
    apply::Function
    span::Int64
end

function runner(roller::Roller, data::Vector{T}) where T<:Number
    roller.roll(roller.apply, roller.span, data)
end


include("rolling.jl")
include("running.jl")

end # module
