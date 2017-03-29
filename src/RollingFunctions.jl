module RollingFunctions

export AbstractRoller, Roller, Runner, 
       RollFullSpans, RollFirstSpans, RollFinalSpans


abstract type AbstractRoller{T} end

struct Roller{T} <: AbstractRoller{T}
    fn::Function
    span::Int64
end

const RollFullSpans  = Roller{Val{:full}}    # use only completely spanned values (shorter result)
const RollFirstSpans = Roller{Val{:first}}   # final values are spanned coarsely  (equilength result, tapiring at end)
const RollFinalSpans = Roller{Val{:final}}   # first values are spanned coarsely  (equilength result, tapiring at start)


struct Runner{T, R} <: AbstractRoller{T}
    roll::Roller{T}
end

function Runner{R}(roll::RollFullSpans, data::Vector{R})
    rolling(roll.fn, roll.span, data)
end

function Runner{R}(roll::RollFirstValue, data::Vector{R})
    rolling_start(roll.fn, roll.span, data)
end

function Runner{R}(roll::RollFinalValue, data::Vector{R})
    rolling_finish(roll.fn, roll.span, data)
end


include("rolling.jl")


end # module
