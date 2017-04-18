rolling_minimum{T}(span::Int, data::Vector{T}) =
    rolling(minimum, span, data)
rolling_minimum_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(minimum, span, filler, data)
rolling_minimum_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(minimum, span, tapered_span, data)

rolling_maximum{T}(span::Int, data::Vector{T}) =
    rolling(maximum, span, data)
rolling_maximum_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(maximum, span, filler, data)
rolling_maximum_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(maximum, span, tapered_span, data)

rolling_mean{T}(span::Int, data::Vector{T}) =
    rolling(mean, span, data)
rolling_mean_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(mean, span, filler, data)
rolling_mean_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(mean, span, tapered_span, data)

rolling_mean{T}(span::Int, data::Vector{T}) =
    rolling(mean, span, data)
rolling_mean_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(mean, span, filler, data)
rolling_mean_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(mean, span, tapered_span, data)

rolling_median{T}(span::Int, data::Vector{T}) =
    rolling(mean, span, data)
rolling_median_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(median, span, filler, data)
rolling_median_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(median, span, tapered_span, data)

rolling_std{T}(span::Int, data::Vector{T}) =
    rolling(std, span, data)
rolling_std_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(std, span, filler, data)
rolling_std_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(std, span, tapered_span, data)

rolling_var{T}(span::Int, data::Vector{T}) =
    rolling(var, span, data)
rolling_var_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(var, span, filler, data)
rolling_var_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(var, span, tapered_span, data)

rolling_mad{T}(span::Int, data::Vector{T}) =
    rolling(mad, span, data)
rolling_mad_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(mad, span, filler, data)
rolling_mad_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(mad, span, tapered_span, data)
