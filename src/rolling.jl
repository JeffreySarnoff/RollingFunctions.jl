"""
rolling(fn, span, data)    

applies fn to successive sub-spans of data   

length(result) == length(data) - span + 1
"""
function rolling{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(DomainError())

    n_out = n_in - span + 1
    res = zeros(T, n_out)
    span -= 1 
    
    for i in 1:n_out
        res[i] = fn(data[i:i+span])
    end    
    
    return res
end

"""
rolling_forwardfill(fn, span, data) is is rolling last result is carried forward      

applies fn to successive sub-spans of data    
carries the (end-span)_th result forward

length(result) == length(data)
"""
function rolling_forwardfill{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(DomainError())

    n_out = n_in - span + 1   
    res   = zeros(T, n_in)
    res[1:n_out] = rolling(fn, span, data)
    res[n_out+1:end] = res[n_out]
   return res
end

"""
rolling_backfill(fn, span, data) is rolling where first result is carried backward    

applies fn to successive sub-spans of data    
carries the span_th result backward

length(result) == length(data)
"""
function rolling_backfill{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(DomainError())

    n_out = n_in - span   
    res   = zeros(T, n_in)
    res[span:n_out+span] = rolling(fn, span, data)
    res[1:span-1] = res[span]
   return res
end

"""
rolling_centerfill(fn, span, data) is rolling bounding results are carried around   

applies fn to successive sub-spans of data    
averages rolling_locf and rolling_focb

length(result) == length(data)
"""
function rolling_centerfill{T}(fn::Function, span::Int, data::Vector{T})
    return 0.5*rolling_forwardfill(fn, span, data) + 0.5*rolling_backfill(fn, span, data)
end    
