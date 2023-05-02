#=
     taperfirst_running(func::F, width, ::Matrix)
     taperfinal_running(func::F, width, ::Matrix)

     taperfirst_running(func::F, width, ::Matrix, weight)
     taperfinal_running(func::F, width, ::Matrix, weight)
=#


# taper the dropped indicies with a given tapering value

function taperfirst_running(func::F, width::Width, data::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = nrolling(n, width)
    rettype = Union{typeof(tapering),rts(func, (T,))}
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the tapering_width
    tapering_width = width - 1
    tapering_idxs = 1:tapering_width

    results = Matrix{Union{typeof(tapering),rettype}}(undef, size(ᵛʷdata))
    results[tapering_idxs, :] .= tapering

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# taper the last entries, move windowed data back to the first entries

function taperfinal_running(func::F, width::Width, data::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = nrolling(n, width)
    rettype = Union{typeof(tapering),rts(func, (T,))}

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the tapering_width
    tapering_width = width - 1
    tapering_idxs = n-tapering_width:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))
    results[tapering_idxs, :] .= tapering

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-tapering_width
        @views results[idx, :] = map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# weighted

# taper the dropped indicies with a given tapering value

function taperfirst_running(func::F, width::Width, data::AbstractMatrix{T}, weight::Weighting{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    taperfirst_running(func, width, ᵛʷdata, ᵛʷweight)
end

function taperfirst_running(func::F, width::Width, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T, F<:Function}
    n = nrows(ᵛʷdata)
    nvalues = nrolling(n, width)
    rettype = Union{typeof(tapering),rts(func, (T,))}
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the tapering_width
    tapering_width = width - 1
    tapering_idxs = 1:tapering_width

    results = Matrix{Union{typeof(tapering),rettype}}(undef, size(ᵛʷdata))
    results[tapering_idxs, :] .= tapering

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# taper the last entries, move windowed data back to the first entries

function taperfinal_running(func::F, width::Width, data::AbstractMatrix{T}, weight::Weighting{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    taperfinal_running(func, width, ᵛʷdata, ᵛʷweight)
end

function taperfinal_running(func::F, width::Width, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T, F<:Function}
    n = nrows(ᵛʷdata)
    nvalues = nrolling(n, width)
    rettype = Union{typeof(tapering),rts(func, (T,))}

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the tapering_width
    tapering_width = width - 1
    tapering_idxs = n-tapering_width:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))
    results[tapering_idxs, :] .= tapering

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-tapering_width
        @views results[idx, :] = map(func, eachcol(ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

