
function basic_rolling(func::F, width::Integer,
    data1::AbstractVector{T}, weight::AbstractWeights{T}) where {T, F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    basic_rolling(func, width, ᵛʷdata1, ᵛʷweight)
end

function basic_rolling(func::F, width::Integer,
    data1::AbstractVector{T}, data2::AbstractVector{T}, weight1::AbstractWeights{T}) where {T, F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)

    basic_rolling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight1)
end

function basic_rolling(func::F, width::Integer,
    data1::AbstractVector{T}, data2::AbstractVector{T}, weight1::AbstractWeights{T}, weight2::AbstractWeights{T}) where {T, F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    basic_rolling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
end

function basic_rolling(func::F, width::Integer,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::AbstractWeights{T}) where {T, F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)

    basic_rolling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight1, ᵛʷweight1)
end

function basic_rolling(func::F, width::Integer,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::AbstractWeights{T}, weight2::AbstractWeights{T}, weight3::AbstractWeights{T}) where {T, F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)
    ᵛʷweight3 = asview(weight3)

    basic_rolling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
end

function basic_rolling(func::F, width::Integer,
    data1::AbstractVector{T}, weight::AbstractWeights{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    basic_rolling(func, width, ᵛʷdata1, ᵛʷweight)
end

function basic_rolling(func::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    basic_rolling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
end

function basic_rolling(func::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}, weight3::AbstractWeights{W3}) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    basic_rolling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
end

# pad first

function padfirst_rolling(func::F, width::Integer, data1::AbstractVector{T},
    weight::AbstractWeights{T}, padding) where {T, F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    padfirst_rolling(func, width, ᵛʷdata1, ᵛʷweight, padding)
end

function padfirst_rolling(func::F, width::Integer,
    data1::AbstractVector{T}, weight::AbstractWeights{W}, padding) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfirst_rolling(func, width, ᵛʷdata1, ᵛʷweight, padding)
end

function padfirst_rolling(func::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}, padding) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    padfirst_rolling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2, padding)
end

function padfirst_rolling(func::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}, weight3::AbstractWeights{W3}, padding) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    padfirst_rolling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3, padding)
end


# pad final

function padfinal_rolling(func::F, width::Integer, data1::AbstractVector{T},
    weight::AbstractWeights{T}, padding) where {T, F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    padfinal_rolling(func, width, ᵛʷdata1, ᵛʷweight, padding)
end

function padfinal_rolling(func::F, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T},
    weight1::AbstractWeights{T}, weight2::AbstractWeights{T}, padding) where {T, F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    padfinal_rolling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2, padding)
end

function padfinal_rolling(func::F, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::AbstractWeights{T}, weight2::AbstractWeights{T}, weight3::AbstractWeights{T}, padding) where {T, F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)
    ᵛʷweight3 = asview(weight3)

    padfinal_rolling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3, padding)
end


function padfinal_rolling(func::F, width::Integer,
    data1::AbstractVector{T}, weight::AbstractWeights{W}, padding) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfinal_rolling(func, width, ᵛʷdata1, ᵛʷweight, padding)
end

function padfinal_rolling(func::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}, padding) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    padfinal_rolling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2, padding)
end

function padfinal_rolling(func::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}, weight3::AbstractWeights{W3}, padding) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    padfinal_rolling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3, padding)
end

# IMPLEMENTATIONS

# basic_rolling implementations

function basic_rolling(func::F, width::Integer,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷweight::ViewOfWeights{T}) where {T, F<:Function}
    n = length(ᵛʷdata1)
    check_width(n, width)
    check_weights(length(ᵛʷweight), width)

    nvalues = rolling_wholes(n, width)

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}) where {T, F<:Function}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), width)
    check_weights(length(ᵛʷweight2), width)

    nvalues = rolling_wholes(n, width)

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, ᵛʷweight3::ViewOfWeights{T}) where {T, F<:Function}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), width)
    check_weights(length(ᵛʷweight2), width)
    check_weights(length(ᵛʷweight3), width)

    nvalues = rolling_wholes(n, width)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad first implementations

function padfirst_rolling(func::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷweight::ViewOfWeights{T}, padding) where {T, F<:Function}
    n = length(ᵛʷdata1)
    check_width(n, width)
    check_weights(length(ᵛʷweight), width)

    nvalues = rolling_wholes(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    padding_width = width - 1
    padding_idxs = nvalues-padding_width:nvalues

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inline for idx in width:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::F, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T},
    weight1::AbstractWeights{T}, weight2::AbstractWeights{T}, padding) where {T, F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), length(ᵛʷweight2), width)

    nvalues = rolling_wholes(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    padding_width = width - 1
    padding_idxs = nvalues-padding_width:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues-padding_width
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::F, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::AbstractWeights{T}, weight2::AbstractWeights{T}, weight3::AbstractWeights{T}, padding) where {T, F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)
    ᵛʷweight3 = asview(weight3)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), length(ᵛʷweight2), length(ᵛʷweight3), width)

    nvalues = rolling_wholes(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    padding_width = width - 1
    padding_idxs = nvalues-padding_width:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues-padding_width
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad final implementations

function padfinal_rolling(func::F, width::Integer, ᵛʷdata1::ViewOfVector{T},
    ᵛʷweight::ViewOfWeights{T}, padding) where {T, F<:Function}
    n = length(ᵛʷdata1)
    check_width(n, width)
    check_weights(length(ᵛʷweight), width)

    nvalues = rolling_wholes(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    padding_width = width - 1
    padding_idxs = n-padding_width-1:n

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, padding) where {T, F<:Function}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), width)
    check_weights(length(ᵛʷweight2), width)

    nvalues = rolling_wholes(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    padding_width = width - 1
    padding_idxs = n-padding_width-1:n

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, ᵛʷweight3::ViewOfWeights{T}, padding) where {T, F<:Function}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), width)
    check_weights(length(ᵛʷweight2), width)
    check_weights(length(ᵛʷweight3), width)

    nvalues = rolling_wholes(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    padding_width = width - 1
    padding_idxs = n-padding_width-1:n

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end
