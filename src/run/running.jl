for (T1, T2) in ((:T, :(float(T))), (:(Union{Missing,T}), :(Union{Missing,float(T)})))
  @eval begin

    # unweighted windowed function application that tapers

    function running(fun::Function, data::V, windowwidth::Int) where {T, V<:AbstractVector{$T1}}
        ndata   = length(data)
        nvals   = nrolling(ndata, windowwidth)
        ntapers = ndata - nvals

        result = zeros($T2, ndata)

        result[1:ntapers] = tapers(fun, data[1:ntapers])
        ntapers += 1
        result[ntapers:ndata] = rolling(fun, data, windowwidth)

        return result
    end

    # weighted windowed function application that tapers

    function running(fun::Function, data::V, windowwidth::Int, weighting::F) where
                     {T, V<:AbstractVector{$T1}, N<:Number, F<:Vector{N}}

        ndata   = length(data)
        nvals   = nrolling(ndata, windowwidth)
        ntapers = ndata - nvals

        result = zeros($T2, ndata)

        result[1:ntapers] = tapers(fun, data[1:ntapers], weighting[end-(ntapers-1):end])
        ntapers += 1
        result[ntapers:ndata] = rolling(fun, data, windowwidth, weighting)

        return result
    end

    running(fun::Function, data::V, windowwidth::Int, weighting::W) where
                    {T, V<:AbstractVector{$T1}, W<:AbstractWeights} =
        running(fun, data, windowwidth, weighting.values)

  end
end
