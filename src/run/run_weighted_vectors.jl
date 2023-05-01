# taper first

function taperfirst_running(func::Function, width::Width, data1::AbstractVector{T},
    weight::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    taperfirst_running(func, width, ᵛʷdata1, ᵛʷweight)
end

function taperfirst_running(func::Function, width::Width,
    data1::AbstractVector{T}, weight::Weighting{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    taperfirst_running(func, width, ᵛʷdata1, ᵛʷweight)
end

function taperfirst_running(func::Function, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::Weighting{W1}, weight2::Weighting{W2}) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    taperfirst_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
end

function taperfirst_running(func::Function, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::Weighting{W1}, weight2::Weighting{W2}, weight3::Weighting{W3}) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    taperfirst_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
end


function taperfirst_running(func::Function, width::Width,
    data1::ViewOfMatrix{T}, weight::ViewOfWeights{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    taperfirst_running(func, width, ᵛʷdata1, ᵛʷweight)
end


# taper final

function taperfinal_running(func::Function, width::Width, data1::AbstractVector{T},
    weight::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    taperfinal_running(func, width, ᵛʷdata1, ᵛʷweight)
end

function taperfinal_running(func::Function, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    taperfinal_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
end

function taperfinal_running(func::Function, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}, weight3::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)
    ᵛʷweight3 = asview(weight3)

    taperfinal_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
end


function taperfinal_running(func::Function, width::Width,
    data1::AbstractVector{T}, weight::Weighting{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    taperfinal_running(func, width, ᵛʷdata1, ᵛʷweight)
end

function taperfinal_running(func::Function, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::Weighting{W1}, weight2::Weighting{W2}) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    taperfinal_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
end

function taperfinal_running(func::Function, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::Weighting{W1}, weight2::Weighting{W2}, weight3::Weighting{W3}) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    taperfinal_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
end

# IMPLEMENTATIONS

# taper first implementations

function taperfirst_running(func::Function, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷweight::ViewOfWeights{T}) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)
    check_weights(length(ᵛʷweight), width)

    nvalues = nrolling(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    taperding_width = width - 1
    taperding_idxs = nvalues-taperding_width:nvalues

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(taperding),rettype}}(undef, n)
    results[taperding_idxs] .= taperding

    ilow, ihigh = 1, width
    @inline for idx in width:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfirst_running(func::Function, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), length(ᵛʷweight2), width)

    nvalues = nrolling(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    taperding_width = width - 1
    taperding_idxs = nvalues-taperding_width:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(taperding),rettype}}(undef, n)
    results[taperding_idxs] .= taperding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues-taperding_width
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfirst_running(func::Function, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}, weight3::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)
    ᵛʷweight3 = asview(weight3)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), length(ᵛʷweight2), length(ᵛʷweight3), width)

    nvalues = nrolling(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    taperding_width = width - 1
    taperding_idxs = nvalues-taperding_width:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(taperding),rettype}}(undef, n)
    results[taperding_idxs] .= taperding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues-taperding_width
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# taper final implementations

function taperfinal_running(func::Function, width::Width, ᵛʷdata1::ViewOfVector{T},
    ᵛʷweight::ViewOfWeights{T}) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)
    check_weights(length(ᵛʷweight), width)

    nvalues = nrolling(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    taperding_width = width - 1
    taperding_idxs = n-taperding_width-1:n

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(taperding),rettype}}(undef, n)
    results[taperding_idxs] .= taperding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfinal_running(func::Function, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), width)
    check_weights(length(ᵛʷweight2), width)

    nvalues = nrolling(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    taperding_width = width - 1
    taperding_idxs = n-taperding_width-1:n

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(taperding),rettype}}(undef, n)
    results[taperding_idxs] .= taperding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfinal_running(func::Function, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, ᵛʷweight3::ViewOfWeights{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), width)
    check_weights(length(ᵛʷweight2), width)
    check_weights(length(ᵛʷweight3), width)

    nvalues = nrolling(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    taperding_width = width - 1
    taperding_idxs = n-taperding_width-1:n

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(taperding),rettype}}(undef, n)
    results[taperding_idxs] .= taperding

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end
