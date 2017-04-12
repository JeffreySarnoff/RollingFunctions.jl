module RollingFunctions

export rollminimum, rollmaximum
       rollmedian, rollmode, rollmean, rollstd, rollvar

#= constructive
export Roller, rolling, runner,
       fillin_first, fillin_last, fillin_firstlast, fillin_center,
       FillNoPart, FillFirstPart, FillLastPart, FillBothParts,
       FillWithNothing, FillWithNaNs, FillWithRepeated, FillWithTapered
=#       
       
using StatsBase

abstract type AbstractFill end
abstract type AbstractFillPart <: AbstractFill end
abstract type AbstractFillWith <: AbstractFill end

struct FillNoPart    <: AbstractFillPart end
struct FillFirstPart <: AbstractFillPart end
struct FillLastPart  <: AbstractFillPart end
struct FillBothParts <: AbstractFillPart end

struct FillWithNothing  <: AbstractFillWith end
struct FillWithNaN      <: AbstractFillWith end
struct FillWithNullable <: AbstractFillWith end
struct FillWithRepeated <: AbstractFillWith end
struct FillWithTapered  <: AbstractFillWith end

const NoPart    = FillNoPart()
const FirstPart = FillFirstPart()
const LastPart  = FillLastPart()
const BothParts = FillBothParts()

const WithNothing  = FillWithNothing()
const WithNaN      = FillWithNaN()
const WithNullable = FillWithNullable()
const WithRepeated = FillWithRepeated()
const WithTapered  = FillWithTapered()

struct Roller{FP, FW}  
    fillpart::FP             # {NoPart, FirstPart, LastPart, BothParts}
    fillwith::FW             # {WithNothing, WithNaN, WithNullable, WithRepeated, WithTapered}
    rolling::Function        # statistical function of vector subsequence
    rollspan::Int            # vector subsequence length    
end


function roll{T}(roller::Roller{FillFirstPart, FillWithRepeated}, data::Vector{T})
    return rolling_fill_first(roller.rolling, roller.rollspan, data)
end

#=
function roll{T}(roller::Roller{FillFirstPart, FillWithRepeated}, data::Vector{T})
    return rolling_fill_first(roller.rolling, roller.rollspan, data)
end

r2=Roller(FirstPart,WithRepeated,mean,5)
data=map(Float64,collect(1:8:100))
result=roll(r2,data)
=#

function roll{FW,T}(roller::Roller{NoPart,FW}, data::Vector{T})
       return rolling(roller.rolling, roller.span, data)
end
function roll{FP,T}(roller::Roller{FP, WithNothing}, data::Vector{T})
       return rolling(roller.rolling, roller.span, data)
end
function roll{T}(roller::Roller{FirstPart, WithRepeated}, data::Vector{T})
       return rolling_fill_first(roller.rolling, roller.span, data)
end
function roll{T}(roller::Roller{LastPart, WithRepeated}, data::Vector{T})
       return rolling_fill_last(roller.rolling, roller.span, data)
end


include("rolling.jl")
include("running.jl")

end # module
