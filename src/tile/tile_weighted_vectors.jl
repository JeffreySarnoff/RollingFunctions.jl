
function basic_tiling(func::Function, width::Width,
    data1::AbstractVector{T}, weight::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    basic_tiling(func, width, ᵛʷdata1, ᵛʷweight)
end

function basic_tiling(func::Function, width::Width,
    data1::AbstractVector{T}, data2::AbstractVector{T}, weight1::Weighting{T}, weight2::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    basic_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
end

function basic_tiling(func::Function, width::Width,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}, weight3::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)
    ᵛʷweight3 = asview(weight3)

    basic_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
end

function basic_tiling(func::Function, width::Width,
    data1::AbstractVector{T}, weight::Weighting{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    basic_tiling(func, width, ᵛʷdata1, ᵛʷweight)
end

function basic_tiling(func::Function, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::Weighting{W1}, weight2::Weighting{W2}) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    basic_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
end

function basic_tiling(func::Function, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::Weighting{W1}, weight2::Weighting{W2}, weight3::Weighting{W3}) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    basic_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
end

function basic_tiling(func::Function, width::Width,
    data1::ViewOfMatrix{T}, weight::ViewOfWeights{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    basic_tiling(func, width, ᵛʷdata1, ᵛʷweight)
end

# pad first

function padfirst_tiling(func::Function, width::Width, data1::AbstractVector{T},
    weight::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    padfirst_tiling(func, width, ᵛʷdata1, ᵛʷweight, padding)
end

function padfirst_tiling(func::Function, width::Width,
    data1::AbstractVector{T}, weight::Weighting{W}, padding) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfirst_tiling(func, width, ᵛʷdata1, ᵛʷweight, padding)
end

function padfirst_tiling(func::Function, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::Weighting{W1}, weight2::Weighting{W2}, padding) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    padfirst_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2, padding)
end

function padfirst_tiling(func::Function, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::Weighting{W1}, weight2::Weighting{W2}, weight3::Weighting{W3}, padding) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    padfirst_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3, padding)
end


function padfirst_tiling(func::Function, width::Width,
    data1::ViewOfMatrix{T}, weight::ViewOfWeights{W}, padding) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfirst_tiling(func, width, ᵛʷdata1, ᵛʷweight, padding)
end


# pad final

function padfinal_tiling(func::Function, width::Width, data1::AbstractVector{T},
    weight::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    padfinal_tiling(func, width, ᵛʷdata1, ᵛʷweight, padding)
end

function padfinal_tiling(func::Function, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    padfinal_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2, padding)
end

function padfinal_tiling(func::Function, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}, weight3::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)
    ᵛʷweight3 = asview(weight3)

    padfinal_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3, padding)
end


function padfinal_tiling(func::Function, width::Width,
    data1::AbstractVector{T}, weight::Weighting{W}, padding) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfinal_tiling(func, width, ᵛʷdata1, ᵛʷweight, padding)
end

function padfinal_tiling(func::Function, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::Weighting{W1}, weight2::Weighting{W2}, padding) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    padfinal_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2, padding)
end

function padfinal_tiling(func::Function, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::Weighting{W1}, weight2::Weighting{W2}, weight3::Weighting{W3}, padding) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    padfinal_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3, padding)
end

# IMPLEMENTATIONS

# basic_tiling implementations

function basic_tiling(func::Function, width::Width,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷweight1::ViewOfWeights{T}) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)
    check_weights(length(ᵛʷweight1), width)

    nvalues = tiling_wholes(n, width)

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1)
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

function basic_tiling(func::Function, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    w = min(length(ᵛʷweight1), length(ᵛʷweight2))
    check_width(n, width)
    check_weights(w, width)
 
    nvalues = tiling_wholes(n, width)

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2)
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

function basic_tiling(func::Function, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, ᵛʷweight3::ViewOfWeights{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    w = min(length(ᵛʷweight1), length(ᵛʷweight2), length(ᵛʷweight3))
    check_width(n, width)
    check_weights(w, width)

    nvalues = tiling_wholes(n, width)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end


# padfirst_tiling implementation

function padfirst_tiling(func::Function, width::Width,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷweight1::ViewOfWeights{T}, padding) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)
    check_weights(length(ᵛʷweight1), width)

    nvalues = tiling_wholes(n, width)
    if iszero(tiling_parts(n, width))
        return basic_tiling(func, width, ᵛʷdata1, ᵛʷweight1)
    end

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, nvalues+1)

    results[1] = padding

    ilow, ihigh = 1, width
    @inline for idx in 2:nvalues+1
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1)
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

function padfirst_tiling(func::Function, width::Width,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, 
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    w = min(length(ᵛʷweight1), length(ᵛʷweight2))
    check_width(n, width)
    check_weights(w, width)

    nvalues = tiling_wholes(n, width)
    if iszero(tiling_parts(n, width))
        return basic_tiling(func, width, ᵛʷdata1, ᵛʷweight1)
    end

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, nvalues+1)

    results[1] = padding

    ilow, ihigh = 1, width
    @inline for idx in 2:nvalues+1
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2)
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

function padfirst_tiling(func::Function, width::Width,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, ᵛʷweight3::ViewOfWeights{T},
    padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    w = min(length(ᵛʷweight1), length(ᵛʷweight2), length(ᵛʷweight3))
    check_width(n, width)
    check_weights(w, width)

    nvalues = tiling_wholes(n, width)
    if iszero(tiling_parts(n, width))
        return basic_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
    end

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, nvalues)

    results[1] = padding

    ilow, ihigh = 1, width
    @inline for idx in 2:nvalues+1
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

# padfinal_tiling implementation

function padfinal_tiling(func::Function, width::Width,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷweight1::ViewOfWeights{T}, padding) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)
    check_weights(length(ᵛʷweight1), width)

    nvalues = tiling_wholes(n, width)
    if iszero(tiling_parts(n, width))
        return basic_tiling(func, width, ᵛʷdata1, ᵛʷweight1)
    end

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, nvalues+1)

    results[end] = padding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1)
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

function padfinal_tiling(func::Function, width::Width,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, 
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    w = min(length(ᵛʷweight1), length(ᵛʷweight2))
    check_width(n, width)
    check_weights(w, width)

    nvalues = tiling_wholes(n, width)
    if iszero(tiling_parts(n, width))
        return basic_tiling(func, width, ᵛʷdata1, ᵛʷweight1)
    end

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, nvalues+1)

    results[end] = padding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2)
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

function padfinal_tiling(func::Function, width::Width,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, ᵛʷweight3::ViewOfWeights{T},
    padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    w = min(length(ᵛʷweight1), length(ᵛʷweight2), length(ᵛʷweight3))
    check_width(n, width)
    check_weights(w, width)

    nvalues = tiling_wholes(n, width)
    if iszero(tiling_parts(n, width))
        return basic_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
    end

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, nvalues)

    results[end] = padding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

