# unweighted windowed function application

function rolling(fun::Function, data::AbstractVector{T}, windowspan::Int) where {T}
    nvals  = nrolled(length(data), windowspan)
    offset = windowspan - 1
    result = zeros(float(T), nvals)

    @inbounds for idx in eachindex(result)
        result[idx] = fun( view(data, idx:idx+offset) )
    end

    return result
end

# weighted windowed function application

function rolling(fun::Function, data::V, windowspan::Int, weighting::F) where
                 {T, N<:Number, V<:AbstractVector{T}, F<:Vector{N}}

    length(weighting) != windowspan &&
        throw(WeightsError(length(weighting), windowspan))

    nvals  = nrolled(length(data), windowspan)
    offset = windowspan - 1
    result = zeros(float(T), nvals)

    @inbounds for idx in eachindex(result)
        result[idx] = fun( view(data, idx:idx+offset) .* weighting )
    end

    return result
end


rolling(fun::Function, data::AbstractVector{T}, windowspan::Int, weighting::W) where
                {T, N<:Number, W<:AbstractWeights} =
    rolling(fun, data, windowspan, weighting.values)


# unweighted windowed function tapering

function tapers(fun::Function, data::AbstractVector{T}) where {T}
    nvals  = length(data)
    result = zeros(float(T), nvals) 

    @inbounds for idx in nvals:-1:1
        result[idx] = fun( view(data, 1:idx) )
    end

    return result
end

function tapers(fun::Function, data::AbstractVector{T}, ntocopy::Int) where {T}
    nvals  = length(data)
    ntocopy = min(nvals, max(0, ntocopy))

    result = zeros(float(T), nvals)
    if ntocopy > 0
       result[1:ntocopy] = data[1:ntocopy]
    end
    ntocopy += 1

    @inbounds for idx in nvals:-1:ntocopy
        result[idx] = fun( view(data, 1:idx) )
    end

    return result
end

function tapers(fun::Function, data::AbstractVector{T}, 
                trailing_data::AbstractVector{T}) where {T}
    
    ntrailing = axes(trailing_data)[1].stop
    nvals  = length(data) + ntrailing
    result = zeros(float(T), nvals)

    result[1:ntrailing] = trailing_data[1:ntrailing]
    ntrailing += 1

    @inbounds for idx in nvals:-1:ntrailing
        result[idx] = fun( view(data, 1:idx) )
    end

    return result
end

# weighted windowed function tapering

function tapers(fun::Function, data::V, weighting::F) where
                 {T, N<:Number, V<:AbstractVector{T}, F<:Vector{N}}

    nvals  = length(data)
    nweighting = length(weighting)
    
    nweighting == nvals || throw(WeightsError(length(weighting), nvals))
    
    result = zeros(float(T), nvals)

    @inbounds for idx in nvals:-1:1
        wts = normalize(view(weighting, (nweighting-idx+1):nweighting))
        result[idx] = fun( view(data, 1:idx) .* wts  )
    end

    return result
end

tapers(fun::Function, data::AbstractVector{T}, weighting::W) where
                {T, N<:Number, W<:AbstractWeights} =
    tapers(fun, data, weighting.values)

