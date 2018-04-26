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


# unweighted windowed function tapering

function tapering(fun::Function, data::AbstractVector{T}; copyinitialn::Int=0) where {T}
    nvals  = length(data)
    copyinitialn = min(nvals, max(0, copyinitialn))

    result = zeros(T, nvals)
    if copyinitialn > 0
       result[1:copyinitialn] = data[1:copyinitialn]
    end
    copyinitialn += 1

    @inbounds for idx in nvals:-1:copyinitialn
        result[idx] = fun( view(data, 1:idx) )
    end

    return result
end


# filling

filling(filler::T, data::AbstractVector{T}) where {T}
    nvals  = axes(data)[1].stop
    return fill(filler, nvals)
end

function filling(filler::T1, data::AbstractVector{T2}) where {T1, T2}
    elemtype = Union{T1,T2}
    nvals  = axes(data)[1].stop
    result = Array{elemtype,1}(undef, nvals)
    result[:] = filler
    return result
end


# local exceptions

SpanError(seqlength, windowspan) =
    ErrorException("\n\tBad window span ($windowspan) for length $seqlength.\n" )

WeightsError(nweights, windowspan) =
    ErrorException("\n\twindowspan ($windowspan) != length(weights) ($nweights))).\n" )
