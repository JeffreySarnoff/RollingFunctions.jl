#=
     taperfirst(fn::F, width, ::Matrix)
     taperfinal(fn::F, width, ::Matrix)

     taperfirst(fn::F, width, ::Matrix, weight)
     taperfinal(fn::F, width, ::Matrix, weight)
=#

function taperfirst(fn::F, width::Integer, data::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    rettype = rts(fn, (T,))

    # only completed width coverings are fully resolvable
    # the first (width - 1) values are to be tapered
    taper_idxs = 1:width-1

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    ilow = 1
    @inbounds for idx in taper_idxs
       @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:idx, :]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfinal(fn::F, width::Integer, data::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    rettype = rts(fn, (T,))

    # only completed width coverings are fully resolvable
    # the last (width - 1) values are to be tapered
    taper_idxs = n-width+2:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    @inbounds for idx in taper_idxs
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[idx:n, :]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-width+1
        @views results[idx, :] .= map(fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# weighted

function taperfirst(fn::F, width::Integer, 
                    data::AbstractMatrix{T}, weight::AbstractWeights{W,W1}) where {T, W, W1, F<:Function}
    typ = promote_type(T, W1)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W1 === typ ? asview(weight) : asview([typ(x) for x in weight])
    ᵛʷweights = asview(repeat([ᵛʷweight], ncols(ᵛʷdata)))

    taperfirst(fn, width, ᵛʷdata, ᵛʷweights)
end

function taperfirst(fn::F, width::Integer, 
                    data::AbstractMatrix{T}, weights::Vector{<:AbstractWeights{W,W1}}) where {T, W, W1, F<:Function}
    typ = promote_type(T, W1)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweights = W1 === typ ? asview(Vector.(weights)) : asview([typ(x) for x in Vector.(weights)])

    taperfirst(fn, width, ᵛʷdata, ᵛʷweights)
end

function taperfinal(fn::F, width::Integer,
                    data::AbstractMatrix{T}, weight::AbstractWeights{W,W1}) where {T, W, W1, F<:Function}
    typ = promote_type(T, W1)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W1 === typ ? asview(weight) : asview([typ(x) for x in weight])
    ᵛʷweights = asview(repeat([ᵛʷweight], ncols(ᵛʷdata)))

    taperfinal(fn, width, ᵛʷdata, ᵛʷweights)
end

function taperfinal(fn::F, width::Integer,
                    data::AbstractMatrix{T}, weights::Vector{<:AbstractWeights{W,W1}}) where {T, W, W1, F<:Function}
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweights = W === typ ? asview(map(asview, Vector.(weights))) : asview(map(asview, [typ(x) for x in Vector.(weights)]))

    taperfinal(fn, width, ᵛʷdata, ᵛʷweights)
end

# views as arguments

function taperfirst(fn::F, width::Integer, 
                    ᵛʷdata::ViewOfMatrix{T}, ᵛʷweights::ViewOfViewedWeights{T}) where {T,F<:Function}
    rettype = rts(fn, (T,))
    results = Matrix{rettype}(undef, size(ᵛʷdata))

    # only completed width coverings are fully resolvable
    # the first (width - 1) values are to be tapered
    taper_idxs = 1:width-1

    ilow = 1
    @inbounds for idx in taper_idxs
        @views results[idx, :] = map(fn, vec(ᵛʷdata[ilow:idx, :]) .* normalize(vec(ᵛʷweights[1:idx,:])))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:nrows(ᵛʷdata)
        @views results[idx, :] = map(fn, vec(ᵛʷdata[ilow:ihigh, :]) .* vec(ᵛʷweights))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfinal(fn::F, width::Integer, ᵛʷdata::ViewOfMatrix{T}, ᵛʷweights::ViewOfViewedWeights{T}) where {T,F<:Function}
    n = nrows(ᵛʷdata)
    rettype = rts(fn, (T,))

    # only completed width coverings are fully resolvable
    # the last (width - 1) values are to be tapered
    taper_idxs = n-width+2:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))

    @inbounds for idx in taper_idxs
        @views results[idx, :] = map(fn, ᵛʷdata[idx:n, :] .* normalize(ᵛʷweights[n:-1:idx]))
    end

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-width+1
        @views results[idx, :] = map(fn, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

