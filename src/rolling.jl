# unweighted windowed function application

function rolling(fun::Function, data::AbstractVector{T}, windowspan::Int) where {T}
    nvals  = nrolled(length(data), windowspan)
    offset = windowspan - 1
    result = zeros(T, nvals)

    @inbounds for idx in eachindex(result)
        result[idx] = fun( view(data, idx:idx+offset) )
    end

    return result
end

# weighted windowed function application

function rolling(fun::Function, data::V, windowspan::Int, weights::F) where
                 {T, N<:Number, V<:AbstractVector{T}, F<:Vector{N}}

    length(weights) != windowspan &&
        throw(WeightsError(length(weights), windowspan))

    nvals  = nrolled(length(data), windowspan)
    offset = windowspan - 1
    result = zeros(T, nvals)

    @inbounds for idx in eachindex(result)
        result[idx] = fun( view(data, idx:idx+offset) .* weights )
    end

    return result
end


rolling(fun::Function, data::AbstractVector{T}, windowspan::Int, weights::W) where
                {T, N<:Number, W<:AbstractWeights} =
    rolling(fun, data, windowspan, weights.values)


# unweighted windowed function tapering

function tapers(fun::Function, data::AbstractVector{T}) where {T}
    nvals  = length(data)
    result = zeros(T, nvals)

    @inbounds for idx in nvals:-1:1
        result[idx] = fun( view(data, 1:idx) )
    end

    return result
end

function tapers(fun::Function, data::AbstractVector{T}, ntocopy::Int) where {T}
    nvals  = length(data)
    ntocopy = min(nvals, max(0, ntocopy))

    result = zeros(T, nvals)
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
    result = zeros(T, nvals)

    result[1:ntrailing] = trailing_data[1:ntrailing]
    ntrailing += 1

    @inbounds for idx in nvals:-1:ntrailing
        result[idx] = fun( view(data, 1:idx) )
    end

    return result
end

# weighted windowed function tapering

function tapers(fun::Function, data::V, weights::F) where
                 {T, N<:Number, V<:AbstractVector{T}, F<:Vector{N}}

    nvals  = length(data)
    nweights = length(weights)
    
    nweights >= nvals || throw(WeightsError(length(weights), nvals))
    weights = reverse!(weights)
    
    result = zeros(T, nvals)

    @inbounds for idx in nvals:-1:1
        result[idx] = fun( view(data, 1:idx) .* view(weights, 1:idx)  )
    end

    return result
end

tapers(fun::Function, data::AbstractVector{T}, weights::W) where
                {T, N<:Number, W<:AbstractWeights} =
    tapers(fun, data, weights.values)

# filling

function fills(filler::T, data::AbstractVector{T}) where {T}
    nvals  = axes(data)[1].stop
    return fill(filler, nvals)
end

function fills(filler::T1, data::AbstractVector{T2}) where {T1, T2}
    elemtype = Union{T1,T2}
    nvals  = axes(data)[1].stop
    result = Array{elemtype,1}(undef, nvals)
    result[:] = filler
    return result
end

# number of values to be obtained

function nrolled(seqlength::T, windowspan::T) where {T<:Signed}
    (0 < windowspan <= seqlength) || throw(SpanError(seqlength,windowspan))

    return seqlength - windowspan + 1
end

# number of values to be imputed

function nfilled(windowspan::T) where {T<:Signed}
    windowspan < 1 && throw(SpanError(seqlength,windowspan))

    return windowspan - 1
end

# local exceptions

SpanError(seqlength, windowspan) =
    ErrorException("\n\tBad window span ($windowspan) for length $seqlength.\n" )

WeightsError(nweights, windowspan) =
    ErrorException("\n\twindowspan ($windowspan) != length(weights) ($nweights))).\n" )

