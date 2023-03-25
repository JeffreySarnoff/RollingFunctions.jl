const Span = Union{Int, NTuple{N,Int}} where {N}

const Sequence = Union{V, NT} where {N, T, V<:AbstractVector{T}, NT<:NTuple{N,T}}
const Seq = Sequence

seq(x::AbstractVector{T}) where {T} = x
seq(x::NTuple{N,T}) where {N,T} = x

struct NoPadding end
const nopadding = NoPadding()
isnopadding(x) = x === nopadding
ispadding(x) = x !== nopadding

const Unweighted = Weights(Real[])
isweighted(x) = x !==  Unweighted
isunweighted(x) = x === Unweighted

const DataVecs = Union{AbstractVector, Tuple{Vararg{AbstractVector}}}
const WeightVecs = Union{AbstractWeights, Tuple{Vararg{AbstractWeights}}}
