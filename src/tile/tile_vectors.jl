#=
   basic_tiling(func, width, data1) ..
   basic_tiling(func, width, data1, data2, data3)

   padfirst_tiling(func, width, data1, padding) ..
   padfirst_tiling(func, width, data1, data2, data3, padding)

   padfinal_tiling(func, width, data1, padding) ..
   padfinal_tiling(func, width, data1, data2, data3, padding)
=#

# basic_tiling

function basic_tiling(func::Function, width::Width,
    data1::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    basic_tiling(func, width, ᵛʷdata1)
end

function basic_tiling(func::Function, width::Width,
    data1::AbstractVector{T}, data2::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    basic_tiling(func, width, ᵛʷdata1, ᵛʷdata2)
end

function basic_tiling(func::Function, width::Width,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    basic_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end

# padfirst_tiling

function padfirst_tiling(func::Function, width::Width, data1::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    padfirst_tiling(func, width, ᵛʷdata1, padding)
end

function padfirst_tiling(func::Function, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    padfirst_tiling(func, width, ᵛʷdata1, ᵛʷdata2, padding)
end

function padfirst_tiling(func::Function, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    padfirst_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, padding)
end

# padfinal_tiling

function padfinal_tiling(func::Function, width::Width, data1::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    padfinal_tiling(func, width, ᵛʷdata1, padding)
end

function padfinal_tiling(func::Function, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    padfinal_tiling(func, width, ᵛʷdata1, ᵛʷdata2, padding)
end

function padfinal_tiling(func::Function, width::Width, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    padfinal_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, padding)
end

# basic_tiling implementation

function basic_tiling(func::Function, width::Width,
    ᵛʷdata1::ViewOfVector{T}) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = ntiled(n, width)

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

function basic_tiling(func::Function, width::Width,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = ntiled(n, width)

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

function basic_tiling(func::Function, width::Width,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = ntiled(n, width)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

# padfirst_tiling implementation

function padfirst_tiling(func::Function, width::Width, ᵛʷdata1::ViewOfVector{T}, padding) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = ntiled(n, width)
    if iszero(nimputed_tiling(n, width))
        return basic_tiling(func, width, ᵛʷdata1)
    end

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, nvalues + 1)
    results[1] = padding

    ilow, ihigh = 1, width
    @inbounds for idx in 2:nvalues+1
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

function padfirst_tiling(func::Function, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = ntiled(n, width)
    if iszero(nimputed_tiling(n, width))
        return basic_tiling(func, width, ᵛʷdata1, ᵛʷdata2)
    end

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, nvalues + 1)
    results[1] = padding

    ilow, ihigh = 1, width
    @inbounds for idx in 2:nvalues+1
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

function padfirst_tiling(func::Function, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = ntiled(n, width)
    if iszero(nimputed_tiling(n, width))
        return basic_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
    end

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, nvalues + 1)
    results[1] = padding

    ilow, ihigh = 1, width
    @inbounds for idx in 2:nvalues+1
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

# padfinal_tiling implementation

function padfinal_tiling(func::Function, width::Width, ᵛʷdata1::ViewOfVector{T}, padding) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = ntiled(n, width)
    if iszero(nimputed_tiling(n, width))
        return basic_tiling(func, width, ᵛʷdata1)
    end

    rettype = rts(func, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, nvalues + 1)
    results[end] = padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

function padfinal_tiling(func::Function, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = ntiled(n, width)
    if iszero(nimputed_tiling(n, width))
        return basic_tiling(func, width, ᵛʷdata1, ᵛʷdata2)
    end

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, nvalues + 1)
    results[end] = padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end

function padfinal_tiling(func::Function, width::Width, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = ntiled(n, width)
    if iszero(nimputed_tiling(n, width))
        return basic_tiling(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
    end

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, nvalues + 1)
    results[end] = padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + width
        ihigh = ihigh + width
    end

    results
end
