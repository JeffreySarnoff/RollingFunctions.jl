"""
    vmatrix(vector, n_columns)

provides a Matrix where the source `vector` is replicated in each of the `n_columns`
"""
function vmatrix(v::AbstractVector, ncols::Integer)
    mat = newmatrix(eltype(v), (length(v), ncols))
    @inbounds for colidx in 1:ncols
        mat[:,colidx] .= v
    end
    mat
end

vmatrix(v::AbstractWeights, ncols::Integer) =
    vmatrix(map(Vector, vv), ncols)

"""
    vvmatrix(vector_of_vectors)

provides a Matrix constructed from the source `vector_of_vectors` as columns
"""
function vvmatrix(vv::AAV) where {T, AV<:AbstractVector{T}, AAV<:AbstractVector{AV}}
    ncols = length(vv)
    mat = newmatrix(eltype(first(vv)), (length(first(vv)), ncols))
    @inbounds for colidx in 1:ncols
        mat[:,colidx] .= vv[colidx]
    end
    mat
end

vvmatrix(vv::AWV) where {T, AW<:AbstractWeights, AWV<:AbstractVector{AW}} =
    vvmatrix(map(Vector, vv))


"""
    newmatrix(::Type, size)
    newmatrix(::Type, nrows, ncolumns)

provides an unintialized Matrix of given `Type` and `size`
"""

@inline newmatrix(::Type{T}, size::Tuple{I,I}) where {T<:Number, I<:Integer} = 
    Matrix{T}(undef, size)

@inline newmatrix(::Type{T}, nrows::I, ncolumns::I) where {T<:Number, I<:Integer} =
   newmatrix(T, (nrows, ncolumns))


