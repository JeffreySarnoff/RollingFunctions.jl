module RollingFunctions

export rollminimum, rollmaximum
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


struct Filling{T} end

FillNone   = Filling{Val{:none}}
FillFirst  = Filling{Val{:first}}
FillLast   = Filling{Val{:last}}
FillCenter = Filling{Val{:center}}


include("rolling.jl")
include("running.jl")

end # module
