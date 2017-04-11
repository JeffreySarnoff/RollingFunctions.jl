module RollingFunctions

export rollminimum, rollmaximum
       rollmedian, rollmode, rollmean, rollstd, rollvar,
       # constructive
       Roller, rolling, runner,
       fillin_first, fillin_last, fillin_firstlast, fillin_center,
       FillNoPart, FillFirstPart, FillLastPart, FillBothParts,
       FillWithNothing, FillWithRepeated, FillWithTapered
       
       
using StatsBase

struct FillThisPart{T} end
FillNoPart    = FillThisPart{Val{:FillNoPart}}
FillFirstPart = FillThisPart{Val{:FillFirstPart}}
FillLastPart  = FillThisPart{Val{:FillLastPart}}
FillBothParts = FillThisPart{Val{:FillBothParts}}

struct FilWith{T} end
FillWithNothing  = FillWith{Val{:FillWithNothing}}
FillWithRepeated = FillWith{Val{:FillWithRepeated}}
FillWithTapered  = FillWith{Val{:FillWithTapered}}



struct DataFiller
    filled::Bool
    fillin::Sy
end

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
