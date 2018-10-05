#=
   statistical functions with faster rolling implementations
=#

function rolling_mean(data::V, windowspan::Int) where {T, V<:AbstractVector{T}}
    nvals  = nrolled(length(data), windowspan)
    offset = windowspan - 1
    result = zeros(T, nvals)
    result[1] = mean( view(data, 1:1+offset) )

    @inbounds for idx in Base.Iterators.drop(eachindex(result), 1)
       result[idx] = result[idx-1] + (data[idx+offset] - data[idx-1])
    end

    return result
end

function rolling_deltamean(data::V, windowspan::Int) where {T, V<:AbstractVector{T}}
    nvals  = RollingFunctions.nrolled(length(data), windowspan)
    offset = windowspan - 1
    means  = rolling_mean(data, windowspan)
    result = zeros(T, nvals)
    result[1] = zero(T)

    @inbounds for idx in Base.Iterators.drop(eachindex(result), 1)
       result[idx] = data[idx] - means[idx]
    end

    return result
end

function rolling_deltameansquared(data::V, windowspan::Int) where {T, V<:AbstractVector{T}}
    nvals  = RollingFunctions.nrolled(length(data), windowspan)
    offset = windowspan - 1
    means  = rolling_mean(data, windowspan)
    result = zeros(T, nvals)
    result[1] = zero(T)

    @inbounds for idx in Base.Iterators.drop(eachindex(result), 1)
       result[idx] = (data[idx] - means[idx])^2
    end

    return result
end

