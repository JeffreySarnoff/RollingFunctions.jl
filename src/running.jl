for (F,R) in [(:minimum, :roll_minimum), (:maximum, :roll_maximum), 
              (:mean, :roll_mean), (:median, :roll_median),
              (:std, :roll_std), (:var, :roll_var), (:mad, :roll_mad),
              (:sum, :roll_sum), (:prod, :roll_prod), (:norm, :roll_norm)]
    @eval begin
        $R(span::Int, data::Vector{T}) where {T} = rolling($F, span, data)
        $R(span::Int, weights::Vector{T}, data::Vector{T}) where {T} = rolling($F, span, weights, data)
        $R(::Type{FILL_FIRST}, span::Int, data::Vector{T}) where {T} =
            rolling(FILL_FIRST, $F, span, data)
        $R(::Type{FILL_LAST},  span::Int, data::Vector{T}) where {T} =
            rolling(FILL_LAST,  $F, span, data)
        $R(::Type{FILL_BOTH},  span::Int, data::Vector{T}) where {T} =
            rolling(FILL_BOTH,  $F, span, data)
        $R(::Type{FILL_FIRST}, span::Int, filler::T, data::Vector{T}) where {T} =
            rolling(FILL_FIRST, $F, span, filler, data)
        $R(::Type{FILL_LAST},  span::Int, filler::T, data::Vector{T}) where {T} =
            rolling(FILL_LAST,  $F, span, filler, data)
        $R(::Type{FILL_BOTH},  span::Int, filler::T, data::Vector{T}) where {T} =
            rolling(FILL_BOTH,  $F, span, filler, data)
        $R(::Type{TAPER_FIRST}, span::Int, tapered_span::Int, data::Vector{T}) where {T} =
            rolling(TAPER_FIRST, $F, span, tapered_span, data)
        $R(::Type{TAPER_LAST},  span::Int, tapered_span::Int, data::Vector{T}) where {T} =
           rolling(TAPER_LAST,  $F, span, tapered_span, data)
        $R(::Type{TAPER_BOTH},  span::Int, tapered_span::Int, data::Vector{T}) where {T} = 
           rolling(TAPER_BOTH,  $F, span, tapered_span, data)                
    end
end
