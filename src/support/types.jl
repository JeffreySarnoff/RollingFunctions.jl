struct NoPadding end
const nopadding = NoPadding()
isnopadding(x) = x === nopadding
ispadding(x) = x !== nopadding

const Sequence = Union{AbstractVector{T},NTuple{N,T}} where {N,T}
seq(x::AbstractVector{T}) where {T} = x
seq(x::NTuple{N,T}) where {N,T} = x

const Multisequence = Union{Tuple{<:Sequence},AbstractVector{<:Sequence}}

const VectorOfNTuples = AbstractVector{<:NTuple}
const VectorOfTuples = AbstractVector{<:Tuple}
const VectorOfVectors = AbstractVector{<:AbstractVector}
const VectorOfWeights = AbstractVector{<:AbstractWeights}

const TupleOfNTuples = Tuple{Vararg{NTuple}}
const TupleOfTuples = Tuple{Vararg{Tuple}}
const TupleOfVectors = Tuple{Vararg{AbstractVector}}
const TupleOfWeights = Tuple{Vararg{AbstractWeights}}

const ViewOfWeights = SubArray{T,1,A,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,A<:AbstractWeights}
const ViewOfVector = SubArray{T,1,V,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,V<:AbstractVector{T}}
const ViewOfVectors = SubArray{T,1,V,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,V<:AbstractVector{<:AbstractVector{T}}}
const ViewOfMatrix = SubArray{T,2,M,Tuple{Base.Slice{Base.OneTo{Int64}},Base.Slice{Base.OneTo{Int64}}},true} where {T,M<:AbstractMatrix{T}}

