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

abstract type AbstractDataFiller{T} end
abstract type CarriesFromFirst{T}   <: AbstractDataFiller{T} end
abstract type CarriesFromNearest{T} <: AbstractDataFiller{T} end
abstract type CarriesFromFinal{T}   <: AbstractDataFiller{T} end


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


function roll{FW,T}(roller::Roller{FillNoPart, FW}, data::Vector{T})
    return rolling(roller.rolling, roller.rollspan, data)
end
function roll{FP,T}(roller::Roller{FP, FillWithNothing}, data::Vector{T})
    return rolling(roller.rolling, roller.rollspan, data)
end

function roll{T}(roller::Roller{FillFirstPart, FillWithRepeated}, data::Vector{T})
    return rolling_fill_first(roller.rolling, roller.rollspan, data)
end
function roll{T}(roller::Roller{FillLastPart, FillWithRepeated}, data::Vector{T})
    return rolling_fill_last(roller.rolling, roller.rollspan, data)
end
function roll{T}(roller::Roller{FillBothParts, FillWithRepeated}, data::Vector{T})
    return rolling_fill_both(roller.rolling, roller.rollspan, data)
end


include("rolling.jl")
include("running.jl")

end # module
