# unweighted windowed function application

function rolling(fun2::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, windowspan::Int) where {T}
    nvals  = nrolled(min(length(data1),length(data2)), windowspan)
    offset = windowspan - 1
    result = zeros(float(T), nvals)

    @inbounds for idx in eachindex(result)
        result[idx] = fun2( view(data1, idx:idx+offset), view(data2, idx:idx+offset) )
    end

    return result
end

# weighted windowed function application
#=
function rolling(fun2::Function, data1::V, data2::V, windowspan::Int, weighting::F) where
                 {T, N<:Number, V<:AbstractVector{T}, F<:Vector{N}}

    length(weighting) != windowspan &&
        throw(WeightsError(length(weighting), windowspan))

    nvals  = nrolled(min(length(data1), length(data2)), windowspan)
    offset = windowspan - 1
    result = zeros(float(T), nvals)

    @inbounds for idx in eachindex(result)
        result[idx] = fun2( view(data1, idx:idx+offset) .* weighting,  view(data2, idx:idx+offset) .* weighting )
    end

    return result
end
=#

# weighted windowed function application
function rolling(fun2::Function, data1::V, data2::V, windowspan::Int, weighting::F) where
                    {T, N<:Number, V<:AbstractVector{T}, F<:Vector{N}}

    length(weighting) != windowspan &&
       throw(WeightsError(length(weighting), windowspan))

    nvals  = nrolled(min(length(data1), length(data2)), windowspan)
    offset = windowspan - 1
    result = zeros(float(T), nvals)
    curwin1 = zeros(float(T), windowspan)
    curwin2 = zeros(float(T), windowspan)
    v = view(weighting,1:length(weighting))

    @inbounds for idx in eachindex(result)
       for i=1:windowspan
           j = i + idx - 1
           curwin1[i] = data1[j] * v[i]
           curwin2[i] = data2[j] * v[i]
       end
       result[idx] = fun( curwin1, curwin2 )
    end

    return result
end


# weighted windowed function application
function rolling(fun2::Function, data1::V, data2::V, windowspan::Int, weighting1::F, weighting2::F) where
                    {T, N<:Number, V<:AbstractVector{T}, F<:Vector{N}}

    length(weighting1) != windowspan &&
       throw(WeightsError(length(weighting1), windowspan))
    length(weighting2) != windowspan &&
       throw(WeightsError(length(weighting2), windowspan))

    nvals  = nrolled(min(length(data1), length(data2)), windowspan)
    offset = windowspan - 1
    result = zeros(float(T), nvals)
    curwin1 = zeros(float(T), windowspan)
    curwin2 = zeros(float(T), windowspan)
    v1 = view(weighting1,1:windowspan)
    v2 = view(weighting2,1:windowspan)

    @inbounds for idx in eachindex(result)
       for i=1:offset
           j = i + idx - 1
           curwin1[i] = data1[j] * v1[i]
           curwin2[i] = data2[j] * v2[i]
       end
       result[idx] = fun2( curwin1, curwin2 )
    end

    return result
end



rolling(fun2::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, windowspan::Int, weighting::W) where
                {T, N<:Number, W<:AbstractWeights} =
    rolling(fun2, data1, data2, windowspan, weighting.values)


# unweighted windowed function tapering

function tapers2(fun2::Function, data1::AbstractVector{T}, data2::AbstractVector{T}) where {T}
    nvals  = min(length(data1), length(data2))
    result = zeros(float(T), nvals) 

    @inbounds for idx in nvals:-1:1
        result[idx] = fun2( view(data1, 1:idx), view(data2, 1:idx) )
    end

    return result
end

function tapers2(fun2::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, ntocopy::Int) where {T}
    nvals  = min(length(data1), length(data2))
    ntocopy = min(nvals, max(0, ntocopy))

    result = zeros(float(T), nvals)
    if ntocopy > 0
       result[1:ntocopy] = data[1:ntocopy]
    end
    ntocopy += 1

    @inbounds for idx in nvals:-1:ntocopy
        result[idx] = fun2( view(data1, 1:idx), view(data2, 1:idx) )
    end

    return result
end

function tapers2(fun2::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, 
                trailing_data::AbstractVector{T}) where {T}
    
    ntrailing = axes(trailing_data)[1].stop
    nvals  = min(length(data1), length(data2)) + ntrailing
    result = zeros(float(T), nvals)

    result[1:ntrailing] = trailing_data[1:ntrailing]
    ntrailing += 1

    @inbounds for idx in nvals:-1:ntrailing
        result[idx] = fun2( view(data1, 1:idx),  view(data2, 1:idx) )
    end

    return result
end

# weighted windowed function tapering

function tapers2(fun2::Function, data1::V, data2::V, weighting::F) where
                 {T, N<:Number, V<:AbstractVector{T}, F<:Vector{N}}

    nvals  = min(length(data1), length(data2))
    nweighting = length(weighting)
    
    nweighting == nvals || throw(WeightsError(length(weighting), nvals))
    
    result = zeros(float(T), nvals)

    @inbounds for idx in nvals:-1:1
        wts = normalize(view(weighting, (nweighting-idx+1):nweighting))
        result[idx] = fun2( view(data1, 1:idx) .* wts, view(data2, 1:idx) .* wts   )
    end

    return result
end

tapers2(fun2::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, weighting::W) where
                {T, N<:Number, W<:AbstractWeights} =
    tapers2(fun2, data1, data2, weighting.values)

