# unweighted windowed function application that tapers

function running(fun::Function, data::AbstractVector{T}, windowspan::Int) where {T}
    ndata   = length(data)
    nvals   = nrolled(ndata, windowspan)
    ntapers = ndata - nvals
    
    result = zeros(T, ndata)
    
    result[1:ntapers] = tapers(fun, data[1:ntapers])
    ntapers += 1
    result[ntapers:ndata] = rolling(fun, data, windowspan)

    return result
end

# weighted windowed function application that tapers

function running(fun::Function, data::V, windowspan::Int, weighting::F) where
                 {T, N<:Number, V<:AbstractVector{T}, F<:Vector{N}}

    ndata   = length(data)
    nvals   = nrolled(ndata, windowspan)
    ntapers = ndata - nvals
    
    result = zeros(T, ndata)
    
    result[1:ntapers] = tapers(fun, data[1:ntapers], weighting[end-(ntapers-1):end])
    ntapers += 1
    result[ntapers:ndata] = rolling(fun, data, windowspan, weighting)

    return result
end

running(fun::Function, data::AbstractVector{T}, windowspan::Int, weighting::W) where
                {T, N<:Number, W<:AbstractWeights} =
    running(fun, data, windowspan, weighting.values)
