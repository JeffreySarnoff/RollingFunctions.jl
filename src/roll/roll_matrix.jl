function basic_rolling(func::F, width::Integer, data::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    # there are 1 or more columns, each holds `n` values
    rettype = rts(func, (T,))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padfirst_rolling(func::F, width::Integer, data::AbstractMatrix{T}, padding) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = Union{typeof(padding),rts(func, (T,))}
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the padding_width
    padding_width = width - 1
    padding_idxs = 1:padding_width

    results = Matrix{Union{typeof(padding),rettype}}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the last entries, move windowed data back to the first entries

function padfinal_rolling(func::F, width::Integer, data::AbstractMatrix{T}, padding) where {T, F<:Function}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = Union{typeof(padding),rts(func, (T,))}

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the padding_width
    padding_width = width - 1
    padding_idxs = n-padding_width:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-padding_width
        @views results[idx, :] = map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# weighted

function basic_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T, F<:Function}
    colcount = ncols(data)
    mweights = reshape(repeat(Vector(weight), colcount), (length(weight), colcount))

    basic_rolling(func, width, data, mweights)
end

function basic_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, weights::VectorOfWeightVectors{T}) where {T, F<:Function}
    mweights = vvmatrix(weights)
    basic_rolling(func, width, data, mweights)
end

@inline function basic_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, weights::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weights)

    basic_rolling(func, width, ᵛʷdata, ᵛʷweights)
end

@inline function basic_rolling(func::F, width::Integer, 
                       ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}) where {T, F<:Function}
    rowcount, colcount = size(ᵛʷdata)
    nvalues = rolling_wholes(rowcount, width)
    rettype = rts(func, (T,))
    results = newmatrix(rettype, (nvalues, colcount))

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(func, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = T === typ ? asview(weight) : asview([typ(x) for x in weight])

    basic_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

basic_rolling(func::F, width::Integer, data::ViewOfMatrix{T}, weight::AbstractWeights{T}) where {T, F<:Function} =
    basic_rolling(func, width, data, asview(Vector(weight))) 

basic_rolling(func::F, width::Integer, data::Matrix{T}, weight::ViewOfMatrix{T}) where {T, F<:Function} =
    basic_rolling(func, width, asview(data), weight)

basic_rolling(func::F, width::Integer, data::Matrix{T}, weight::ViewOfWeights{T}) where {T, F<:Function} =
    basic_rolling(func, width, asview(data), asview(Vector(weight)))

#
# pad the start (first observations) with a given padding value
#

function padfirst_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, weight::AbstractWeights{T}, padding) where {T, F<:Function}
    colcount = ncols(data)
    mweights = reshape(repeat(Vector(weight), colcount), (length(weight), colcount))

    padfirst_rolling(func, width, data, mweights, padding)
end

function padfirst_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, weights::VectorOfWeightVectors{T}, padding) where {T, F<:Function}
    mweights = vvmatrix(weights)
    padfirst_rolling(func, width, data, mweights, padding)
end

@inline function padfirst_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, weights::AbstractMatrix{T}, padding) where {T, F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weights)

    padfirst_rolling(func, width, ᵛʷdata, ᵛʷweights, padding)
end

@inline function padfirst_rolling(func::F, width::Integer, 
                       ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}, padding) where {T, F<:Function}
    rowcount, colcount = size(ᵛʷdata)
    nvalues = rolling_wholes(rowcount, width)
    rettype = rts(func, (T,))
    results = newmatrix(rettype, size(ᵛʷdata))

    padding_idxs = 1:(width - 1)
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(func, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, weight::AbstractWeights{W}, padding) where {T, W, F<:Function}
    typ = promote_type(T, W)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = T === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfirst_rolling(func, width, ᵛʷdata, ᵛʷweight, padding)
end

padfirst_rolling(func::F, width::Integer, data::ViewOfMatrix{T}, weight::AbstractWeights{T}, padding) where {T, F<:Function} =
    padfirst_rolling(func, width, data, asview(Vector(weight)), padding) 

padfirst_rolling(func::F, width::Integer, data::Matrix{T}, weight::ViewOfMatrix{T}, padding) where {T, F<:Function} =
    padfirst_rolling(func, width, asview(data), weight, padding)

padfirst_rolling(func::F, width::Integer, data::Matrix{T}, weight::ViewOfWeights{T}, padding) where {T, F<:Function} =
    padfirst_rolling(func, width, asview(data), asview(Vector(weight)), padding)

#
# pad the end (last observations) with a given padding value
#

function padlast_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, weight::AbstractWeights{T}, padding) where {T, F<:Function}
    colcount = ncols(data)
    mweights = reshape(repeat(Vector(weight), colcount), (length(weight), colcount))

    padlast_rolling(func, width, data, mweights, padding)
end

function padlast_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, weights::VectorOfWeightVectors{T}, padding) where {T, F<:Function}
    mweights = vvmatrix(weights)
    padlast_rolling(func, width, data, mweights, padding)
end

@inline function padlast_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, weights::AbstractMatrix{T}, padding) where {T, F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weights)

    padlast_rolling(func, width, ᵛʷdata, ᵛʷweights, padding)
end

@inline function padlast_rolling(func::F, width::Integer, 
                       ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}, padding) where {T, F<:Function}
    rowcount, colcount = size(ᵛʷdata)
    nvalues = rolling_wholes(rowcount, width)
    rettype = rts(func, (T,))
    results = newmatrix(rettype, size(ᵛʷdata))

    padding_width = width - 1
    padding_idxs = (n-padding_width):n

    results = Matrix{rettype}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-padding_width
        @views results[idx, :] = map(func, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padlast_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, weight::AbstractWeights{W}, padding) where {T, W, F<:Function}
    typ = promote_type(T, W)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = T === typ ? asview(weight) : asview([typ(x) for x in weight])

    padlast_rolling(func, width, ᵛʷdata, ᵛʷweight, padding)
end

padlast_rolling(func::F, width::Integer, data::ViewOfMatrix{T}, weight::AbstractWeights{T}, padding) where {T, F<:Function} =
    padlast_rolling(func, width, data, asview(Vector(weight)), padding) 

padlast_rolling(func::F, width::Integer, data::Matrix{T}, weight::ViewOfMatrix{T}, padding) where {T, F<:Function} =
    padlast_rolling(func, width, asview(data), weight, padding)

padlast_rolling(func::F, width::Integer, data::Matrix{T}, weight::ViewOfWeights{T}, padding) where {T, F<:Function} =
    padlast_rolling(func, width, asview(data), asview(Vector(weight)), padding)




#=






# pad the last entries, move windowed data back to the first entries

function padfinal_rolling(func::F, width::Integer,
                          data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T, F<:Function}
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = asview(data)
    ᵛʷweight = asview(w)

    padfinal_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_rolling(func::F, width::Integer,
                          data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    padfinal_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_rolling(func::F, width::Integer, 
                          ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}, padding) where {T, F<:Function}
    n = nrows(ᵛʷdata)
    nvalues = nrolled(n, width)
    rettype = Union{typeof(padding),rts(func, (T,))}

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the padding_width
    padding_width = width - 1
    padding_idxs = n-padding_width:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-padding_width
        @views results[idx, :] = map(func, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# weighted with vector of weights

function basic_rolling(func::F, width::Integer,
                       data::AbstractMatrix{T}, 
                       weights::Vector{A}) where {T, A<:AbstractWeights{T}}
    check_size((width, ncols(data)), (length(weights), length(weights[1])))
    nc = ncols(data)
    ᵛʷdata = asview(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)
    ᵛʷweight = asview(weight)

    basic_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function basic_rolling(func::F, width::Integer,
    data::AbstractMatrix{T}, weight::Vector{AbstractWeights{W}}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    basic_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function basic_rolling(func::F, width::Integer, 
                       ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}) where {T, F<:Function}
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    # there are 1 or more columns, each holds `n` values
    rettype = rts(func, (T,))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(func, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padfirst_rolling(func::F, width::Integer,
                          data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T, F<:Function}
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = asview(data)
    ᵛʷweight = asview(w)

    padfirst_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfirst_rolling(func::F, width::Integer, 
                          data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    padfirst_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfirst_rolling(func::F, width::Integer, 
                          ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T, F<:Function}
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    rettype = Union{typeof(padding),rts(func, (T,))}
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the padding_width
    padding_width = width - 1
    padding_idxs = 1:padding_width

    results = Matrix{Union{typeof(padding),rettype}}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx, :] .= map(func, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad the last entries, move windowed data back to the first entries

function padfinal_rolling(func::F, width::Integer,
                          data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T, F<:Function}
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = asview(data)
    ᵛʷweight = asview(w)

    padfinal_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_rolling(func::F, width::Integer,
                          data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    padfinal_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_rolling(func::F, width::Integer, 
                          ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}, padding) where {T, F<:Function}
    n = nrows(ᵛʷdata)
    nvalues = nrolled(n, width)
    rettype = Union{typeof(padding),rts(func, (T,))}

    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the padding_width
    padding_width = width - 1
    padding_idxs = n-padding_width:n

    results = Matrix{rettype}(undef, size(ᵛʷdata))
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:n-padding_width
        @views results[idx, :] = map(func, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

=#