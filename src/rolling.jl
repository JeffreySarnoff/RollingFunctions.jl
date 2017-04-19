"""
rolling(fn, span, data)

applies fn to successive sub-spans of data

length(result) == length(data) - span + 1
"""
function rolling{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))

    n_out = n_in - span + 1
    res = zeros(T, n_out)

    span -= 1     
    for i in 1:n_out
        res[i] = fn(data[i:i+span])
    end
    
    return res
end


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
    rolling_taper_first(fn, span,  max(2, tapered_span), data)
rolling{T}(::Type{TAPER_LAST}, fn::Function, span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_last(fn, span,  max(2, tapered_span), data)
rolling{T}(::Type{TAPER_BOTH}, fn::Function, span::Int, tapered_span::Int, data::Vector{T}) =
    rolling_taper_both(fn, span,  tapered_span, data)

"""
rolling_fill_first(fn, span, data)

applies fn to successive sub-spans of data\n carries the span_th result backward

`length(result) == length(data)`
"""
function rolling_fill_first{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))

    res = zeros(T, n_in)    
    res[span:end] = rolling(fn, span, data)
    res[1:span-1] = res[span]
    
    return res
end

"""
rolling_fill_first(fn, span, filler, data)

applies fn to successive sub-spans of data\n
uses filler to fill the first span-1 entries

`length(result) == length(data)`
"""
function rolling_fill_first{T}(fn::Function, span::Int, filler::T, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))

    res = zeros(T, n_in)
    res[span:end] = rolling(fn, span, data)
    res[1:span-1] = filler

    return res
end


"""
rolling_fill_last(fn, span, data)

- applies fn to successive sub-spans of data    
- carries the (end-span)_th result forward

`length(result) == length(data)`
"""
function rolling_fill_last{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))

    n_rolled = n_in - span + 1   
    res   = zeros(T, n_in)
    
    res[1:n_rolled] = rolling(fn, span, data)
    res[n_rolled+1:end] = res[n_rolled]

    return res
end

"""
rolling_fill_last(fn, span, filler, data)

applies fn to successive sub-spans of data    
uses filler to fill the last span-1 entries

`length(result) == length(data)`
"""
function rolling_fill_last{T}(fn::Function, span::Int, filler::T, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))

    n_rolled = n_in - span + 1   
    res   = zeros(T, n_in)
    
    res[1:n_rolled] = rolling(fn, span, data)
    res[n_rolled+1:end] = filler

    return res
end

"""
rolling_fill_both(fn, span, data)

    applies fn to successive sub-spans of data    
    averages rolling_fill_first and rolling_fill_last

`length(result) == length(data)`
"""
function rolling_fill_both{T}(fn::Function, span::Int, data::Vector{T})
    return 0.5*rolling_fill_first(fn, span, data) + 0.5*rolling_fill_last(fn, span, data)
end

"""
rolling_fill_both(fn, span, filler, data)

> applies fn to successive sub-spans of data    
> uses filler to fill the each extremals' span-1 entries
averages rolling_fill_first and rolling_fill_last

`length(result) == length(data)`
"""
function rolling_fill_both{T}(fn::Function, span::Int, filler::T, data::Vector{T})
    return 0.5*rolling_fill_first(fn, span, data, filler) + 0.5*rolling_fill_last(fn, span, data, filler)
end


"""
rolling_taper_first(fn, span, tapered_span, data)
applies fn to successive sub-spans of data    
tapers the window until its span is tapered_span, then copies
length(result) == length(data)
"""
function rolling_taper_first{T}(fn::Function, span::Int, tapered_span::Int, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))
    (span > tapered_span) || throw(taperedspan_error(span, tapered_span))

    res   = zeros(T, n_in)
    res[span:end] = rolling(fn, span, data)
    
    for i in (span-1):-1:tapered_span
        res[i] = fn(data[1:i])
    end
    res[1:tapered_span-1] = res[tapered_span]

    return res
end

"""
rolling_taper_last(fn, span, tapered_span, data)
applies fn to successive sub-spans of data    
tapers the window until its span is tapered_span, then copies
length(result) == length(data)
"""
function rolling_taper_last{T}(fn::Function, span::Int, tapered_span::Int, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))
    (span > tapered_span) || throw(taperedspan_error(span, tapered_span))

    n_rolled = n_in - span + 1   
    res   = zeros(T, n_in)
    
    res[1:n_rolled] = rolling(fn, span, data)

    tapered_span = tapered_span - 1
    for i in n_rolled+1:n_in-tapered_span
        res[i] = fn(data[i:end])
    end
    res[n_in-tapered_span+1:end] = res[n_in-tapered_span]
    
    return res
end

"""
rolling_taper_both(fn, span, tapered_span, data)

> applies fn to successive sub-spans of data    
  averages rolling_taper_first and rolling_taper_last
  tapers each window until its span is tapered_span, then copies

`length(result) == length(data)`
"""
function rolling_taper_both{T}(fn::Function, span::Int, tapered_span::Int, data::Vector{T})
    return 0.5*rolling_taper_first(fn, span, tapered_span, data) + 0.5*rolling_taper_last(fn, span, tapered_span, data)
end


# error explication

function span_error(n_in, span)
    if span >= 1
        ErrorException("The data length ($n_in) is less than the window size ($span).")
    else
        ErrorException("The window size ($span) is less than 1.")
    end
end

function taperedspan_error(span, tapered_span)
    ErrorException("The span ($span) must be larger than the tapered span ($tapered_span).")
end
