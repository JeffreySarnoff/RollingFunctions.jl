const VectorOfNTuples = AbstractVector{<:NTuple}
const VectorOfTuples = AbstractVector{<:Tuple}
const VectorOfVectors = AbstractVector{<:AbstractVector}

const TupleOfNTuples = Tuple{Vararg{<:NTuple}}
const TupleOfTuples = Tuple{Vararg{<:Tuple}}
const TupleOfVectors = Tuple{Vararg{<:AbstractVector}}
#=
const NTuples = Union{VectorOfNTuples,TupleOfNTuples}
const Tuples = Union{VectorOfTuples,TupleOfTuples}
const Vectors = Union{VectorOfVectors,TupleOfVectors}
=#
const NTuples = Union{VectorOfNTuples,Tuple{<:NTuple}}
const Tuples = Union{VectorOfTuples,Tuple{<:Tuple}}
const Vectors = Union{VectorOfVectors,Tuple{<:Vector}}

const Sequence = Union{AbstractVector{T},NTuple{N,T}} where {N,T}
seq(x::AbstractVector{T}) where {T} = x
seq(x::NTuple{N,T}) where {N,T} = x

const Multisequence = Union{Tuple{<:Sequence},AbstractVector{<:Sequence}}

const Span = Union{Int32,Int64}

struct NoPadding end
const nopadding = NoPadding()
isnopadding(x) = x === nopadding
ispadding(x) = x !== nopadding

struct Unweighted end
const unweighted = Unweighted()
isunwieghted(x) = x === unweighted
isweighted(x) = x !== unweighted

const AkoWeight = Union{Unweighted,AbstractWeights{T}} where {T}
const TupOfWeights = NTuple{N,AkoWeight} where {N}
const SeqOfWeights = Vararg{AkoWeight,N} where {N}

#=

const AkoTuple = Tuple{Vararg}
const AkoNTuple = NTuple{N,T} where {N,T}
const AkoVector = AbstractVector{T} where {T}
const AkoMatrix = AbstractMatrix{T} where {T}
# const AkoArray = AbstractArray{T,D} where {T,D}

const TupledTuples = Tuple{Vararg{AkoTuple}}
const TupledNTuples = Tuple{Vararg{AkoNTuple}}
const TupledVectors = Tuple{Vararg{AkoVector}}
const TupledMatrices = Tuple{Vararg{AkoMatrix}}
# const TupledArrays = Tuple{Vararg{AkoArray}}

const VecofTuples = AbstractVector{<:AkoTuple}
const VecofNTuples = AbstractVector{<:AkoNTuple}
const VecofVectors = AbstractVector{<:AkoVector}
const VecofMatrices = Tuple{Vararg{AkoMatrix}}
# const VecofArrays = Tuple{Vararg{AkoArray}}

const Sequence = Union{AkoNTuple,AkoVector}
const MultiSequence = Union{TupledTuples,TupledVectors,VecofTuples,VecofVectors}

isa_tuple_eltype(x) = eltype(x) <: AkoTuple
isa_ntuple_eltype(x) = eltype(x) <: AkoNTuple
isa_vector_eltype(x) = eltype(x) <: AkoVector
isa_collective_eltype(x) = isa_vector_eltype(x) || isa_tuple_eltype(x)

isa_simple_sequence(x) = isa(x, Sequence) && !isa_vector_eltype(x)
isa_multisequence(x) = isa(x, MultiSequence) && isa_collective_eltype(x)

seq(x::Sequence) = x
seq(x::MultiSequence) = x
multiseq(x::Sequence) = isa_multisequence(x) ? x : error("$(x) [typeof(x) == $(typeof(x))] is not a MultiSequence")
multiseq(x::MultiSequence) = isa_multisequence(x)
=#

#=
const DataVecs = Union{AbstractVector,Tuple{Vararg{AbstractVector}}}
const WeightVecs = Union{AbstractWeights, Tuple{Vararg{AbstractWeights}}}

seq(x::AbstractVector{T}) where {T} = x
seq(x::NTuple{N,T}) where {N,T} = x
seq(x::Tuple) = x
=#

#=
using Test, BenchmarkTools

nta = (1, 2, 3, 4)
ntb = (6.0, 8.0, 5.0, 7.0)
ntc = Tuple(map(Int, ntb))
ntab = (nta, ntb)
vtab = [nta, ntb]
ntac = (nta, ntc)
vtac = [nta, ntc]

va = [nta...]
vb = [ntb...]
vc = [ntc...]
tab = (va, vb)
vab = [va, vb]
tac = (va, vc)
vac = [va, vc]

@test isa(nta, AkoTuple)
@test typeof(nta) <: AkoTuple
@test isa(nta, AkoNTuple)
@test typeof(nta) <: AkoNTuple
@test isa(va, AkoVector)
@test typeof(va) <: AkoVector

@test isa(ntab, TupledTuples)
@test typeof(ntab) <: TupledTuples
@test isa(ntab, TupledNTuples)
@test typeof(ntab) <: TupledNTuples
@test isa(tab, TupledVectors)
@test typeof(tab) <: TupledVectors

@test isa(vab, VecofVectors)
@test typeof(vab) <: VecofVectors
@test isa(vac, VecofVectors)
@test typeof(vac) <: VecofVectors

@test isa(vtac, VecofTuples)
@test typeof(vtac) <: VecofTuples
@test isa(vtab, VecofTuples)
@test typeof(vtab) <: VecofTuples
@test isa(vtac, VecofNTuples)
@test typeof(vtac) <: VecofNTuples

@test isa(nta, Sequence) && !isa(nta, MultiSequence)
@test typeof(nta) <: Sequence
@test isa(va, Sequence) && !isa(nta, MultiSequence)
@test typeof(va) <: Sequence

@test isa(tab, MultiSequence) && !isa(tab, Sequence)
@test isa(vab, MultiSequence) && !isa(vab, Sequnce)
@test !(isa(tab, Sequence)) && isa(tab, MultiSequence)
@test !(typeof(tab) <: Sequence) && (typeof(tab) <: MultiSequence)
@test !(isa(vab, Sequence)) && isa(vab, MultiSequence)
@test !(typeof(vab) <: Sequence) && (typeof(vab) <: MultiSequence)




const Unweighted = Weights(Real[])
isweighted(x) = x !== Unweighted
isunweighted(x) = x === Unweighted
=#


#=
const ADataVec = AbstractVector{T} where {T<:Number}
const ADataTuple = NTuple{N,T} where {N,T<:Real}

const ADataVecs = AbstractVector{T} where {T<:AbstractVector}
const ADataTuples = Tuple{Vararg{Tuple}}



=#

