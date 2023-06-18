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


# pad the dropped indicies with a given padding value

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

# pad the last entries, move windowed data back to the first entries

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

# weighted

function basic_tiling(fn::Function, width::Integer, data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T}
    ᵛʷdata = asview(data)
    ᵛʷweight = asview(weight)
    basic_tiling(fn, width, ᵛʷdata, ᵛʷweight)
end

function basic_tiling(fn::Function, width::Integer, data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T,W}
    if T <: Integer
        return basic_tiling(fn, width, Matrix{W}(data), weighting)
    end

    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    basic_tiling(fn, width, ᵛʷdata, ᵛʷweight)
end

function basic_tiling(fn::Function, width::Integer, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T}
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

# pad the dropped indicies with a given padding value

function padfirst_tiling(fn::Function, width::Integer, data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T,W}
    if T <: Integer
        return padfirst_tiling(fn, width, Matrix{W}(data), weighting)
    end

    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfirst_tiling(fn, width, ᵛʷdata, ᵛʷweight)
end

function padfirst_tiling(fn::Function, width::Integer, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T}
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
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the last entries, move windowed data back to the first entries

function padfinal_tiling(fn::Function, width::Integer, data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T,W}
    if T <: Integer
        return padfinal_tiling(fn, width, Matrix{W}(data), weighting)
    end

    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfinal_tiling(fn, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_tiling(fn::Function, width::Integer, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}, padding) where {T}
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

