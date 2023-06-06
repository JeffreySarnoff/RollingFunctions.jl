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

const ViewOfWeights = SubArray{T,1,A,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,A<:AbstractWeights}
const ViewOfVector = SubArray{T,1,V,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,V<:AbstractVector{T}}
const ViewOfVectors = SubArray{T,1,V,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,V<:Vector{AbstractVector{T}}}
const ViewOfViewedVectors = SubArray{SubArray{T, 1, Vector{T}, Tuple{Base.Slice{Base.OneTo{Int64}}}, true}, 1, Vector{SubArray{T, 1, Vector{T}, Tuple{Base.Slice{Base.OneTo{Int64}}}, true}}, Tuple{Base.Slice{Base.OneTo{Int64}}}, true} where {T}
const ViewOfViewedWeights = SubArray{SubArray{T, 1, W, Tuple{Base.Slice{Base.OneTo{Int64}}}, true}, 1, Array{SubArray{T, 1, W, Tuple{Base.Slice{Base.OneTo{Int64}}}, true}, 1}, Tuple{Base.Slice{Base.OneTo{Int64}}}, true} where {T, W<:(AbstractWeights{T, T1, V} where {T1<:Real, V<:AbstractVector{T1}})}
const ViewOfMatrix = SubArray{T,2,M,Tuple{Base.Slice{Base.OneTo{Int64}},Base.Slice{Base.OneTo{Int64}}},true} where {T,M<:AbstractMatrix{T}}

const ViewOfWeightVector = SubArray{T,1,A,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,A<:AbstractWeights}
const ViewOfVectorOfVectors = SubArray{W, 1, Vector{W}, Tuple{Base.Slice{Base.OneTo{Int64}}}, true} where {W<:AbstractWeights}

