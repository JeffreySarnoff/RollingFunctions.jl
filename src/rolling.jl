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

"""
rolling_fill_first(fn, span, data)
applies fn to successive sub-spans of data    
carries the span_th result backward
length(result) == length(data)
"""
function rolling_fill_first{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))

    n_out = n_in - span + 1 
    res   = zeros(T, n_in)
    
    res[span:n_out+span] = rolling(fn, span, data)
    res[1:span-1] = res[span]
    
    return res
end

"""
rolling_fill_first(fn, span, data, filler)
applies fn to successive sub-spans of data    
uses filler to fill the first span-1 entries
length(result) == length(data)
"""
function rolling_fill_first{T}(fn::Function, span::Int, data::Vector{T}, filler::T)
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))

    n_out = n_in - span + 1  
    res   = zeros(T, n_in)
    
    res[span:n_out+span] = rolling(fn, span, data)
    res[1:span-1] = filler

    return res
end


"""
rolling_fill_last(fn, span, data)
applies fn to successive sub-spans of data    
carries the (end-span)_th result forward
length(result) == length(data)
"""
function rolling_fill_last{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))

    n_out = n_in - span + 1   
    res   = zeros(T, n_in)
    
    res[1:n_out] = rolling(fn, span, data)
    res[n_out+1:end] = res[n_out]

    return res
end

"""
rolling_fill_last(fn, span, data, filler)
applies fn to successive sub-spans of data    
uses filler to fill the last span-1 entries
length(result) == length(data)
"""
function rolling_fill_last{T}(fn::Function, span::Int, data::Vector{T}, filler::T)
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))

    n_out = n_in - span + 1   
    res   = zeros(T, n_in)
    
    res[1:n_out] = rolling(fn, span, data)
    res[n_out+1:end] = filler

    return res
end

"""
rolling_fill_both(fn, span, data)   
applies fn to successive sub-spans of data    
averages rolling_fill_first and rolling_fill_last
length(result) == length(data)
"""
function rolling_fill_both{T}(fn::Function, span::Int, data::Vector{T})
    return 0.5*rolling_fill_first(fn, span, data) + 0.5*rolling_fill_last(fn, span, data)
end

"""
rolling_fill_both(fn, span, data, filler)   
applies fn to successive sub-spans of data    
averages rolling_fill_first and rolling_fill_last
uses filler to fill the each extremals' span-1 entries
length(result) == length(data)
"""
function rolling_fill_both{T}(fn::Function, span::Int, data::Vector{T}, filler::T)
    return 0.5*rolling_fill_first(fn, span, data, filler) + 0.5*rolling_fill_last(fn, span, data, filler)
end


"""
rolling_taper_first(fn, span, data, tapered_span)
applies fn to successive sub-spans of data    
tapers the window until its span is taperspan, then copies
length(result) == length(data)
"""
function rolling_taper_first{T}(fn::Function, span::Int, data::Vector{T}, tapered_span::Int)
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))
    (span > tapered_span) || throw(taperedspan_error(span, tapered_span))

    n_out = n_in - span + 1  
    res   = zeros(T, n_in)
    
    res[span:n_out+span] = rolling(fn, span, data)
    
    for i in (span-1):-1:tapered_span
        res[i] = fn(data[1:i])
    end
    res[1:tapered_span-1] = res[tapered_span]

    return res
end

"""
rolling_taper_last(fn, span, data, taperspan)
applies fn to successive sub-spans of data    
tapers the window until its span is taperspan, then copies
length(result) == length(data)
"""
function rolling_taper_last{T}(fn::Function, span::Int, data::Vector{T}, taperspan::Int)
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(span_error(n_in, span))

    n_out = n_in - span + 1   
    res   = zeros(T, n_in)
    
    res[1:n_out] = rolling(fn, span, data)

    for i in n_out+1:n_out+tapered_span
        res[i] = fn(data[n_out+i:end])
    end
    res[end-tapered_span+1:end] = res[end-tapered_span]
    
    return res
end

"""
rolling_taper_both(fn, span, data, taperspan)   
applies fn to successive sub-spans of data    
averages rolling_taper_first and rolling_taper_last
tapers each window until its span is taperspan
length(result) == length(data)
"""
function rolling_taper_both{T}(fn::Function, span::Int, data::Vector{T}, taperspan::Int)
    return 0.5*rolling_taper_first(fn, span, data, taperspan) + 0.5*rolling_taper_last(fn, span, data, taperspan)
end

