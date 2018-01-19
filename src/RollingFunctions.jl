__precompile__()

module RollingFunctions

export roll_minimum, roll_maximum, 
       roll_mean, roll_median,
       roll_std, roll_var, roll_mad, 
       roll_sum, roll_prod, roll_norm,
       rolling, 
       FILL_FIRST, FILL_LAST, FILL_BOTH,
       TAPER_FIRST, TAPER_LAST, TAPER_BOTH
       
import Base.Dates:TimeType
using StatsBase

try
    missing
    using Missings
    using Dates
    import Dates: AbstractType
catch
    try
        using Missings
        using Base.Dates
        import Base.Dates: AbstractType
    catch
        throw(ErrorException("To use RollingFunctions with ver0.6, `Pkg.add(\"Missings\")`."))
    end
end

const MaybeNumber    = Union{Missing, Number}
const MaybeTime      = Union{Missing, AbstractTime}
const MaybeAkoNumber = Union{Missing, T} where T<:Number
const MaybeAkoTime   = Union{Missing, T} where T<:AbstractTime

const FILL_FIRST = Val{:FILL_FIRST}
const FILL_LAST  = Val{:FILL_LAST}
const FILL_BOTH  = Val{:FILL_BOTH}

const TAPER_FIRST = Val{:TAPER_FIRST}
const TAPER_LAST  = Val{:TAPER_LAST}
const TAPER_BOTH  = Val{:TAPER_BOTH}

include("rolling.jl")
include("running.jl")

end # module
