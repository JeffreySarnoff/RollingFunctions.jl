#=

A data stream is an item sequence.
An nD stream provides an item sequence where each item is of n elements. 
In a 1D stream, 1 item is of 1 element, the terms are effectively synonyms.
In a 2D stream, 1 item is of `size(stream)[2]` elements, the column count.

We support elements of any [shared] Numeric type, and provide for elements that
are of a Union{T, Numeric} where {T}. Usually, `T` is `Missing`. Otherwise,
`T` may be a second numeric type (e.g. Union{Float32, Int32}) or a singleton type
(e.g. `struct Sentinel end` `an_element_type = Union{Float64, Sentinel}` )

=#

for (T1, T2) in ((:T, :(Union{Missing,T})), (:T, :(float(T))), (:(Union{Missing,T}), :(Union{Missing,float(T)})))
  @eval begin  

    # unweighted windowed function application

    function rolling_dropping(fun::Function, data::AbstractVector{$T1}, windowspan::Int) where {T}
        nvals  = nrolled(length(data), windowspan)
        offset = windowspan - 1
        result = zeros($T2, nvals)

        @inbounds for idx in eachindex(result)
            result[idx] = fun( data[idx:idx+offset] )
        end

        return result
    end

    # unweighted windowed function application with optional padding

    function rolling(fun::Function, data::AbstractVector{$T1}, windowspan::Int;
                     padding=missing, padfirst::Bool=false, padlast::Bool=false) where {T}      
        if !padfirst && !padlast
            return rolling_dropping(fun, viewall(data), windowspan)
        end
      
        n = length(data)
        nvals  = nrolled(n, windowspan)
        offset = windowspan - 1
      
        result = zeros(Union{$T2, typeof(padding)}, n)

        if padfirst
            result[1:offset] .= padding
            idxs = windowspan:n
        else # padlast
            result[n-offset:n] .= padding
            idxs = 1:n-windowspan
        end
        
        @inbounds for idx in idxs
            result[idx] = fun( view(data, idx:idx+offset) )
        end

        return result
    end
    
    # weighted windowed function application
    function rolling(fun::Function, data::AbstractVector{$T1}, windowspan::Int, weighting::F) where
                        {T, N<:Number, F<:Vector{N}}

        length(weighting) != windowspan &&
           throw(WeightsError(length(weighting), windowspan))

        nvals  = nrolled(length(data), windowspan)
        offset = windowspan - 1
        result = zeros($T2, nvals)
        curwin = zeros($T2, windowspan)
        v = view(weighting,1:length(weighting))

        @inbounds for idx in eachindex(result)
           for i=1:windowspan
               j = i + idx - 1
               curwin[i] = data[j] * v[i]
           end
           result[idx] = fun( curwin )
        end

        return result
    end


    rolling(fun::Function, data::AbstractVector{$T1}, windowspan::Int, weighting::W) where
                    {T, W<:AbstractWeights} =
        rolling(fun, data, windowspan, weighting.values)


    # unweighted windowed function tapering

    function tapers(fun::Function, data::AbstractVector{$T1}) where {T}
        nvals  = length(data)
        result = zeros($T2, nvals) 

        @inbounds for idx in nvals:-1:1
            result[idx] = fun( view(data, 1:idx) )
        end

        return result
    end

    function tapers(fun::Function, data::AbstractVector{$T1}, ntocopy::Int) where {T}
        nvals  = length(data)
        ntocopy = min(nvals, max(0, ntocopy))

        result = zeros($T2, nvals)
        if ntocopy > 0
           result[1:ntocopy] = data[1:ntocopy]
        end
        ntocopy += 1

        @inbounds for idx in nvals:-1:ntocopy
            result[idx] = fun( view(data, 1:idx) )
        end

        return result
    end

    function tapers(fun::Function, data::AbstractVector{$T1}, 
                    trailing_data::AbstractVector{$T1}) where {T}

        ntrailing = axes(trailing_data)[1].stop
        nvals  = length(data) + ntrailing
        result = zeros($T2, nvals)

        result[1:ntrailing] = trailing_data[1:ntrailing]
        ntrailing += 1

        @inbounds for idx in nvals:-1:ntrailing
            result[idx] = fun( view(data, 1:idx) )
        end

        return result
    end

    # weighted windowed function tapering

    function tapers(fun::Function, data::AbstractVector{$T1}, weighting::F) where
                     {T, N<:Number, F<:Vector{N}}

        nvals  = length(data)
        nweighting = length(weighting)

        nweighting == nvals || throw(WeightsError(nweighting, nvals))

        result = zeros($T2, nvals)

        @inbounds for idx in nvals:-1:1
            wts = normalize(view(weighting, (nweighting-idx+1):nweighting))
            result[idx] = fun( view(data, 1:idx) .* wts  )
        end

        return result
    end

    tapers(fun::Function, data::AbstractVector{$T1}, weighting::W) where
                    {T,W<:AbstractWeights} =
        tapers(fun, data, weighting.values)

  end
end
