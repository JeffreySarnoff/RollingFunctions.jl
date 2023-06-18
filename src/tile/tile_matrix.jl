#=
     basic_tiling(fn::Function, width, ::Matrix)
     padfirst_tiling(fn::Function, width, ::Matrix; padding)
     padfinal_tiling(fn::Function, width, ::Matrix; padding)

     basic_tiling(fn::Function, width, ::Matrix, weight)
     padfirst_tiling(fn::Function, width, ::Matrix, weight; padding)
     padfinal_tiling(fn::Function, width, ::Matrix, weight; padding)
=#

function basic_tiling(fn::Function, width::Integer, data::AbstractMatrix{T}) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = ntiling(n, width)

    rettype = rts(fn, (T,))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

#
# pad the dropped indicies with a given padding value
#

function padfirst_tiling(fn::Function, width::Integer, data::AbstractMatrix{T}, padding) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = ntiling(n, width)

    if iszero(tiling_parts(n, width))
        return basic_tiling(fn, width, ᵛʷdata)
    end

    rettype = rts(fn, (T,))
    results = Matrix{Union{typeof(padding),rettype}}(undef, (nvalues+1, ncols(ᵛʷdata)))

    results[1,:] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 2:nvalues+1
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

#
# pad the last entries, move windowed data back to the first entries
#

function padfinal_tiling(fn::Function, width::Integer, data::AbstractMatrix{T}, padding) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = ntiling(n, width)

    if iszero(tiling_parts(n, width))
        return basic_tiling(fn, width, ᵛʷdata)
    end

    rettype = rts(fn, (T,))
    results = Matrix{Union{typeof(padding),rettype}}(undef, (nvalues + 1, ncols(ᵛʷdata)))

    results[end, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

#
# weighted
#

function basic_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{T}) where {T,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)
    basic_tiling(fn, width, data, mweights)
end

function basic_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::VectorOfVectors{T}) where {T,F<:Function}
    mweights = vmatrix(weighting)
    basic_tiling(fn, width, data, mweights)
end

@inline function basic_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weighting)
    basic_tiling(fn, width, ᵛʷdata, ᵛʷweights)
end

function basic_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T,W,F<:Function}
    if T <: Integer
        T2 = eltype(weighting)
        return basic_tiling(fn, width, Matrix{T2}(data), weighting)
    end

    colcount = ncols(data)
    mweights = vmatrix(Vector{T}(weighting), colcount)
    basic_tiling(fn, width, data, mweights)
end

function basic_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::VectorOfVectors{W}) where {T,W,F<:Function}
    if T <: Integer
        T2 = eltype(eltype(weighting))
        return basic_tiling(fn, width, Matrix{T2}(data), weighting)
    end

    mweights = Matrix{T}(vmatrix(weighting))
    basic_tiling(fn, width, data, mweights)
end

@inline function basic_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractMatrix{W}) where {T,W,F<:Function}
    if T <: Integer
        return basic_tiling(fn, width, Matrix{W}(data), weighting)
    end

    mweights = Matrix{T}(weighting)
    basic_tiling(fn, width, data,weighting)
end

function basic_tiling(fn::Function, width::Integer, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}) where {T}
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    # there are 1 or more columns, each holds `n` values
    rettype = rts(fn, (T,))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

#
# pad the dropped indicies with a given padding value
#

function padfirst_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{T}, padding) where {T,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    padfirst_tiling(fn, width, data, mweights, padding)
end

function padfirst_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T},weighting::VectorOfVectors{T}, padding) where {T,F<:Function}
    mweights = vmatrix(weighting)

    padfirst_tiling(fn, width, data, mweights, paddomg)
end

@inline function padfirst_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T},weighting::AbstractMatrix{T}, padding) where {T,F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weighting)

    padfirst_tiling(fn, width, ᵛʷdata, ᵛʷweights, padding)
end

function padfirst_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{W}, padding) where {T,W,F<:Function}
    if T <: Integer
        T2 = eltype(weighting)
        return padfirst_tiling(fn, width, Matrix{T2}(data), weighting, padding)
    end

    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    padfirst_tiling(fn, width, data, mweights, padding)
end

function padfirst_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::VectorOfWeights{W}, padding) where {T,W,F<:Function}
    if T <: Integer
        T2 = eltype(eltypoe(weighting))
        return padfirst_tiling(fn, width, Matrix{T2}(data), weighting, padding)
    end

    mweights = Matrix{T}(vmatrix(weighting))
    padfirst_tiling(fn, width, data, mweights, padding)
end

function padfirst_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::VectorOfVectors{W}, padding) where {T,W,F<:Function}
    if T <: Integer
        T2 = eltype(eltype(weighting))
        return padfirst_tiling(fn, width, Matrix{T2}(data),weighting, padding)
    end

    mweights = Matrix{T}(vmatrix(weighting))
    padfirst_tiling(fn, width, data, mweights, padding)
end

@inline function padfirst_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T},weighting::AbstractMatrix{W}, padding) where {T,W,F<:Function}
    if T <: Integer
        return padfirst_tiling(fn, width, Matrix{W}(data),weighting, padding)
    end

    padfirst_tiling(fn, width, data, Matrix{T}(weighting), padding)
end

function padfirst_tiling(fn::Function, width::Integer, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}, padding) where {T}
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = Union{typeof(padding),rts(fn, (T,))}
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt fn
    # this is the padding_width
    padding_width = width - 1
    padding_idxs = 1:padding_width

    results = Matrix{Union{typeof(padding),rettype}}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight))
        ilow = ilow + 1_rolling
        ihigh = ihigh + 1
    end

    results
end

#
# pad the last entries, move windowed data back to the first entries
#

function padfinal_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{T}, padding) where {T,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    padfinal_tiling(fn, width, data, mweights, padding)
end

function padfinal_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T},weighting::VectorOfVectors{T}, padding) where {T,F<:Function}
    mweights = vmatrix(weighting)

    padfinal_tiling(fn, width, data, mweights, paddomg)
end

@inline function padfinal_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T},weighting::AbstractMatrix{T}, padding) where {T,F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weighting)

    padfinal_tiling(fn, width, ᵛʷdata, ᵛʷweights, padding)
end

function padfinal_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{W}, padding) where {T,W,F<:Function}
    if T <: Integer
        T2 = eltype(weighting)
        return padfinal_tiling(fn, width, Matrix{T2}(data), weighting, padding)
    end

    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    padfinal_tiling(fn, width, data, mweights, padding)
end

function padfinal_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T},weighting::VectorOfVectors{W}, padding) where {T,W,F<:Function}
    if T <: Integer
        T2 = eltype(eltype(weighting))
        return padfinal_tiling(fn, width, Matrix{T2}(data), weighting, padding)
    end

    mweights = Matrix{T}(vmatrix(weighting))
    padfinal_tiling(fn, width, data, mweights, padding)
end

@inline function padfinal_tiling(fn::F, width::Integer,
    data::AbstractMatrix{T},weighting::AbstractMatrix{W}, padding) where {T,W,F<:Function}
    if T <: Integer
        return padfinal_tiling(fn, width, Matrix{W}(data),weighting, padding)
    end

    padfinal_tiling(fn, width, data, Matrix{T}(weighting), padding)
end


function padfinal_tiling(fn::Function, width::Integer, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix, padding) where {T}
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = Union{typeof(padding),rts(fn, (T,))}

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt fn
    # this is the padding_width
    padding_width = width - 1
    padding_idxs = n-padding_width:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-padding_width
        @views results[idx, :] = map(fn, eachcol(ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

