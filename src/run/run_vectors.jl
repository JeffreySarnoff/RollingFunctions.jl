#=
   taperfirst_running(func, width, data1) ..
   taperfirst_running(func, width, data1, data2, data3)

   taperfinal_running(func, width, data1) ..
   taperfinal_running(func, width, data1, data2, data3)
=#

# taperfirst_running

function taperfirst_running(func::Function, width::Span, data1::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    taperfirst_running(func, width, ᵛʷdata1)
end

function taperfirst_running(func::Function, width::Span, data1::AbstractVector{T}, data2::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    taperfirst_running(func, width, ᵛʷdata1, ᵛʷdata2)
end

function taperfirst_running(func::Function, width::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    taperfirst_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end

# taperfinal_running

function taperfinal_running(func::Function, width::Span, data1::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    taperfinal_running(func, width, ᵛʷdata1)
end

function taperfinal_running(func::Function, width::Span, data1::AbstractVector{T}, data2::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    taperfinal_running(func, width, ᵛʷdata1, ᵛʷdata2)
end

function taperfinal_running(func::Function, width::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    taperfinal_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end

# taperfirst_running implementation

function taperfirst_running(func::Function, width::Span, ᵛʷdata1::ViewOfVector{T}) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(func, width, ᵛʷdata1)
    end

    taper_idxs = n-width:n
    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    #results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfirst_running(func::Function, width::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(func, width, ᵛʷdata1, ᵛʷdata2)
    end

    taper_idxs = n-width:n
    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    #results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfirst_running(func::Function, width::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(func, width, ᵛʷdata1, ᵛʷdata2)
    end

    taper_idxs = n-width:n
    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    #results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# taperfinal_running implementation

function taperfinal_running(func::Function, width::Span, ᵛʷdata1::ViewOfVector{T}) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(func, width, ᵛʷdata1)
    end

    taper_idxs = 1:n-nvalues
    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    #results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfinal_running(func::Function, width::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(func, width, ᵛʷdata1)
    end

    taper_idxs = 1:n-nvalues
    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    #results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfinal_running(func::Function, width::Span, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(func, width, ᵛʷdata1)
    end

    taper_idxs = 1:n-nvalues
    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    # results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

