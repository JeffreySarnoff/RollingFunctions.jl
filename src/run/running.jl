for (T1, T2) in ((:T, :(float(T))), (:(Union{Missing,T}), :(Union{Missing,float(T)})))
  @eval begin

    # unweighted windowed function application that tapers

    function running(fun::Function, data::V, windowspan::Int) where {T, V<:AbstractVector{$T1}}
        ndata   = length(data)
        nvals   = nrolled(ndata, windowspan)
        ntapers = ndata - nvals

        result = zeros($T2, ndata)

        result[1:ntapers] = tapers(fun, data[1:ntapers])
        ntapers += 1
        result[ntapers:ndata] = rolling(fun, data, windowspan)

        return result
    end

    # weighted windowed function application that tapers

    function running(fun::Function, data::V, windowspan::Int, weighting::F) where
                     {T, V<:AbstractVector{$T1}, N<:Number, F<:Vector{N}}

        ndata   = length(data)
        nvals   = nrolled(ndata, windowspan)
        ntapers = ndata - nvals

        result = zeros($T2, ndata)

        result[1:ntapers] = tapers(fun, data[1:ntapers], weighting[end-(ntapers-1):end])
        ntapers += 1
        result[ntapers:ndata] = rolling(fun, data, windowspan, weighting)

        return result
    end

    running(fun::Function, data::V, windowspan::Int, weighting::W) where
                    {T, V<:AbstractVector{$T1}, W<:AbstractWeights} =
        running(fun, data, windowspan, weighting.values)

  end
end
