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
rolling_locf(fn, span, data) is is rolling last_obs_carry_forward      

applies fn to successive sub-spans of data    
carries the (end-span)_th result forward

length(result) == length(data)
"""
function rolling_locf{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(DomainError())

    n_out = n_in - span + 1   
    res   = zeros(T, n_in)
    res[1:n_out] = rolling(fn, span, data)
    res[n_out+1:end] = res[n_out]
   return res
end

"""
rolling_focb(fn, span, data) is rolling first_obs_carry_backward    

applies fn to successive sub-spans of data    
carries the span_th result backward

length(result) == length(data)
"""
function rolling_focb{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    (span >= 1 && n_in >= span) || throw(DomainError())

    n_out = n_in - span   
    res   = zeros(T, n_in)
    res[span:n_out+span] = rolling(fn, span, data)
    res[1:span-1] = res[span]
   return res
end

"""
rolling_boca(fn, span, data) is rolling bounding_obs_carry_around   

applies fn to successive sub-spans of data    
averages rolling_locf and rolling_focb

length(result) == length(data)
"""
function rolling_boca{T}(fn::Function, span::Int, data::Vector{T})
    return 0.5*rolling_locf(fn, span, data) + 0.4*rolling_focb(fn, span, data)
end    
