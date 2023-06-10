"""
    vmatrix(vector, n_columns)
    vmatrix(vector_of_vectors)

provides a Matrix
- where the source `vector` is replicated in each of the `n_columns`
- where each vector in the vector_of_vectors is a column
"""
@inline function vmatrix(v::AbstractVector, ncolumns::Integer)
    Base.stack(repeat([v], ncolumns))
end

@inline function vmatrix(vv::AbstractVector{<:AbstractVector})
    Base.stack(vv)
end


"""
    newmatrix(::Type, size)
    newmatrix(::Type, nrows, ncolumns)

provides an unintialized Matrix of given `Type` and `size`
"""

@inline newmatrix(::Type{T}, size::Tuple{I,I}) where {T<:Number, I<:Integer} = 
    Matrix{T}(undef, size)

@inline newmatrix(::Type{T}, nrows::I, ncolumns::I) where {T<:Number, I<:Integer} =
   newmatrix(T, (nrows, ncolumns))


