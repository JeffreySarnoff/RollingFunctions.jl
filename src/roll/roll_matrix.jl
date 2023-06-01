#=
     basic_rolling(func::Function, width, ::Matrix)
     padfirst_rolling(func::Function, width, ::Matrix; padding)
     padfinal_rolling(func::Function, width, ::Matrix; padding)

     basic_rolling(func::Function, width, ::Matrix, ::AbstractWeights)
     padfirst_rolling(func::Function, width, ::Matrix, ::AbstractWeights; padding)
     padfinal_rolling(func::Function, width, ::Matrix, ::AbstractWeights; padding)

     basic_rolling(func::Function, width, ::Matrix, ::Vector{AbstractWeights})
     padfirst_rolling(func::Function, width, ::Matrix, ::Vector{AbstractWeights}; padding)
     padfinal_rolling(func::Function, width, ::Matrix, ::Vector{AbstractWeights}; padding)
=#

function basic_rolling(func::Function, width::Width, data::AbstractMatrix{T}) where {T}
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

function padfirst_rolling(func::Function, width::Width, data::AbstractMatrix{T}, padding) where {T}
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

function padfinal_rolling(func::Function, width::Width, data::AbstractMatrix{T}, padding) where {T}
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

function basic_rolling(func::Function, width::Width,
                       data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T}
    nc = ncols(data)
    ᵛʷdata = asview(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)
    ᵛʷweight = asview(weight)

    basic_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function basic_rolling(func::Function, width::Width,
    data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T,W}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    basic_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function basic_rolling(func::Function, width::Width, 
                       ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}) where {T}
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

function padfirst_rolling(func::Function, width::Width,
                          data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T}
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = asview(data)
    ᵛʷweight = asview(w)

    padfirst_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfirst_rolling(func::Function, width::Width, 
                          data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T,W}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    padfirst_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfirst_rolling(func::Function, width::Width, 
                          ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T}
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

function padfinal_rolling(func::Function, width::Width,
                          data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T}
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = asview(data)
    ᵛʷweight = asview(w)

    padfinal_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_rolling(func::Function, width::Width,
                          data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T,W}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    padfinal_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_rolling(func::Function, width::Width, 
                          ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}, padding) where {T}
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

function basic_rolling(func::Function, width::Width,
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

function basic_rolling(func::Function, width::Width,
    data::AbstractMatrix{T}, weight::Vector{AbstractWeights{W}}) where {T,W}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)
    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    basic_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function basic_rolling(func::Function, width::Width, 
                       ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}) where {T}
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

function padfirst_rolling(func::Function, width::Width,
                          data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T}
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = asview(data)
    ᵛʷweight = asview(w)

    padfirst_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfirst_rolling(func::Function, width::Width, 
                          data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T,W}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    padfirst_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfirst_rolling(func::Function, width::Width, 
                          ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfWeights{T}) where {T}
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

function padfinal_rolling(func::Function, width::Width,
                          data::AbstractMatrix{T}, weight::AbstractWeights{T}) where {T}
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = asview(data)
    ᵛʷweight = asview(w)

    padfinal_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_rolling(func::Function, width::Width,
                          data::AbstractMatrix{T}, weight::AbstractWeights{W}) where {T,W}
    typ = promote_type(T, W)
    nc = ncols(data)
    wlen_ncols = (length(weight), nc)
    w = reshape(repeat(weight, nc), wlen_ncols)

    ᵛʷdata = T === typ ? asview(data) : asview([typ(x) for x in data])
    ᵛʷweight = W === typ ? asview(w) : asview([typ(x) for x in w])

    padfinal_rolling(func, width, ᵛʷdata, ᵛʷweight)
end

function padfinal_rolling(func::Function, width::Width, 
                          ᵛʷdata::ViewOfMatrix{T}, ᵛʷweight::ViewOfMatrix{T}, padding) where {T}
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

