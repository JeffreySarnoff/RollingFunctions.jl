#=
   basic_rolling(func, span, data1, weight) ..
   basic_rolling(func, span, data1, data2, data3, weight)

   padfirst_rolling(func, span, data1, weight; padding) ..
   padfirst_rolling(func, span, data1, data2, data3, weight; padding)

   padfinal_rolling(func, span, data1, weight; padding) ..
   padfinal_rolling(func, span, data1, data2, data3, weight; padding)

   basic_rolling(func, span, data1, data2, weight1, weight2) ..
   basic_rolling(func, span, data1, data2, data3, span, 
                            weight1, weight2, weight3)

   padfirst_rolling(func, span, data1, data2, weight1, weight2; padding) ..
   padfirst_rolling(func, span, data1, data2, data3, 
                            weight1, weight2, weight3, weight4; padding)

   padfinal_rolling(func, span, data1, data2, weight1, weight2; padding) ..
   padfinal_rolling(func, span, data1, data2, data3, 
                            weight1, weight2, weight3, weight4; padding)
=#

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, weight::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    basic_rolling(func, span, ᵛʷdata1, ᵛʷweight)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, weight::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight = asview(weight)

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweight)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, weight1::Weighting{T}, weight2::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, weight::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight = asview(weight)

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}, weight3::Weighting{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)
    ᵛʷweight3 = asview(weight3)

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, weight::Weighting{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    basic_rolling(func, span, ᵛʷdata1, ᵛʷweight)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight::Weighting{W}) where {T1,T2,W}
    typ = promote_type(T1, T2, W)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweight)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::Weighting{W1}, weight2::Weighting{W2}) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, weight::Weighting{W}) where {T1,T2,T3,W}
    typ = promote_type(T1, T2, T3, W)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::Weighting{W1}, weight2::Weighting{W2}, weight3::Weighting{W3}) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
end

# pad first

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T},
    weight::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷweight, padding)
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T},
    weight::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight = asview(weight)

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweight, padding)
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight = asview(weight)

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight, padding)
end


function padfirst_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, weight::Weighting{W}, padding) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷweight, padding)
end

function padfirst_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight::Weighting{W}, padding) where {T1,T2,W}
    typ = promote_type(T1, T2, W)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweight, padding)
end

function padfirst_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::Weighting{W1}, weight2::Weighting{W2}, padding) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2, padding)
end

function padfirst_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, weight::Weighting{W}, padding) where {T1,T2,T3,W}
    typ = promote_type(T1, T2, T3, W)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight, padding)
end

function padfirst_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::Weighting{W1}, weight2::Weighting{W2}, weight3::Weighting{W3}, padding) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3, padding)
end

# pad final


function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T},
    weight::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷweight, padding)
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T},
    weight::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight = asview(weight)

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweight, padding)
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2, padding)
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight = asview(weight)

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight, padding)
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}, weight3::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)
    ᵛʷweight3 = asview(weight3)

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3, padding)
end


function padfinal_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, weight::Weighting{W}, padding) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷweight, padding)
end

function padfinal_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight::Weighting{W}, padding) where {T1,T2,W}
    typ = promote_type(T1, T2, W)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweight, padding)
end

function padfinal_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::Weighting{W1}, weight2::Weighting{W2}, padding) where {T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2, padding)
end

function padfinal_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, weight::Weighting{W}, padding) where {T1,T2,T3,W}
    typ = promote_type(T1, T2, T3, W)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight, padding)
end

function padfinal_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::Weighting{W1}, weight2::Weighting{W2}, weight3::Weighting{W3}, padding) where {T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3, padding)
end


# IMPLEMENTATIONS

# basic_rolling implementations

function basic_rolling(func::Function, span::Span,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷweight::ViewOfWeights{T}) where {T}
    n = length(ᵛʷdata1)
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::Function, span::Span,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷweight::ViewOfWeights{T}) where {T}

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweight::ViewOfWeights{T}) where {T}

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span

    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::Function, span::Span,
    data1::ViewOfMatrix{T}, weight::ViewOfWeights{W}) where {T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    basic_rolling(func, span, ᵛʷdata1, ᵛʷweight)
end



# pad first implementations

function padfirst_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷweight::ViewOfWeights{T}, padding) where {T}
    n = length(ᵛʷdata1)
    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in span:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T},
    ᵛʷweight::ViewOfWeights{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues-padding_span
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweight::ViewOfWeights{T}, padding) where {T}

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues-padding_span
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad final implementations

function padfinal_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T},
    ᵛʷweight::ViewOfWeights{T}, padding) where {T}
    n = length(ᵛʷdata1)

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T},
    ᵛʷweight::ViewOfWeights{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweight::ViewOfWeights{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# =============================================


function basic_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, ᵛʷweight3::ViewOfWeights{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad first

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues-padding_span
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}, weight3::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)
    ᵛʷweight3 = asview(weight3)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues-padding_span
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad last


function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::Weighting{T}, weight2::Weighting{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, ᵛʷweight3::ViewOfWeights{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end
