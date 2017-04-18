module RollingFunctions

export roll_minimum, roll_maximum, roll_mean, 
       roll_std, roll_var, roll_mad,
       roll_minimum_filled, roll_maximum_filled, roll_mean_filled, 
       roll_std_filled, roll_var_filled, roll_mad_filled,
       roll_minimum_tapered, roll_maximum_tapered, roll_mean_tapered,
       rolling, rolling_fill_first, rolling_fill_last, rolling_taper_first, rolling_taper_last,
       FILL_NONE, FILL_FIRST, FILL_LAST, FILL_BOTH, TAPER_FIRST, TAPER_LAST, TAPER_BOTH
       
using StatsBase

const FILL_NONE = Val{:FILL_NONE}
const FILL_FIRST = Val{:FILL_FIRST}
const FILL_LAST  = Val{:FILL_LAST}
const FILL_BOTH  = Val{:FILL_BOTH}
const TAPER_FIRST = Val{:TAPER_FIRST}
const TAPER_LAST  = Val{:TAPER_LAST}
const TAPER_BOTH  = Val{:TAPER_BOTH}

rolling{T}(::Type{FILL_NONE}, fn::Function, span::Int, data::Vector{T}) =
    rolling(fn, span, data)

rolling{T}(::Type{FILL_FIRST}, fn::Function, span::Int, data::Vector{T}) =
    rolling_fill_first(fn, span, data)
rolling{T}(::Type{FILL_LAST}, fn::Function, span::Int, data::Vector{T}) =
    rolling_fill_last(fn, span, data)
rolling{T}(::Type{FILL_BOTH}, fn::Function, span::Int, data::Vector{T}) =
    rolling_fill_both(fn, span, data)

rolling{T}(::Type{FILL_FIRST}, fn::Function, span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(fn, span, filler, data)
rolling{T}(::Type{FILL_LAST}, fn::Function, span::Int, filler::T, data::Vector{T}) =
    rolling_fill_last(fn, span, filler, data)
rolling{T}(::Type{FILL_BOTH}, fn::Function, span::Int, filler::T, data::Vector{T}) =
    rolling_fill_both(fn, span, filler, data)

rolling{T}(::Type{TAPER_FIRST}, fn::Function, span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(fn, span,  tapered_span, data)
rolling{T}(::Type{TAPER_LAST}, fn::Function, span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_last(fn, span,  tapered_span, data)
rolling{T}(::Type{TAPER_BOTH}, fn::Function, span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_both(fn, span,  tapered_span, data)


include("rolling.jl")
include("running.jl")

end # module
