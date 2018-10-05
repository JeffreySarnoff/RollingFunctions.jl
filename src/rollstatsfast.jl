#=
   statistical functions with faster rolling implementations
=#

function rolling_mean(data::V, windowspan::Int) where {T, V<:AbstractVector{T}}
function meanwindow(data::V, windowspan::Int) where {T, V<:AbstractVector{T}}
    nvals  = nrolled(length(data), windowspan)
    offset = windowspan - 1
    invwindowspan = inv(windowspan)
    result = zeros(float(T), nvals)
    result[1] = mean( view(data, 1:1+offset) )

    @inbounds for idx in Base.Iterators.drop(eachindex(result), 1)
       result[idx] = result[idx-1] + (data[idx+offset] - data[idx-1]) * invwindowspan
    end

    return result
end
   

