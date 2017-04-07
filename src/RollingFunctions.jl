module RollingFunctions

export running_minimum, running_maximum, running_span,
       running_median, running_mode, running_mean, running_geomean, running_harmmean,
       running_variation, running_sem, runnning_mad, running_entropy,
       AbstractRoller, Roller, Runner, 
       FullSpansRoller, StartSpansRoller, FinishSpansRoller, FirstSpansRoller, FinalSpansRoller

using StatsBase

abstract type AbstractRoller{T} end

struct Roller{T} <: AbstractRoller{T}
    fn::Function
    span::Int64
end

const FullSpansRoller   = Roller{Val{:full}}     # use only completely spanned values (shorter result)
const StartSpansRoller  = Roller{Val{:start}}    # final values are spanned coarsely  (equilength result, tapering at end)
const FinishSpansRoller = Roller{Val{:finish}}   # first values are spanned coarsely  (equilength result, tapering at start)
const FirstSpansRoller  = Roller{Val{:first}}    # final values are filled forward   (equilength result, carrying forward at end)
const FinalSpansRoller  = Roller{Val{:final}}    # first values are filled backward   (equilength result, carrying backward at start)


struct Runner{T, R} <: AbstractRoller{T}
    roll::Roller{T}
end

function Runner{R}(roll::FullSpansRoller, data::Vector{R})
    rolling(roll.fn, roll.span, data)
end

function Runner{R}(roll::StartSpansRoller, data::Vector{R})
    rolling(roll.fn, roll.span, data)
end

function Runner{R}(roll::FinishSpansRoller, data::Vector{R})
    rolling(roll.fn, roll.span, data)
end

function Runner{R}(roll::FirstSpansRoller, data::Vector{R})
    rolling(roll.fn, roll.span, data)
end

function Runner{R}(roll::FinalSpansRoller, data::Vector{R})
    rolling(roll.fn, roll.span, data)
end

#=
for T in (:FullSpansRoller, :StartSpansRoller, :FinishSpansRoller, :FirstSpansRoller, :FinalSpansRoller)
    @eval begin
       function Runner{R}(roll::$T, data::Vector{R})
           rolling(roll.fn, roll.span, data)
       end
    end
end       
=#

include("rolling.jl")
include("running.jl")

end # module
