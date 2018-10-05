#=
   statistical functions with faster rolling implementations
=#

function rolling_mean(data::V, windowspan::Int) where {T, V<:AbstractVector{T}}
    nvals  = nrolled(length(data), windowspan)
    offset = windowspan - 1
    result = zeros(float(T), nvals)
    result[1] = mean( view(data, 1:1+offset) )

    @inbounds for idx in Base.Iterators.drop(eachindex(result), 1)
       result[idx] = result[idx-1] + (data[idx+offset] - data[idx-1])
    end

    return result
end

function rolling_deltamean(data::V, windowspan::Int) where {T, V<:AbstractVector{T}}
    nvals  = nrolled(length(data), windowspan)
    offset = windowspan - 1
    meanvalue = mean( view(data, 1:1+offset) )
    result = zeros(float(T), nvals)
    result[1] = data[1+offset] - meanvalue

    @inbounds for idx in Base.Iterators.drop(eachindex(result), 1)
       meanvalue = meanvalue + (data[idx+offset] - data[idx-1])
       result[idx] = data[idx] - meanvalue
    end

    return result
end

function rolling_deltamean_squared(data::V, windowspan::Int) where {T, V<:AbstractVector{T}}
    nvals  = nrolled(length(data), windowspan)
    offset = windowspan - 1
    meanvalue = mean( view(data, 1:1+offset) )
    result = zeros(float(T), nvals)
    result[1] = (data[1+offset] - meanvalue)^2

    @inbounds for idx in Base.Iterators.drop(eachindex(result), 1)
       meanvalue = meanvalue + (data[idx+offset] - data[idx-1])
       result[idx] = (data[idx] - meanvalue)^2
    end

    return result
end

function rolling_variance(data::V, windowspan::Int) where {T, V<:AbstractVector{T}}
    nvals  = nrolled(length(data), windowspan)
    offset = windowspan - 1
    meanvalue = mean( view(data, 1:1+offset) )
    result = zeros(float(T), nvals)
    deltamean_squared = (data[1+offset] - meanvalue)^2
    result[1] = var 

    @inbounds for idx in Base.Iterators.drop(eachindex(result), 1)
       meanvalue = meanvalue + (data[idx+offset] - data[idx-1])
       deltamean_squared = (data[idx] - meanvalue)^2
    end

    return result
end


