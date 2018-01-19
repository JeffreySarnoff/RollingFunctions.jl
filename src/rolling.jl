"""
rolling(fn, span, data)
rolling(fn, weights, data)

This rolls by applying fn to successive data sub-spans.

`length(result) == length(data) - span + 1`
"""
function rolling(fn::Function, span::S, data::V) where
                {S<:Signed, T<:MaybeNumber, V<:AbstractVector{T}}
    n_in  = length(data)
    (span > 1 && n_in >= span) || throw(span_error(n_in, span))

    n_out = n_in - span + 1
    result = zeros(T, n_out)

    span = span - 1     
    for i in 1:n_out
        @inbounds result[i] = fn(view(data, i:i+span))
    end
    
    return result
end

function rolling(fn::Function, span::S, data::A) where
                {S<:Signed, N, T<:MaybeNumber, A<:AbstractArray{T,N}}
    n_rows_in, n_cols  = size(data)
    (span > 1 && n_rows_in >= span) || throw(span_error(n_rows_in, span))

    n_rows_out = n_rows_in - span + 1
    result = zeros(Array{T, N}(n_rows_out, n_cols))

    span = span - 1
    for colidx in 1:n_cols    
        for i in 1:n_rows_out
            @inbounds result[i, colidx] = fn(view(data, i:i+span, colidx))
         end         
     end
           
     return result
end

function rolling(fn::Function, weights::V, data::V) where
                {T<:MaybeNumber, V<:AbstractVector{T}}
    n_in  = length(data)
    span  = length(weights)
    (span > 1 && n_in >= span)  || throw(span_error(n_in, span))
    (length(weights) == span)   || throw(weights_error(length(weights), span))

    n_out = n_in - span + 1
    result = zeros(T, n_out)

    span = span - 1     
    for i in 1:n_out
        @inbounds result[i] = fn(data[i:i+span] .* weights)
    end

    return result
end

function rolling(fn::Function, weights::V, data::A) where
                {N, T<:MaybeNumber, A<:AbstractArray{T,N}}
    n_rows_in, n_cols  = size(data)
    span = length(weights)
    (span > 1 && n_rows_in >= span) || throw(span_error(n_rows_in, span))

    n_rows_out = n_rows_in - span + 1
    result = zeros(Array{T, N}(n_rows_out, n_cols))

    span = span - 1
    for colidx in 1:n_cols    
        for i in 1:n_rows_out
            @inbounds result[i, colidx] = fn(view(data, i:i+span, colidx) .* weights)
         end         
     end
           
     return result
end



function rolling(fn::Function, span::S, times::D, data::V) where
                {S<:Signed, N, T<:MaybeTime, D<:AbstractVector{T}, V<:AbstractVector{N}}
    n_in  = length(data)
    (span > 1 && n_in >= span) || throw(span_error(n_in, span))

    n_out = n_in - span + 1
    result = zeros(T, n_out)

    span = span - 1
    for i in 1:n_out
        idxspan = i:i+span
        @inbounds result[i] = fn(view(times, idxspan), view(data, idxspan))
    end
    
    return result
end

function rolling(fn::Function, weights::V, times::D, data::V) where
                {N<:MaybeNumber, T<:MaybeTime, D<:AbstractVector{T}, V<:AbstractVector{N}}
    n_in  = length(data)
    span  = length(weights)
    (span > 1 && n_in >= span)  || throw(span_error(n_in, span))
    (length(weights) == span)   || throw(weights_error(length(weights), span))

    n_out = n_in - span + 1
    result = zeros(T, n_out)

    span = span - 1     
    for i in 1:n_out
        @inbounds result[i] = fn(data[i:i+span] .* weights)
    end
    
    return result
end




rolling(::Type{FILL_FIRST}, fn::Function, span::Int, data::V) where
       {T<:MaybeNumber, V<:AbstractVector{T}} =
    rolling_fill_first(fn, span, data)
rolling(::Type{FILL_LAST}, fn::Function, span::Int, data::V) where
       {T<:MaybeNumber, V<:AbstractVector{T}} =
    rolling_fill_last(fn, span, data)
rolling(::Type{FILL_BOTH}, fn::Function, span::Int, data::V) where
       {T<:MaybeNumber, V<:AbstractVector{T}} =
    rolling_fill_both(fn, span, data)

rolling(::Type{FILL_FIRST}, fn::Function, span::Int, filler::T, data::V) where
       {T<:MaybeNumber, V<:AbstractVector{T}} =
    rolling_fill_first(fn, span, filler, data)
rolling(::Type{FILL_LAST}, fn::Function, span::Int, filler::T, data::V) where
       {T<:MaybeNumber, V<:AbstractVector{T}} =
    rolling_fill_last(fn, span, filler, data)
rolling(::Type{FILL_BOTH}, fn::Function, span::Int, filler::T, data::V) where
       {T<:MaybeNumber, V<:AbstractVector{T}} =
    rolling_fill_both(fn, span, filler, data)

rolling(::Type{TAPER_FIRST}, fn::Function, span::Int, tapered_span::Int, data::V) where
       {T<:MaybeNumber, V<:AbstractVector{T}} =
    rolling_taper_first(fn, span,  max(2, tapered_span), data)
rolling(::Type{TAPER_LAST}, fn::Function, span::Int, tapered_span::Int, data::V) where
       {T<:MaybeNumber, V<:AbstractVector{T}} =
    rolling_taper_last(fn, span,  max(2, tapered_span), data)
rolling(::Type{TAPER_BOTH}, fn::Function, span::Int, tapered_span::Int, data::V) where
       {T<:MaybeNumber, V<:AbstractVector{T}} =
    rolling_taper_both(fn, span,  max(2, tapered_span), data)

"""
rolling_fill_first(fn, span, data)

This rolls by applying fn to successive data sub-spans, then fills by carrying the span_th result backward.

`length(result) == length(data)`
"""
function rolling_fill_first(fn::Function, span::Int, data::V) where
                           {T<:MaybeNumber, V<:AbstractVector{T}}
    n_in  = length(data)
    (span > 1 && n_in >= span) || throw(span_error(n_in, span))

    res = zeros(T, n_in)    
    @inbounds res[span:end] = rolling(fn, span, data)
    res[1:span-1] = res[span]
    
    return res
end

"""
rolling_fill_first(fn, span, filler, data)

This rolls by applying fn to successive data sub-spans, then uses filler to fill the first span-1 entries.

`length(result) == length(data)`
"""
function rolling_fill_first(fn::Function, span::Int, filler::T, data::V) where
                           {T<:MaybeNumber, V<:AbstractVector{T}}
    n_in  = length(data)
    (span > 1 && n_in >= span) || throw(span_error(n_in, span))

    res = zeros(T, n_in)
    @inbounds res[span:end] = rolling(fn, span, data)
    res[1:span-1] = filler

    return res
end


"""
rolling_fill_last(fn, span, data)

This rolls by applying fn to successive data sub-spans, then fills by carrying the (end-span)_th result forward.

`length(result) == length(data)`
"""
function rolling_fill_last(fn::Function, span::Int, data::V) where
                          {T<:MaybeNumber, V<:AbstractVector{T}}
    n_in  = length(data)
    (span > 1 && n_in >= span) || throw(span_error(n_in, span))

    n_rolled = n_in - span + 1   
    res = zeros(T, n_in)
    
    @inbounds res[1:n_rolled] = rolling(fn, span, data)
    res[n_rolled+1:end] = res[n_rolled]

    return res
end

"""
rolling_fill_last(fn, span, filler, data)

This rolls by applying fn to successive data sub-spans, then uses filler to fill the last span-1 entries.

`length(result) == length(data)`
"""
function rolling_fill_last(fn::Function, span::Int, filler::T, data::V) where
                          {T<:MaybeNumber, V<:AbstractVector{T}}
    n_in  = length(data)
    (span > 1 && n_in >= span) || throw(span_error(n_in, span))

    n_rolled = n_in - span + 1   
    res = zeros(T, n_in)
    
    @inbounds res[1:n_rolled] = rolling(fn, span, data)
    res[n_rolled+1:end] = filler

    return res
end

"""
rolling_fill_both(fn, span, data)

This rolls by averaging (default) or by alpha*rolling_fill_first and (1-alpha)rolling_fill_last.

`length(result) == length(data)`
"""
function rolling_fill_both(fn::Function, span::Int, data::V, alpha::Float64=0.5) where
                          {T<:MaybeNumber, V<:AbstractVector{T}}
    return alpha*rolling_fill_first(fn, span, data) + (1.0-alpha)*rolling_fill_last(fn, span, data)
end

"""
rolling_fill_both(fn, span, filler, data)

This rolls by averaging (default) or by alpha*rolling_fill_first and (1-alpha)rolling_fill_last.

`length(result) == length(data)`
"""
function rolling_fill_both(fn::Function, span::Int, filler::T, data::V, alpha::Float64=9.5) where
                          {T<:MaybeNumber, V<:AbstractVector{T}}
    return (alpha * rolling_fill_first(fn, span, filler, data)) + ((1.0-alpha) * rolling_fill_last(fn, span, filler, data))
end


"""
rolling_taper_first(fn, span, tapered_span, data)

This rolls by applying fn to successive data sub-spans, then fills the first part by tapering
the window until its span equals tapered_span and finally copies.

`length(result) == length(data)`
"""
function rolling_taper_first(fn::Function, span::Int, tapered_span::Int, data::V) where
                            {T<:MaybeNumber, V<:AbstractVector{T}}
    n_in  = length(data)
    (span > 1 && n_in >= span) || throw(span_error(n_in, span))
    (span > tapered_span) || throw(taperedspan_error(span, tapered_span))

    res = zeros(T, n_in)
    @inbounds res[span:end] = rolling(fn, span, data)
    
    for i in (span-1):-1:tapered_span
        @inbounds res[i] = fn(view(data, 1:i))
    end
    res[1:tapered_span-1] = res[tapered_span]

    return res
end

"""
rolling_taper_last(fn, span, tapered_span, data)

This rolls by applying fn to successive data sub-spans, then fills the last part by tapering
the window until its span equals tapered_span and finally copies.

`length(result) == length(data)`
"""
function rolling_taper_last(fn::Function, span::Int, tapered_span::Int, data::V) where
                           {T<:MaybeNumber, V<:AbstractVector{T}}
    n_in  = length(data)
    (span > 1 && n_in >= span) || throw(span_error(n_in, span))
    (span > tapered_span) || throw(taperedspan_error(span, tapered_span))

    n_rolled = n_in - span + 1   
    res = zeros(T, n_in)
    
    @inbounds res[1:n_rolled] = rolling(fn, span, data)

    tapered_span = tapered_span - 1
    for i in n_rolled+1:n_in-tapered_span
        @inbounds res[i] = fn(view(data,i:n_in))
    end
    res[n_in-tapered_span+1:end] = res[n_in-tapered_span]
    
    return res
end

"""
rolling_taper_both(fn, span, tapered_span, data, [alpha])

This rolls by averaging (default) or by alpha*rolling_taper_first and (1-alpha)rolling_taper_last.

`length(result) == length(data)`
"""
function rolling_taper_both(fn::Function, span::Int, tapered_span::Int, data::V, alpha::Float64=0.5) where
                           {T<:MaybeNumber, V<:AbstractVector{T}}
    tapered_span = max(2, tapered_span)
    return alpha*rolling_taper_first(fn, span, tapered_span, data) + (1.0-alpha)*rolling_taper_last(fn, span, tapered_span, data)
end


# error explication

function span_error(n_in, span)
    if span > 1
        ErrorException("The data length ($n_in) is less than the window size ($span).")
    else
        ErrorException("The window size ($span) must be at least 2 for continuity.")
    end
end

function taperedspan_error(span, tapered_span)
    ErrorException("The span ($span) must be larger than the tapered span ($tapered_span).")
end

function weights_error(nweights, span)
    ErrorException("The number of weights ($nweights) must equal the span ($span).")
end
