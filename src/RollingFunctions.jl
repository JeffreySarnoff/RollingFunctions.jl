module RollingFunctions

export rollminimum, rollmaximum
       rollmedian, rollmode, rollmean, rollstd, rollvar,
       # constructive
       Roller, rolling, runner,
       fillin_first, fillin_last, fillin_firstlast, fillin_center,
       FillNoPart, FillFirstPart, FillLastPart, FillBothParts,
       FillWithNothing, FillWithRepeated, FillWithTapered
       
       
using StatsBase

abstract type AbstractFill end
abstract type AbstractFillPart <: AbstractFill end
abstract type AbstractFillWith <: AbstractFill end

struct FillNoPart    <: AbstractFillPart end
struct FillFirstPart <: AbstractFillPart end
struct FillLastPart  <: AbstractFillPart end
struct FillBothParts <: AbstractFillPart end

struct FillWithNothing  <: AbstractFillWith end
struct FillWithRepeated <: AbstractFillWith end
struct FillWithTapered  <: AbstractFillWith end

const NoPart    = FillNoPart()
const FirstPart = FillFirstPart()
const LastPart  = FillLastPart()
const BothParts = FillBothParts()

const WithNothing  = FillWithNothing()
const WithRepeated = FillWithRepeated()
const WithTapered  = FillWithTapered()




struct Filler{FP, FW} where FP<:AbstractFillPart where FW<:AbstractFillWith
    part::FP
    with::FW
end

fillpart{FP, FW}(x::Filler{FP, FW}) = FP
fillwith{FP, FW}(x::Filler{FP, FW}) = FW

struct FillThisPart{T} end
FillNoPart    = FillThisPart{Val{:FillNoPart}}
FillFirstPart = FillThisPart{Val{:FillFirstPart}}
FillLastPart  = FillThisPart{Val{:FillLastPart}}
FillBothParts = FillThisPart{Val{:FillBothParts}}

struct FillWith{T} end
FillWithNothing  = FillWith{Val{:FillWithNothing}}
FillWithRepeated = FillWith{Val{:FillWithRepeated}}
FillWithTapered  = FillWith{Val{:FillWithTapered}}


struct Filler{P, W}
    part::Type{FillThisPart{P}}
    with::Type{FillWith{W}}
end

Filler() = Filler{FillNoPart, FillWithNothing}
Filler(FillNoPart) = Filler()
Filler(FillWithNothing) = Filler()
Filler(FillThisPart, FillWithNothing) = Filler()
Filler(FillNoPart, FillWith) = Filler()

Base.show{P,W}(io::IO, x::Filler{P,W}) = show(io, (x.part, x.with))
Base.show{P,W}(io::IO, x::Filler{P,W}) = show(io, (x.part, x.with))


struct Roller
    apply::Function
    spans::Int64
    filled::Bool
    
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
