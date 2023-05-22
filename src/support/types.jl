const VectorOfNTuples = AbstractVector{<:NTuple}
const VectorOfTuples = AbstractVector{<:Tuple}
const VectorOfVectors = AbstractVector{<:AbstractVector}
const VectorOfWeights = AbstractVector{<:AbstractWeights}

const TupleOfNTuples = Tuple{Vararg{NTuple}}
const TupleOfTuples = Tuple{Vararg{Tuple}}
const TupleOfVectors = Tuple{Vararg{AbstractVector}}
const TupleOfWeights = Tuple{Vararg{AbstractWeights}}

const NTupleOfTuples = NTuple{N,Tuple} where {N}
const NTupleOfVectors = NTuple{N, AbstractVector} where {N}
const NTupleOfWeights = NTuple{N, AbstractWeights} where {N}

const AkoNTuples = Union{VectorOfNTuples,NTupleOfTuples}
const AkoTuples = Union{VectorOfTuples,TupleOfTuples}
const AkoVectors = Union{VectorOfVectors,TupleOfVectors}
const AkoWeights = Union{VectorOfWeights,TupleOfWeights}

const Sequence = Union{AbstractVector{T},NTuple{N,T}} where {N,T}
seq(x::AbstractVector{T}) where {T} = x
seq(x::NTuple{N,T}) where {N,T} = x

const Multisequence = Union{Tuple{<:Sequence},AbstractVector{<:Sequence}}

const Width = Union{Int32,Int64}

struct NoPadding end
const nopadding = NoPadding()
isnopadding(x) = x === nopadding
ispadding(x) = x !== nopadding

struct Unweighted end
const unweighted = Unweighted()
isunwieghted(x) = x === unweighted
isweighted(x) = x !== unweighted

const Weighting = Union{Unweighted,AbstractWeights{T}} where {T}
const TupOfWeights = NTuple{N,Weighting} where {N}
const SeqOfWeights = Tuple{<:Weighting} where {N}

const WeightVector = AbstractWeights{T} where {T}
const WeightMatrix = AbstractVector{AbstractWeights{T}} where {T}

const ViewOfWeights = SubArray{T,1,A,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,A<:AbstractWeights}
const ViewOfVector = SubArray{T,1,V,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,V<:AbstractVector{T}}
const ViewOfMatrix = SubArray{T,2,M,Tuple{Base.Slice{Base.OneTo{Int64}},Base.Slice{Base.OneTo{Int64}}},true} where {T,M<:AbstractMatrix{T}}

const ViewOfWeightVector = SubArray{T,1,A,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,A<:AbstractWeights}
const ViewOfWeightMatrix = SubArray{W, 1, Vector{W}, Tuple{Base.Slice{Base.OneTo{Int64}}}, true} where {W<:AbstractWeights}

