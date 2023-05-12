#=
   taperfirst(func, width, data1) ..
   taperfirst(func, width, data1, data2, data3)

   taperfinal(func, width, data1) ..
   taperfinal(func, width, data1, data2, data3)
=#

# taperfirst

function taperfirst(func::F, width::Width, data1::AbstractVector{T}) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    taperfirst(func, width, ᵛʷdata1)
end

function taperfirst(func::F, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T}) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    taperfirst(func, width, ᵛʷdata1, ᵛʷdata2)
end

function taperfirst(func::F, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    taperfirst(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end

# taperfinal

function taperfinal(func::F, width::Width, data1::AbstractVector{T}) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    taperfinal(func, width, ᵛʷdata1)
end

function taperfinal(func::F, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T}) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    taperfinal(func, width, ᵛʷdata1, ᵛʷdata2)
end

function taperfinal(func::F, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    taperfinal(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end

# taperfirst implementation

function taperfirst(func::F, width::Width, ᵛʷdata1::ViewOfVector{T}) where {F<:Function,T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(func, width, ᵛʷdata1)
    end

    taper_idxs = 1:n-nvalues
    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, n)

    @inbounds for idx in taper_idxs
        @views results[idx] = func(ᵛʷdata1[1:idx])
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfirst(func::F, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}) where {F<:Function,T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(func, width, ᵛʷdata1, ᵛʷdata2)
    end

    taper_idxs = 1:n-nvalues
    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, n)

    @inbounds for idx in taper_idxs
        @views results[idx] = func(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx])
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function taperfirst(func::F, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}) where {F<:Function,T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(func, width, ᵛʷdata1, ᵛʷdata2)
    end

    taper_idxs = 1:n-nvalues
    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, n)

    @inbounds for idx in taper_idxs
        @views results[idx] = func(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx], ᵛʷdata3[1:idx])
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# taperfinal implementation

function taperfinal(func::F, width::Width, ᵛʷdata1::ViewOfVector{T}) where {F<:Function,T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(func, width, ᵛʷdata1)
    end

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, n)

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    taper_idxs = ilow:n
    @inbounds for idx in taper_idxs
        @views results[idx] = func(ᵛʷdata1[idx:end])
    end

    results
end

function taperfinal(func::F, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}) where {F<:Function,T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(func, width, ᵛʷdata1)
    end

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, n)

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    taper_idxs = il
    @inbounds for idx in taper_idxs
        @views results[idx] = func(ᵛʷdata1[idx:end], ᵛʷdata2[idx:end])
    end

    results
end

function taperfinal(func::F, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}) where {F<:Function,T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(func, width, ᵛʷdata1)
    end

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, n)
    # results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    taper_idxs = ilow:n
    @inbounds for idx in taper_idxs
        @views results[idx] = func(ᵛʷdata1[idx:end], ᵛʷdata2[idx:end], ᵛʷdata3[idx:end])
    end

    results
end

