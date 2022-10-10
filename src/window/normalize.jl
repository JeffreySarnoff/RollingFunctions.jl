const Sequence = Union{Vec, Tup} where {N, T, Vec<:AbstractVector{T}, Tup<:NTuple{N,T}}

function normalize_weights(weights::Sequence)
    nweights = length(weights)
    iszero(nweights) && throw(ArgumentError("cannot normalize an empty sequence"))
    T = eltype(weights)
  
    simplesum = foldl(+, weights, init=zero(T))
    
end
