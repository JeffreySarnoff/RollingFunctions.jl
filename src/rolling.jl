"""
rolling(fn, span, data)    

applies fn to successive sub-spans of data   

length(result) == length(data) - span + 1
"""
function rolling{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    n_out = n_in - span + 1
    res = zeros(T, n_in)
    span -= 1 
    
    res[1:span] = data[1:span]
    for i in 1:n_out
        res[i+span] = fn(data[i:i+span])
    end    
    
    return res
end

"""
rolling_finish(fn, span, data)    

applies fn to successive sub-spans of data

length(result) == length(data)    

result[1:span-1] use coarser applications of fn:      

result[1] = fn(data[1])    

result[2] = fn(data[1], data[2]) ..
"""
function rolling_finish{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    res = zeros(T, n_in)
    span -= 1 
    
    for i in 1:span
        res[i] = fn(data[1:i])
    end    
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

result[end] = fn(data[end])    

result[end-1] = fn(data[end-1], data[end]) ..
"""
function rolling_start{T}(fn::Function, span::Int, data::Vector{T})
    n_in  = length(data)
    res = zeros(T, n_in)
    span -= 1 

    for i in 1:n_in-span
        res[i] = fn(data[i:i+span]); 
    end    
    for i in n_in-span+1:n_in
        res[i] = fn(data[i:n_in])
    end        
    return res
end

"""
rolling_final(fn, span, data)    

applies fn to successive sub-spans of data    

length(result) == length(data)    

result[1:span-1] == data[1:span-1]
"""
function rolling_final{T}(fn::Function, span::Int, data::Vector{T})
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


