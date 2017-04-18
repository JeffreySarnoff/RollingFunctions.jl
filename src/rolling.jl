function span_error(n_in, span)
    if span >= 1
        ErrorException("The data length ($n_in) is less than the window size ($span).")
    else
        ErrorException("The window size ($span) is less than 1.")
    end
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
rolling_fill_both(fn, span, data)   
applies fn to successive sub-spans of data    
averages rolling_fill_first and rolling_fill_last
uses filler to fill the each extremals' span-1 entries
length(result) == length(data)
"""
function rolling_fill_both{T}(fn::Function, span::Int, data::Vector{T}, filler::T)
    return 0.5*rolling_fill_first(fn, span, data, filler) + 0.5*rolling_fill_last(fn, span, data, filler)
end    
