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
                               
#=
   A is {:Initial, :Final} portion of the vector 
   B is {:Repeating, :Tapering} way to fill that portion of the vector
   C is for :Tapering, 1 tapers to a single observation, 2 tapers to two observations...
=#
abstract type AbstractDataFiller{A,B,C} end

abstract type WindowedDataFiller <: AbstractDataFiller{:Total, B, C} end

abstract type InitialRepeatingFiller <: AbstractDataFiller{:Initial, :Repeating, C} end
abstract type FinalRepeatingFiller   <: AbstractDataFiller{:Final, :Repeating, C} end

abstract type InitialTaperingFiller{C} <: AbstractDataFiller{:Initial, :Tapering, C} end
abstract type FinalTaperingFiller{C} <: AbstractDataFiller{:Final, :Tapering, C} end

struct Roll <: WindowedDataFiller
    rollfunc::Function
    rollspan::Int
end

struct RollInitialRepeating <: InitialRepeatingFiller
    rollfunc::Function
    rollspan::Int
end
struct RollFinalRepeating <: FinalRepeatingFiller
    rollfunc::Function
    rollspan::Int
end

struct RollInitialTapering{C} <: InitialTaperingFiller{C}
    rollfunc::Function
    rollspan::Int
end
struct RollFinalTapering{C} <: FinalTaperingFiller{C}
    rollfunc::Function
    rollspan::Int
end


rolling_mean(rollspan::Int) = Roll(mean, rollspan)
function rolling_mean_repeating(rollspan::Int; fill_initial::Bool=true)
    return fill_initial ? RollInitialRepeating(mean, rollspan) : RollFinalRepeating(mean, rollspan)
end
function rolling_mean_tapering(rollspan::Int; fill_initial::Bool=true, taper::Int=5)
    return fill_initial ? RollInitialTapering{taper}(mean, rollspan) : RollFinalTapering{taper}(mean, rollspan)
end
 





# orientations: fromfirst==forward, fromfinal==backward, fromnearest==closest

abstract type DataFiller{T, ORIENTATION, FILLING} <: AbstractDataFiller{T} en
       
abstract type ForwardFiller{T, FILLING} <: DataFiller{T, :forward, FILLING}  end
abstract type BackwardFiller{T, FILLING} <: DataFiller{T, :backward, FILLING}  end
abstract type BothWaysFiller{T, FILLING} <: DataFiller{T, :bothways, FILLING}  end

struct RepetitiveFiller{T, ORIENTATION} <: DataFiller{T, ORIENTATION, :repetitive} end
struct TaperedFiller{T, ORIENTATION} <: DataFiller{T, ORIENTATION, :tapered} end
struct NullableFiller{T, ORIENTATION} <: DataFiller{T, ORIENTATION, :nullable} end


abstract type CarriesFromFirst{CARRY}   <: AbstractDataFiller{CARRY, FILL} end
abstract type CarriesFromNearest{CARRY} <: AbstractDataFiller{CARRY, FILL} end
abstract type CarriesFromFinal{CARRY}   <: AbstractDataFiller{CARRY, FILL} end

abstract type FillsWithNothing{FILL}   <: AbstractDataFiller{CARRY, FILL} end
abstract type FillsWithNearest{FILL}   <: AbstractDataFiller{CARRY, FILL} end
       

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
