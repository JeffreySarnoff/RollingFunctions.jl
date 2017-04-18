roll_minimum{T}(span::Int, data::Vector{T}) =
    rolling(minimum, span, data)
roll_minimum_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(minimum, span, filler, data)
roll_minimum_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(minimum, span, tapered_span, data)

roll_maximum{T}(span::Int, data::Vector{T}) =
    rolling(maximum, span, data)
roll_maximum_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(maximum, span, filler, data)
roll_maximum_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(maximum, span, tapered_span, data)

roll_mean{T}(span::Int, data::Vector{T}) =
    rolling(mean, span, data)
roll_mean_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(mean, span, filler, data)
roll_mean_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(mean, span, tapered_span, data)

roll_std{T}(span::Int, data::Vector{T}) =
    rolling(std, span, data)
roll_std_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(std, span, filler, data)
roll_std_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(std, span, tapered_span, data)

roll_var{T}(span::Int, data::Vector{T}) =
    rolling(var, span, data)
roll_var_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(var, span, filler, data)
roll_var_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(var, span, tapered_span, data)

roll_mad{T}(span::Int, data::Vector{T}) =
    rolling(mad, span, data)
roll_mad_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(mad, span, filler, data)
roll_mad_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(mad, span, tapered_span, data)
