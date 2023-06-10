"""
    vmatrix(vector, n_columns)
    vmatrix(vector_of_vectors)
    vmatrix(::Type{T}, ..)

provides a Matrix
- where the source `vector` is replicated in each of the `n_columns`
- where each vector in the vector_of_vectors is a column

if the first argument is a numeric type
- the resultant Matrix has that same `eltype`

"""
@inline function vmatrix(v::AbstractVector, ncolumns::Integer)
    Base.stack(repeat([v], ncolumns))
end

@inline function vmatrix(vv::AbstractVector{<:AbstractVector})
    Base.stack(vv)
end

@inline function vmatrix(::Type{T}, v::AbstractVector, ncolumns::Integer) where {T<:Number}
    if T === eltype(v)
        vmatrix(v, ncolumns)
    else
        vmatrix(Vector{T}(v), ncolumns)
    end
end

@inline function vmatrix(::Type{T}, vv::AbstractVector{<:AbstractVector}) where {T<:Number}
    if T === eltype(vv[1])
        vmatrix(vv)
    else
        vmatrix(map(x->Vector{T}(x), vv), ncolumns)
    end
end


"""
    viewmatrix(vector, n_columns)
    viewmatrix(vector_of_vectors)
    viewmatrix(::Type{T}, ..)

provides the view of a Matrix
- where the source `vector` is replicated in each of the `n_columns`
- where each vector in the vector_of_vectors is a column

if the first argument is a numeric type
- the resultant Matrix has that same `eltype`
"""
@inline function viewmatrix(v::AbstractVector, ncolumns::Integer)
    view(vmatrix(v, ncolumns), :, :)
end

@inline function viewmatrix(vv::AbstractVector{<:AbstractVector})
    view(Base.stack(vv), :, :)
end

@inline function viewmatrix(::Type{T}, v::AbstractVector, ncolumns::Integer) where {T<:Number}
    if T === eltype(v)
        vmatrix(v, ncolumns)
    else
        vmatrix(Vector{T}(v), ncolumns)
    end
end

@inline function viewmatrix(::Type{T}, vv::AbstractVector{<:AbstractVector}) where {T<:Number}
    if T === eltype(vv[1])
        vmatrix(vv)
    else
        vmatrix(map(x->Vector{T}(x), vv), ncolumns)
    end
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


