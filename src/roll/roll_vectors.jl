#=
   basic_rolling(func, span, data1) ..
   basic_rolling(func, span, data1, data2, data3)

   padfirst_rolling(func, span, data1, padding) ..
   padfirst_rolling(func, span, data1, data2, data3, padding)

   padfinal_rolling(func, span, data1, padding) ..
   padfinal_rolling(func, span, data1, data2, data3, padding)
=#

# basic_rolling

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    basic_rolling(func, span, ᵛʷdata1)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata2 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end

# padfirst_rolling

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    padfirst_rolling(func, span, ᵛʷdata1, padding)
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, padding)
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, padding)
end

# padfinal_rolling

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    padfinal_rolling(func, span, ᵛʷdata1, padding)
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, padding)
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, padding)
end

# basic_rolling implementation

function basic_rolling(func::Function, span::Span,
    ᵛʷdata1::ViewOfVector{T}) where {T}
    n = length(ᵛʷdata1)
    check_span(n, span)

    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inbounds for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end



function basic_rolling(func::Function, span::Span,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_span(n, span)

    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inbounds for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# padfirst_rolling implementation

function padfirst_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, padding) where {T}
    n = length(ᵛʷdata1)
    check_span(n, span)

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = 1:padding_span

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in span:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_span(n, span)

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = 1:padding_span

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in span:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_span(n, span)

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = 1:padding_span

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in span:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# padfinal_rolling implementation

function padfinal_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, padding) where {T}
    n = length(ᵛʷdata1)
    check_span(n, span)

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_span(n, span)

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_span(n, span)

    nvalues = nrolled(n, span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

