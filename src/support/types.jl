struct NoPadding end
const nopadding = NoPadding()

hasnopadding(x) = x === nopadding
haspadding(x) = x !== nopadding

const VectorOfNTuples = AbstractVector{<:NTuple}
const VectorOfTuples  = AbstractVector{<:Tuple}

const VectorOfVectors = AbstractVector{<:AbstractVector} 
const VectorOfWeights = AbstractVector{<:AbstractWeights}  # VectorOfWeights <: VectorOfVectors


const ViewOfVector = SubArray{T,1,A,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,A<:AbstractVector}
const ViewOfWeights = SubArray{T,1,A,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,A<:AbstractWeights}

const ViewOfVectorOfWeights = SubArray{T,1,A,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,A<:AbstractVector{<:AbstractWeights}}
const ViewOfVectorOfVectors = SubArray{T,1,A,Tuple{Base.Slice{Base.OneTo{Int64}}},true} where {T,A<:AbstractVector{<:AbstractVector}}

const ViewOfMatrix = SubArray{T,2,M,Tuple{Base.Slice{Base.OneTo{Int64}},Base.Slice{Base.OneTo{Int64}}},true} where {T,M<:AbstractMatrix{T}}

#=
const TupleOfNTuples = Tuple{Vararg{NTuple}}
const TupleOfTuples = Tuple{Vararg{Tuple}}
const TupleOfVectors = Tuple{Vararg{AbstractVector}}
const TupleOfWeights = Tuple{Vararg{AbstractWeights}}

const Sequence = Union{AbstractVector{T},NTuple{N,T}} where {N,T}
seq(x::AbstractVector{T}) where {T} = x
seq(x::NTuple{N,T}) where {N,T} = x

const Multisequence = Union{Tuple{<:Sequence},AbstractVector{<:Sequence}}

=#

"""
    typeofviewof(x)

a `typeof` variant that generates view types from concrete x values
"""
typeofviewof

function typeofviewof(x)
    typeofx = typeof(x)
    eltypex = eltype(x)
    SubArray{eltypex,1,typeofx,Tuple{Base.Slice{Base.OneTo{Int}}},true}
end


#=
      AbstractVector
                    >: AbstractWeights
                                        >: VectorOfWeights 
                                                            >: VectorOfVectors

      AbstractVector
                    >: ViewOfVector
                                      >: ViewOfVectors
                   >: ViewOfWieghts


=#


