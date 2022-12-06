# fill with n == product(dims(data)) copies of the filler

function filling(filler::T1, data::AbstractArray{T2}) where {T1,T2}
    elemtype = Union{T1, T2}
    allaxes = axes(data)
    naxes   = length(allaxes)
    alldims = map(x->x.stop, allaxes)
    result = Array{elemtype, naxes}(undef, alldims)
    result .= filler
    result
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
