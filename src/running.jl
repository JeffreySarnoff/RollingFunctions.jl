for (F,R) in [(:minimum, :roll_minimum), (:maximum, :roll_maximum), (:mean, :roll_mean),
              (:std, :roll_std), (:var, :roll_var), (:mad, :roll_mad)]
    @eval begin
             $R{T}(span::Int, data::Vector{T}) = rolling($F, span, data)
             $R{T}(::Type{FILL_FIRST}, span::Int, data::Vector{T}) =
                 rolling(FILL_FIRST, $F, span, data)
             $R{T}(::Type{FILL_LAST},  span::Int, data::Vector{T}) =
                 rolling(FILL_LAST,  $F, span, data)
             $R{T}(::Type{FILL_BOTH},  span::Int, data::Vector{T}) =
                 rolling(FILL_BOTH,  $F, span, data)
             $R{T}(::Type{FILL_FIRST}, span::Int, filler::T, data::Vector{T}) =
                 rolling(FILL_FIRST, $F, span, filler, data)
             $R{T}(::Type{FILL_LAST},  span::Int, filler::T, data::Vector{T}) =
                 rolling(FILL_LAST,  $F, span, filler, data)
             $R{T}(::Type{FILL_BOTH},  span::Int, filler::T, data::Vector{T}) =
                 rolling(FILL_BOTH,  $F, span, filler, data)
             $R{T}(::Type{TAPER_FIRST}, span::Int, tapered_span::Int, data::Vector{T}) =
                 rolling(TAPER_FIRST, $F, span, tapered_span, data)
             $R{T}(::Type{TAPER_LAST},  span::Int, tapered_span::Int, data::Vector{T}) =
                 rolling(TAPER_LAST,  $F, span, tapered_span, data)
             $R{T}(::Type{TAPER_BOTH},  span::Int, tapered_span::Int, data::Vector{T}) = 
                 rolling(TAPER_BOTH,  $F, span, tapered_span, data)                
          end 
    end
end


#=
roll_minimum{T}(span::Int, data::Vector{T}) =
    rolling(minimum, span, data)
roll_minimum{T}(::Type{FILL_FIRST}, span::Int, data::Vector{T}) =
    rolling(FILL_FIRST, minimum, span, data)
roll_minimum{T}(::Type{FILL_LAST}, span::Int, data::Vector{T}) =
    rolling(FILL_LAST, minimum, span, data)
roll_minimum{T}(::Type{FILL_BOTH}, span::Int, data::Vector{T}) =
    rolling(FILL_BOTH, minimum, span, data)
roll_minimum{T}(::Type{TAPER_FIRST}, span::Int, tapered_span::Int, data::Vector{T}) =
    rolling(TAPER_FIRST, minimum, span, tapered_span, data)
roll_minimum{T}(::Type{TAPER_LAST}, span::Int, tapered_span::Int, data::Vector{T}) =
    rolling(TAPER_LAST, minimum, span, tapered_span, data)
roll_minimum{T}(::Type{TAPER_BOTH}, span::Int, tapered_span::Int, data::Vector{T}) =
    rolling(TAPER_BOTH, minimum, span, tapered_span, data)

roll_maximum{T}(span::Int, data::Vector{T}) =
    rolling(maximum, span, data)
roll_maximum_filled{T}(span::Int, data::Vector{T}) =
    rolling_fill_first(maximum, span, data)
roll_maximum_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(maximum, span, filler, data)
roll_maximum_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(maximum, span, tapered_span, data)

roll_mean{T}(span::Int, data::Vector{T}) =
    rolling(mean, span, data)
roll_mean_filled{T}(span::Int, data::Vector{T}) =
    rolling_fill_first(mean, span, data)
roll_mean_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(mean, span, filler, data)
roll_mean_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(mean, span, tapered_span, data)

roll_std{T}(span::Int, data::Vector{T}) =
    rolling(std, span, data)
roll_std_filled{T}(span::Int, data::Vector{T}) =
    rolling_fill_first(std, span, data)
roll_std_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(std, span, filler, data)
roll_std_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(std, span, tapered_span, data)

roll_var{T}(span::Int, data::Vector{T}) =
    rolling(var, span, data)
roll_var_filled{T}(span::Int, data::Vector{T}) =
    rolling_fill_first(var, span, data)
roll_var_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(var, span, filler, data)
roll_var_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(var, span, tapered_span, data)

roll_mad{T}(span::Int, data::Vector{T}) =
    rolling(mad, span, data)
roll_mad_filled{T}(span::Int, data::Vector{T}) =
    rolling_fill_first(mad, span, data)
roll_mad_filled{T}(span::Int, filler::T, data::Vector{T}) =
    rolling_fill_first(mad, span, filler, data)
roll_mad_tapered{T}(span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_first(mad, span, tapered_span, data)
=#
