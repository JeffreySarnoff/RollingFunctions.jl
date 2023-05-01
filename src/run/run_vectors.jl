#=
   basic_running(func, width, data1) ..
   basic_running(func, width, data1, data2, data3)

   padfirst_running(func, width, data1, padding) ..
   padfirst_running(func, width, data1, data2, data3, padding)

   padfinal_running(func, width, data1, padding) ..
   padfinal_running(func, width, data1, data2, data3, padding)
=#

# basic_running

function basic_running(func::Function, width::Span,
    data1::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    basic_running(func, width, ᵛʷdata1)
end

function basic_running(func::Function, width::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    basic_running(func, width, ᵛʷdata1, ᵛʷdata2)
end

function basic_running(func::Function, width::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    basic_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end

function basic_running(func::Function, width::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])

    basic_running(func, width, ᵛʷdata1, ᵛʷdata2)
end

function basic_running(func::Function, width::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata2 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])

    basic_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end

# padfirst_running

function padfirst_running(func::Function, width::Span, data1::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    padfirst_running(func, width, ᵛʷdata1, padding)
end

function padfirst_running(func::Function, width::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    padfirst_running(func, width, ᵛʷdata1, ᵛʷdata2, padding)
end

function padfirst_running(func::Function, width::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    padfirst_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, padding)
end

# padfinal_running

function padfinal_running(func::Function, width::Span, data1::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    padfinal_running(func, width, ᵛʷdata1, padding)
end

function padfinal_running(func::Function, width::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    padfinal_running(func, width, ᵛʷdata1, ᵛʷdata2, padding)
end

function padfinal_running(func::Function, width::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    padfinal_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, padding)
end

# basic_running implementation

function basic_running(func::Function, width::Span,
    ᵛʷdata1::ViewOfVector{T}) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = nrolled(n, width)

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_running(func::Function, width::Span,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = nrolled(n, width)

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_running(func::Function, width::Span,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = nrolled(n, width)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# padfirst_running implementation

function padfirst_running(func::Function, width::Span, ᵛʷdata1::ViewOfVector{T}, padding) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = nrolled(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    padding_width = width - 1
    padding_idxs = 1:padding_width

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_running(func::Function, width::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = nrolled(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    padding_width = width - 1
    padding_idxs = 1:padding_width

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_running(func::Function, width::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = nrolled(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    padding_width = width - 1
    padding_idxs = 1:padding_width

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# padfinal_running implementation

function padfinal_running(func::Function, width::Span, ᵛʷdata1::ViewOfVector{T}, padding) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = nrolled(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    padding_width = width - 1
    padding_idxs = n-padding_width-1:n

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_running(func::Function, width::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = nrolled(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    padding_width = width - 1
    padding_idxs = n-padding_width-1:n

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_running(func::Function, width::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = nrolled(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    padding_width = width - 1
    padding_idxs = n-padding_width-1:n

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

