using KahanSummation: sum_kbn

const Sequence = Union{Vec, Tup} where {N, T, Vec<:AbstractVector{T}, Tup<:NTuple{N,T}}

function normalize_weights(weights::Sequence)
    nweights = length(weights)
    iszero(nweights) && throw(ArgumentError("cannot normalize an empty sequence"))
    T = eltype(weights)
  
    simplesum = zero(T)
    @tturbo for i in eachindex(weights)
        @inbounds simplesum += weights[i]
    end    
    kbnsum = sum_kbn(weights)
    
    if simplesum !== kbnsum
        weights_simple = map(x -> x / simplesum, wieghts)
        weights_kbn = map(x -> x / kbnsum, weights)
        sum_weights_kbn = sum(weights_kbn)
        sum_weights_simple = sum(weights_simple)
        if sum_weights_kbn == 1.0
            normalized = weights_kbn
        elseif sum_weights_simple == 1.0
            normalized = weights_simple
        end
    else
        normalized = map(x -> x / kbnsum, weights)
        if sum(normalized) > 1.0
            error("sum of weights > 1.0")
        end
    end
    
    normalized
end

        
            
    
end
