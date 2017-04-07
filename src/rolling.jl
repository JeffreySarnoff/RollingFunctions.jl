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

"""
rolling_finish(fn, span, data)    

applies fn to successive sub-spans of data

length(result) == length(data)    

result[1:span-1] use coarser applications of fn:      

result[1] = result[2]

result[2] = fn([data[1], data[2]])    

result[3] = fn([data[1], data[2], data[3]]) ..
"""
function rolling_finish{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    res = zeros(T, n_in)
    span -= 1 
    
    for i in 2:span
        res[i] = fn(data[1:i])
    end
    res[1] = res[2]
    
    for i in 1+span:n_in
        res[i] = fn(data[i-span:i]); 
    end
    
    return res
end

"""
rolling_start(fn, span, data)    

applies *fn* to successive sub-*span*s of *data*    

length(result) == length(data)    

result[end-span+1:end] use coarser applications of fn:       

result[end] = result[end-1]

result[end-1] = fn([data[end-1], data[end]])    

result[end-2] = fn([data[end-2], data[end-1], data[end]]) ..
"""
function rolling_start{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    res = zeros(T, n_in)
    span -= 1 

    for i in 1:n_in-span
        res[i] = fn(data[i:i+span]); 
    end    
    for i in n_in-span+1:n_in-1
        res[i] = fn(data[i:n_in])
    end
    res[n_in] = res[n_in-1]
    return res
end

"""
rolling_last(fn, span, data)    

applies fn to successive sub-spans of data    

length(result) == length(data)    

result[1:span-1] == data[1:span-1]
"""
function rolling_last{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    res = zeros(T, n_in)
    span -= 1
    
    res[1:span] = data[1:span]
    for i in 1+span:n_in
        res[i] = fn(data[i-span:i]); 
    end        
    return res
end

"""
rolling_first(fn, span, data)    

applies fn to successive sub-spans of data    

length(result) == length(data)    

result[end-span+1:end] == data[end-span+1:end]
"""
function rolling_first{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    res = zeros(T, n_in)
    span -= 1 
    
    for i in 1:n_in-span
        res[i] = fn(data[i:i+span]); 
    end    
    res[end-span+1:end] = data[end-span+1:end]
    return res
end


