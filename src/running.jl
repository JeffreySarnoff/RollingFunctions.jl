# unweighted windowed function application that tapers

function running(fun::Function, data::AbstractVector{T}, windowspan::Int) where {T}
    ndata   = length(data)
    nvals   = nrolled(ndata, windowspan)
    ntapers = ndata - nvals
    
    offset = windowspan - 1
    result = zeros(T, ndata)
    
    result[1:ntapers] = tapers(fun, data[1:ntapers])
    ntapers += 1
    
    @inbounds for idx in ntapers:nvals
        result[idx] = fun( view(data, idx:idx+offset) )
    end

    return result
end
