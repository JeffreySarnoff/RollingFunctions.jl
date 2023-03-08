const Seq = Union{V, NT} where {N, T, V<:AbstractVector{T}, NT<:NTuple{N,T}}

seq(x::AbstractVector{T}) where {T} = x
seq(x::NTuple{N,T}) where {N,T} = x

struct NoPadding end
const nopadding = NoPadding()
isnopadding(x) = x === nopadding
ispadding(x) = x !== nopadding
