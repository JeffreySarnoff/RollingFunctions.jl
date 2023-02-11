for (T1, T2) in ((:T, :(float(T))), (:(Union{Missing,T}), :(Union{Missing,float(T)})))
  @eval begin  

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
