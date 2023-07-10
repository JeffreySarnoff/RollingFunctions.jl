function basic_rolling(fn::F, width::Integer, data::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    # there are 1 or more columns, each holds `n` values
    rettype = rts(fn, (T,))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padfirst_rolling(fn::F, width::Integer, data::AbstractMatrix{T}, padding) where {T, F<:Function}
    ᵛʷdata = asview(data)
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
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the last entries, move windowed data back to the first entries

function padfinal_rolling(fn::F, width::Integer, data::AbstractMatrix{T}, padding) where {T, F<:Function}
    ᵛʷdata = asview(data)
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
        @views results[idx, :] = map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

#
# weighted
#

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weighting::AbstractWeights{T}) where {T, F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    basic_rolling(fn, width, data, mweights)
end

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weighting::VectorVectors{W}) where {T, W, F<:Function}
    if T <: Integer
        T2 = innertype(weighting)
        return basic_rolling(fn, width, Matrix{T2}(data), vmatrix(weighting))
    end
  
    mweights = Matrix{T}(vmatrix(weighting))
    basic_rolling(fn, width, data, mweights)
end

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weighting::VectorVectors{T}) where {T, F<:Function}
    mweights = vmatrix(weighting)

    basic_rolling(fn, width, data, mweights)
end

@inline function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weighting::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weighting)

    basic_rolling(fn, width, ᵛʷdata, ᵛʷweights)
end

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T, W, F<:Function}
    if T <: Integer
        return basic_rolling(fn, width, Matrix{W}(data), weighting)
    end
  
    colcount = ncols(data)
    mweights = vmatrix(Vector{T}(weighting), colcount)
    basic_rolling(fn, width, data, mweights)
end

@inline function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weighting::AbstractMatrix{W}) where {T, W, F<:Function}
    if T <: Integer
        return basic_rolling(fn, width, Matrix{W}(data), weighting)
    end

    mweights = Matrix{T}(weighting)
    basic_rolling(fn, width, data, weighting)
end

@inline function basic_rolling(fn::F, width::Integer, 
                       ᵛʷdata::ViewOfMatrix{T}, ᵛʷweights::ViewOfMatrix{T}) where {T, F<:Function}
    rowcount, colcount = size(ᵛʷdata)
    nvalues = rolling_wholes(rowcount, width)
    rettype = rts(fn, (T,))
    results = newmatrix(rettype, (nvalues, colcount))

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        results[ilow, :] = vec(mapcols(fn, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweights))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

#
# pad the start (first observations) with a given padding value
#

function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{T}) where {T,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    padfirst_rolling(fn, width, data, mweights)
end

function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::VectorVectors{T}) where {T,F<:Function}
    mweights = vmatrix(weighting)

    padfirst_rolling(fn, width, data, mweights)
end

@inline function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weighting)

    padfirst_rolling(fn, width, ᵛʷdata, ᵛʷweights)
end

function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T,W,F<:Function}
    if T <: Integer
        return padfirst_rolling(fn, width, Matrix{W}(data), weighting)
    end

    colcount = ncols(data)
    mweights = vmatrix(Vector{T}(weighting), colcount)

    padfirst_rolling(fn, width, data, mweights)
end

function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::VectorVectors{W}) where {T,W,F<:Function}
    if T <: Integer
        T2 = innertype(weighting)
        return padfirst_rolling(fn, width, Matrix{T2}(data), weighting)
    end

    mweights = Matrix{T}(vmatrix(weighting))
    padfirst_rolling(fn, width, data, mweights)
end

@inline function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractMatrix{W}) where {T,W,F<:Function}
    if T <: Integer
        return padfirst_rolling(fn, width, Matrix{W}(data), weighting)
    end

    mweights = Matrix{T}(weighting)
    padfirst_rolling(fn, width, data, weighting)
end

function padfirst_rolling(fn::F, width::Integer,
    ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T,F<:Function}
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
        @views results[idx, :] .= map(fn, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

#
# pad the end (last observations) with a given padding value
#

function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{T}) where {T,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    padfinal_rolling(fn, width, data, mweights)
end

function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::VectorVectors{T}) where {T,F<:Function}
    mweights = vmatrix(weighting)

    padfinal_rolling(fn, width, data, mweights)
end

@inline function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weighting)

    padfinal_rolling(fn, width, ᵛʷdata, ᵛʷweights)
end

function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T,W,F<:Function}
    if T <: Integer
        return padfinal_rolling(fn, width, Matrix{W}(data), weighting)
    end

    colcount = ncols(data)
    mweights = vmatrix(Vector{T}(weighting), colcount)
    padfinal_rolling(fn, width, data, mweights)
end

function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::VectorVectors{W}) where {T,W,F<:Function}
    if T <: Integer
        T2 = innertype(weighting)
        return padfinal_rolling(fn, width, Matrix{T2}(data), weighting)
    end
    
    mweights = Matrix{T}(vmatrix(weighting))
    padfinal_rolling(fn, width, data, mweights)
end

@inline function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractMatrix{W}) where {T,W,F<:Function}
    if T <: Integer
        return padfinal_rolling(fn, width, Matrix{W}(data), weighting)
    end

    mweights = Matrix{T}(weighting)
    padfinal_rolling(fn, width, data, weighting)
end

function padfinal_rolling(fn::F, width::Integer,
    ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}, padding) where {T,F<:Function}
    n = nrows(ᵛʷdata)
    nvalues = nrolled(n, width)
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
        @views results[idx, :] = map(fn, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end
