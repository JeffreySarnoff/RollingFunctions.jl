#=
     basic_tiling(func::Function, span, ::Matrix)
     padfirst_tiling(func::Function, span, ::Matrix; padding)
     padfinal_tiling(func::Function, span, ::Matrix; padding)

     basic_tiling(func::Function, span, ::Matrix, weight)
     padfirst_tiling(func::Function, span, ::Matrix, weight; padding)
     padfinal_tiling(func::Function, span, ::Matrix, weight; padding)
=#

function basic_tiling(func::Function, span::Span, data::AbstractMatrix{T}) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = ntiled(n, span)

    rettype = rts(func, (T,))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    ilow, ihigh = 1, span
    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + span
        ihigh = ihigh + span
    end

    results
end


# pad the dropped indicies with a given padding value

function padfirst_tiling(func::Function, span::Span, data::AbstractMatrix{T}, padding) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = ntiled(n, span)

    if iszero(nimputed_tiling(n, span))
        return basic_tiling(func, span, ᵛʷdata)
    end

    rettype = rts(func, (T,))
    results = Matrix{rettype}(undef, (nvalues+1, ncols(ᵛʷdata)))

    results[1,:] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in eachindex(2:nvalues+1)
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + span
        ihigh = ihigh + span
    end

    results
end



# pad the last entries, move windowed data back to the first entries

function padfinal_tiling(func::Function, span::Span, data::AbstractMatrix{T}, padding) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = ntiled(n, span)

    if iszero(nimputed_tiling(n, span))
        return basic_tiling(func, span, ᵛʷdata)
    end

    rettype = rts(func, (T,))
    results = Matrix{rettype}(undef, (nvalues + 1, ncols(ᵛʷdata)))

    results[end, :] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in eachindex(1:nvalues)
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + span
        ihigh = ihigh + span
    end

    results
end

# weighted

function basic_tiling(func::Function, span::Span, data::AbstractMatrix{T}, weight::Weighting{T}) where {T}
    ᵛʷdata = asview(data)
    ᵛʷweight = asview(weight)
    basic_tiling(func, span, ᵛʷdata, ᵛʷweight)
end


function basic_tiling(func::Function, span::Span, data::AbstractMatrix{T}, weight::Weighting{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    basic_tiling(func, span, ᵛʷdata, ᵛʷweight)
end

function basic_tiling(func::Function, span::Span, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T}
    n = nrows(ᵛʷdata)
    nvalues = nrolled(n, span)
    # there are 1 or more columns, each holds `n` values
    rettype = rts(func, (T,))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    ilow, ihigh = 1, span
    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padfirst_tiling(func::Function, span::Span, data::AbstractMatrix{T}, weight::Weighting{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfirst_tiling(func, span, ᵛʷdata, ᵛʷweight)
end

function padfirst_tiling(func::Function, span::Span, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T}
    n = nrows(ᵛʷdata)
    nvalues = nrolled(n, span)
    rettype = Union{typeof(padding),rts(func, (T,))}
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    # this is the padding_span
    padding_span = span - 1
    padding_idxs = 1:padding_span

    results = Matrix{Union{typeof(padding),rettype}}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in span:n
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad the last entries, move windowed data back to the first entries

function padfinal_tiling(func::Function, span::Span, data::AbstractMatrix{T}, weight::Weighting{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfinal_tiling(func, span, ᵛʷdata, ᵛʷweight)
end

function padfinal_tiling(func::Function, span::Span, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}, padding) where {T}
    n = nrows(ᵛʷdata)
    nvalues = nrolled(n, span)
    rettype = Union{typeof(padding),rts(func, (T,))}

    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    # this is the padding_span
    padding_span = span - 1
    padding_idxs = n-padding_span:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in 1:n-padding_span
        @views results[idx, :] = map(func, eachcol(ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

