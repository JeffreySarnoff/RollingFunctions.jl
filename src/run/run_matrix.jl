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
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# weighted

function taperfirst(func::F, width::Width, data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])
    ᵛʷweights = reshape(repeat(ᵛʷweight, ncols(ᵛʷdata)), (width, ncols(ᵛʷdata)))

    taperfirst(func, width, ᵛʷdata, ᵛʷweights)
end

function taperfirst(func::F, width::Width, data::AbstractMatrix{T}, weights::Vector{<:AbstractWeights{W}}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweights = W === typ ? asview(map(asview, Vector.(weights))) : asview(map(asview, [typ(x) for x in Vector.(weights)]))

    taperfirst(func, width, ᵛʷdata, ᵛʷweights)
end

function taperfinal(func::F, width::Width, data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])
    ᵛʷweights = reshape(repeat(ᵛʷweight, ncols(ᵛʷdata)), (width, ncols(ᵛʷdata)))

    taperfinal(func, width, ᵛʷdata, ᵛʷweights)
end

function taperfinal(func::F, width::Width, data::AbstractMatrix{T}, weights::Vector{<:AbstractWeights{W}}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweights = W === typ ? asview(map(asview, Vector.(weights))) : asview(map(asview, [typ(x) for x in Vector.(weights)]))

    taperfinal(func, width, ᵛʷdata, ᵛʷweights)
end

# views as arguments

function taperfirst(func::F, width::Width, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweights::ViewOfViewedVectors{T}) where {T,F<:Function}
    n = nrows(ᵛʷdata)
    nc = ncols(ᵛʷdata)
    rettype = rts(func, (T,))
    results = Matrix{rettype}(undef, (n, nc))

    weights = reshape(repeat(ᵛʷweights, nc), (width, nc))
    # only completed width coverings are fully resolvable
    # the first (width - 1) values are to be tapered
    taper_idxs = 1:width-1

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    ilow = 1
    @inbounds for idx in taper_idxs
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:idx, :]) .* normalize(ᵛʷweights[1:idx,:]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]) .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfinal(func::F, width::Width, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweights::ViewOfViewedVectors{T}) where {T,F<:Function}
    n = nrows(ᵛʷdata)
    rettype = rts(func, (T,))

    # only completed width coverings are fully resolvable
    # the last (width - 1) values are to be tapered
    taper_idxs = n-width+2:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    @inbounds for idx in taper_idxs
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[idx:n, :]) .* normalize(ᵛʷweights[n:-1:idx]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-width+1
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]) .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

