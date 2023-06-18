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

# weighted

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weighting::AbstractWeights{T}) where {T, F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(weighting, colcount)

    basic_rolling(fn, width, data, mweights)
end

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weights::VectorOfVectors{T}) where {T, F<:Function}
    mweights = vmatrix(weights)

    basic_rolling(fn, width, data, mweights)
end

@inline function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weights::AbstractMatrix{T}) where {T, F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weights)

    basic_rolling(fn, width, ᵛʷdata, ᵛʷweights)
end

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T, W, F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(Vector{T}(wieghting), colcount)

    basic_rolling(fn, width, data, mweights)
end

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weights::VectorOfVectors{W}) where {T, W, F<:Function}
    mweights = Matrix{T}(vmatrix(weights))

    basic_rolling(fn, width, data, mweights)
end

@inline function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weights::AbstractMatrix{W}) where {T, W, F<:Function}
    mweights = Matrix{T}(weights)

    basic_rolling(fn, width, data, weights)
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

#=
function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T, W, F<:Function}
    colcount = ncols(data)
    typ = promote_type(T, W)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    vweight = Vector{typ}(weight)
    ᵛʷweights = asview(reshape(repeat(vweight, colcount), (length(vweight), colcount)))

    basic_rolling(fn, width, ᵛʷdata, ᵛʷweights)
end

basic_rolling(fn::F, width::Integer, data::ViewOfMatrix{T}, weight::AbstractWeights{T}) where {T, F<:Function} =
    basic_rolling(fn, width, data, asview(Vector(weight))) 

basic_rolling(fn::F, width::Integer, data::Matrix{T}, weight::ViewOfMatrix{T}) where {T, F<:Function} =
    basic_rolling(fn, width, asview(data), weight)

basic_rolling(fn::F, width::Integer, data::Matrix{T}, weight::ViewOfWeights{T}) where {T, F<:Function} =
    basic_rolling(fn, width, asview(data), asview(Vector(weight)))

=#
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
    data::AbstractMatrix{T}, weights::VectorOfVectors{T}) where {T,F<:Function}
    mweights = vmatrix(weights)

    padfirst_rolling(fn, width, data, mweights)
end

@inline function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weights)

    padfirst_rolling(fn, width, ᵛʷdata, ᵛʷweights)
end

function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T,W,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(Vector{T}(wieghting), colcount)

    padfirst_rolling(fn, width, data, mweights)
end

function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::VectorOfVectors{W}) where {T,W,F<:Function}
    mweights = Matrix{T}(vmatrix(weights))

    padfirst_rolling(fn, width, data, mweights)
end

@inline function padfirst_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::AbstractMatrix{W}) where {T,W,F<:Function}
    mweights = Matrix{T}(weights)

    padfirst_rolling(fn, width, data, weights)
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

#=

function padfirst_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weight::AbstractWeights{W}, padding) where {T, W, F<:Function}
    typ = promote_type(T, W)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = T === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfirst_rolling(fn, width, ᵛʷdata, ᵛʷweight, padding)
end

padfirst_rolling(fn::F, width::Integer, data::ViewOfMatrix{T}, weight::AbstractWeights{T}, padding) where {T, F<:Function} =
    padfirst_rolling(fn, width, data, asview(Vector(weight)), padding) 

padfirst_rolling(fn::F, width::Integer, data::Matrix{T}, weight::ViewOfMatrix{T}, padding) where {T, F<:Function} =
    padfirst_rolling(fn, width, asview(data), weight, padding)

padfirst_rolling(fn::F, width::Integer, data::Matrix{T}, weight::ViewOfWeights{T}, padding) where {T, F<:Function} =
    padfirst_rolling(fn, width, asview(data), asview(Vector(weight)), padding)
=#


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
    data::AbstractMatrix{T}, weights::VectorOfVectors{T}) where {T,F<:Function}
    mweights = vmatrix(weights)

    padfinal_rolling(fn, width, data, mweights)
end

@inline function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::AbstractMatrix{T}) where {T,F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weights)

    padfinal_rolling(fn, width, ᵛʷdata, ᵛʷweights)
end

function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weighting::AbstractWeights{W}) where {T,W,F<:Function}
    colcount = ncols(data)
    mweights = vmatrix(Vector{T}(wieghting), colcount)

    padfinal_rolling(fn, width, data, mweights)
end

function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::VectorOfVectors{W}) where {T,W,F<:Function}
    mweights = Matrix{T}(vmatrix(weights))

    padfinal_rolling(fn, width, data, mweights)
end

@inline function padfinal_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::AbstractMatrix{W}) where {T,W,F<:Function}
    mweights = Matrix{T}(weights)

    padfinal_rolling(fn, width, data, weights)
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


#=
function padlast_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weight::AbstractWeights{T}, padding) where {T, F<:Function}
    colcount = ncols(data)
    mweights = reshape(repeat(Vector(weight), colcount), (length(weight), colcount))

    padlast_rolling(fn, width, data, mweights, padding)
end

function padlast_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weights::VectorOfVectors{T}, padding) where {T, F<:Function}
    mweights = vmatrix(weights)
    padlast_rolling(fn, width, data, mweights, padding)
end

@inline function padlast_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weights::AbstractMatrix{T}, padding) where {T, F<:Function}
    ᵛʷdata = asview(data)
    ᵛʷweights = asview(weights)

    padlast_rolling(fn, width, ᵛʷdata, ᵛʷweights, padding)
end

@inline function padlast_rolling(fn::F, width::Integer, 
                       ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}, padding) where {T, F<:Function}
    rowcount, colcount = size(ᵛʷdata)
    nvalues = rolling_wholes(rowcount, width)
    rettype = rts(fn, (T,))
    results = newmatrix(rettype, size(ᵛʷdata))

    padding_width = width - 1
    padding_idxs = (n-padding_width):n

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

function padlast_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, weight::AbstractWeights{W}, padding) where {T, W, F<:Function}
    typ = promote_type(T, W)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = T === typ ? asview(weight) : asview([typ(x) for x in weight])

    padlast_rolling(fn, width, ᵛʷdata, ᵛʷweight, padding)
end

padlast_rolling(fn::F, width::Integer, data::ViewOfMatrix{T}, weight::AbstractWeights{T}, padding) where {T, F<:Function} =
    padlast_rolling(fn, width, data, asview(Vector(weight)), padding) 

padlast_rolling(fn::F, width::Integer, data::Matrix{T}, weight::ViewOfMatrix{T}, padding) where {T, F<:Function} =
    padlast_rolling(fn, width, asview(data), weight, padding)

padlast_rolling(fn::F, width::Integer, data::Matrix{T}, weight::ViewOfWeights{T}, padding) where {T, F<:Function} =
    padlast_rolling(fn, width, asview(data), asview(Vector(weight)), padding)

=#


#=






# pad the last entries, move windowed data back to the first entries

function padfinal_rolling(fn::F, width::Integer,
                          data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T, F<:Function}
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = asview(data)
    ᵛʷweight = asview(w)

    padfinal_rolling(fn, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_rolling(fn::F, width::Integer,
                          data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    padfinal_rolling(fn, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_rolling(fn::F, width::Integer, 
                          ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}, padding) where {T, F<:Function}
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

# weighted with vector of weights

function basic_rolling(fn::F, width::Integer,
                       data::AbstractMatrix{T}, 
                       weights::Vector{A}) where {T, A<:AbstractWeights{T}}
    check_size((width, ncols(data)), (length(weights), length(weights[1])))
    nc = ncols(data)
    ᵛʷdata = asview(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)
    ᵛʷweight = asview(weight)

    basic_rolling(fn, width, ᵛʷdata, ᵛʷweight)
end

function basic_rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weight::Vector{AbstractWeights{W}}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    basic_rolling(fn, width, ᵛʷdata, ᵛʷweight)
end

function basic_rolling(fn::F, width::Integer, 
                       ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}) where {T, F<:Function}
    n = nrows(ᵛʷdata)
    nvalues = rolling_wholes(n, width)
    # there are 1 or more columns, each holds `n` values
    rettype = rts(fn, (T,))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(fn, ᵛʷdata[ilow:ihigh, :] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padfirst_rolling(fn::F, width::Integer,
                          data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T, F<:Function}
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = asview(data)
    ᵛʷweight = asview(w)

    padfirst_rolling(fn, width, ᵛʷdata, ᵛʷweight)
end

function padfirst_rolling(fn::F, width::Integer, 
                          data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    padfirst_rolling(fn, width, ᵛʷdata, ᵛʷweight)
end

function padfirst_rolling(fn::F, width::Integer, 
                          ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T, F<:Function}
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


# pad the last entries, move windowed data back to the first entries

function padfinal_rolling(fn::F, width::Integer,
                          data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T, F<:Function}
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = asview(data)
    ᵛʷweight = asview(w)

    padfinal_rolling(fn, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_rolling(fn::F, width::Integer,
                          data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T, W, F<:Function}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    padfinal_rolling(fn, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_rolling(fn::F, width::Integer, 
                          ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}, padding) where {T, F<:Function}
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

=#