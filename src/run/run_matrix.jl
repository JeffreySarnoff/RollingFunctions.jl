#=
     taperfirst(func::F, width, ::Matrix)
     taperfinal(func::F, width, ::Matrix)

     taperfirst(func::F, width, ::Matrix, weight)
     taperfinal(func::F, width, ::Matrix, weight)
=#

function taperfirst(func::F, width::Width, data::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    rettype = rts(func, (T,))
    results = Matrix{rettype}(undef, (n, ncols(ᵛʷdata)))

    # only completed width coverings are fully resolvable
    # the first (width - 1) values are to be tapered
    taper_idxs = 1:width-1

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    ilow = 1
    @inbounds for idx in taper_idxs
       @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:idx, :]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfinal(func::F, width::Width, data::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    rettype = rts(func, (T,))

    # only completed width coverings are fully resolvable
    # the last (width - 1) values are to be tapered
    taper_idxs = n-width+2:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    @inbounds for idx in taper_idxs
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[idx:n, :]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-width+1
        @views results[idx, :] = map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

   results
end


# taper the dropped indicies with a given tapering value

#=
function taperfirst(func::Function, width::Width, data::AbstractMatrix{T}) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = rts(func, (T,))
    results = Matrix{rettype}(undef, (n, ncols(ᵛʷdata)))

    # only completed width coverings are fully resolvable
    # the first (width - 1) values are to be tapered
    taper_idxs = 1:width-1

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    ilow = 1
    @inbounds for idx in taper_idxs
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:idx, :]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# taper the last entries, move windowed data back to the first entries

function taperfinal(func::F, width::Width, data::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = rts(func, (T,))

    # only completed width coverings are fully resolvable
    # the last (width - 1) values are to be tapered
    taper_idxs = n-width+2:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    @inbounds for idx in taper_idxs
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[idx:n, :]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-width+1
        @views results[idx, :] = map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# weighted

# taper the dropped indicies with a given tapering value

function taperfirst(func::F, width::Width, data::AbstractMatrix{T}, weights::Weighting{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    taperfirst(func, width, ᵛʷdata, ᵛʷweight)
end

function taperfirst(func::F, width::Width, data::ViewOfMatrix{T}, weight::ViewOfWeights{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = rts(func, (T,))
    results = Matrix{rettype}(undef, (n, ncols(ᵛʷdata)))

    # only completed width coverings are fully resolvable
    # the first (width - 1) values are to be tapered
    taper_idxs = 1:width-1

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    ilow = 1
    @inbounds for idx in taper_idxs
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:idx, :]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# taper the last entries, move windowed data back to the first entries

function taperfinal(func::F, width::Width, data::AbstractMatrix{T}, weight::Weighting{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    taperfinal(func, width, ᵛʷdata, ᵛʷweight)
end

function taperfinal(func::F, width::Width, data::ViewOfMatrix{T}, weight::ViewOfWeights{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = rts(func, (T,))

    # only completed width coverings are fully resolvable
    # the last (width - 1) values are to be tapered
    taper_idxs = n-width+2:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    @inbounds for idx in taper_idxs
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[idx:n, :]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-width+1
        @views results[idx, :] = map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

#=

function taperfirst(func::F, width::Width, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T, F<:Function}
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = rts(func, (T,))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the tapering_width
    tapering_width = width - 1
    tapering_idxs = 1:tapering_width

    results = Matrix{rettype}(undef, size(ᵛʷdata))
    results[tapering_idxs, :] .= taperfirst(func, width, ᵛʷdata, ᵛʷweight)

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# taper the last entries, move windowed data back to the first entries

function taperfinal(func::F, width::Width, data::AbstractMatrix{T}, weight::Weighting{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    taperfinal(func, width, ᵛʷdata, ᵛʷweight)
end

function taperfinal(func::F, width::Width, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T, F<:Function}
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = rts(func, (T,))

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the tapering_width
    tapering_width = width - 1
    tapering_idxs = n-tapering_width:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))
    results[tapering_idxs, :] .= taperfinal(func, width, ᵛʷdata, ᵛʷweight)

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-tapering_width
        @views results[idx, :] = map(func, eachcol(ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

=#
