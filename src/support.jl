
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

WeightsError(nweighting, windowspan) =
    ErrorException("\n\twindowspan ($windowspan) != length(weighting) ($nweighting))).\n" )
