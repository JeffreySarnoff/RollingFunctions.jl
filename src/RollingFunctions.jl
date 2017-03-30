module RollingFunctions

export running_minimum, running_maximum, running_span,
       running_median, running_mode, running_mean, running_geomean, running_harmmean,
       running_variation, running_sem, runnning_mad, running_entropy,
       AbstractRoller, Roller, Runner, 
       FullSpansRoller, FirstSpansRoller, FinalSpansRoller

using StatsBase

abstract type AbstractRoller{T} end

struct Roller{T} <: AbstractRoller{T}
    fn::Function
    span::Int64
end

const FullSpansRoller  = Roller{Val{:full}}    # use only completely spanned values (shorter result)
const FirstSpansRoller = Roller{Val{:first}}   # final values are spanned coarsely  (equilength result, tapering at end)
const FinalSpansRoller = Roller{Val{:final}}   # first values are spanned coarsely  (equilength result, tapering at start)


struct Runner{T, R} <: AbstractRoller{T}
    roll::Roller{T}
end

function Runner{R}(roll::FullSpansRoller, data::Vector{R})
    rolling(roll.fn, roll.span, data)
end

function Runner{R}(roll::FirstSpansRoller, data::Vector{R})
    rolling_start(roll.fn, roll.span, data)
end

function Runner{R}(roll::FinalSpansRoller, data::Vector{R})
    rolling_finish(roll.fn, roll.span, data)
end


include("rolling.jl")
include("running.jl")

end # module
