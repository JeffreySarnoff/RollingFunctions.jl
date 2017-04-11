module RollingFunctions

export rollminimum, rollmaximum, rollspan,
       rollmedian, rollmode, rollmean, rollstd, rollvar,
       # constructive
       Roller, rolling, runner,
       rolling_fill_first, rolling_fill_last, rolling_fill_center,
       FillFirst, FillLast, FillCenter
       
       
using StatsBase


struct Roller
    roll::Function
    apply::Function
end

function runner(roller::Roller, span::Int, data::Vector{T}) where T<:Number
    roller.roll(roller.apply, span, data)
end

struct FillAt{T} end

FillFirst  = FillAt{Val{:first}}
FillLast   = FillAt{Val{:last}}
FillCenter = FillAt{Val{:center}}


include("rolling.jl")
include("running.jl")

end # module
