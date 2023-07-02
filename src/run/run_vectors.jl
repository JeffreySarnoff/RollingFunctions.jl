#=
   taperfirst(fn, width, data1) ..
   taperfirst(fn, width, data1, data2, data3)

   taperfinal(fn, width, data1) ..
   taperfinal(fn, width, data1, data2, data3)
=#

# taperfirst

function taperfirst(fn::F, width::Integer, data1::AbstractVector{T}; padding=nopadding) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    if padding == nopadding
        taperfirst(fn, width, ᵛʷdata1)
    else
        taperfirstpadded(fn, width, ᵛʷdata1, padding)
    end
end

function taperfirst(fn::F, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}; padding=nopadding) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    if padding == nopadding
        taperfirst(fn, width, ᵛʷdata1, ᵛʷdata2)
    else
        taperfirstpadded(fn, width, ᵛʷdata1, ᵛʷdata2, padding)
    end
end

function taperfirst(fn::F, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}; padding=nopadding) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    if padding == nopadding
        taperfirst(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
    else
        taperfirstpadded(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, padding)
    end
end

# taperfinal

function taperfinal(fn::F, width::Integer, data1::AbstractVector{T}; padding=nopadding) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    if padding == nopadding
        taperfinal(fn, width, ᵛʷdata1)
    else
        taperfinalpadded(fn, width, ᵛʷdata1, padding)
    end
end

function taperfinal(fn::F, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}; padding=nopadding) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    if padding == nopadding
        taperfinal(fn, width, ᵛʷdata1, ᵛʷdata2)
    else
        taperfinalpadded(fn, width, ᵛʷdata1, ᵛʷdata2, padding)
    end
end

function taperfinal(fn::F, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}; padding=nopadding) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    if padding == nopadding
        taperfinal(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
    else
        taperfinalpadded(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, padding)
    end
end

# taperfirst implementation

function taperfirstpadded(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, padding) where {F<:Function,T}
    result = taperfirst(fn, width, ᵛʷdata1)
    for i = eachindex(result)
        if !isnan(result[i])
            break
        else
            result[i] = padding
        end
    end
    result
end

function taperfirstpadded(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, padding) where {F<:Function,T}
    result = taperfirst(fn, width, ᵛʷdata1, ᵛʷdata2)
    for i = eachindex(result)
        if !isnan(result[i])
            break
        else
            result[i] = padding
        end
    end
    result
end

function taperfirstpadded(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}, padding) where {F<:Function,T}
    result = taperfirst(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
    for i = eachindex(result)
        if !isnan(result[i])
            break
        else
            result[i] = padding
        end
    end
    result
end

function taperfirst(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}) where {F<:Function,T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(fn, width, ᵛʷdata1)
    end

    taper_idxs = 1:n-nvalues
    rettype = rts(fn, (Vector{T},))
    result = Vector{rettype}(undef, n)

    @inbounds for idx in taper_idxs
        @views result[idx] = fn(ᵛʷdata1[1:idx])
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function taperfirst(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}) where {F<:Function,T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2)
    end

    taper_idxs = 1:n-nvalues
    rettype = rts(fn, (Vector{T}, Vector{T}))
    result = Vector{rettype}(undef, n)

    @inbounds for idx in taper_idxs
        @views result[idx] = fn(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx])
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function taperfirst(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}) where {F<:Function,T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2)
    end

    taper_idxs = 1:n-nvalues
    rettype = rts(fn, (Vector{T}, Vector{T}, Vector{T}))
    result = Vector{rettype}(undef, n)

    @inbounds for idx in taper_idxs
        @views result[idx] = fn(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx], ᵛʷdata3[1:idx])
    end

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

# taperfinal implementation

function taperfinalpadded(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, padding) where {F<:Function,T}
    result = taperfinal(fn, width, ᵛʷdata1)
    for i = length(result):-1:1
        if !isnan(result[i])
            break
        else
            result[i] = padding
        end
    end
    result
end

function taperfinalpadded(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, padding) where {F<:Function,T}
    result = taperfinal(fn, width, ᵛʷdata1, ᵛʷdata2)
    for i = length(result):-1:1
        if !isnan(result[i])
            break
        else
            result[i] = padding
        end
    end
    result
end

function taperfinalpadded(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}, padding) where {F<:Function,T}
    result = taperfinalt(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
    for i = length(result):-1:1
        if !isnan(result[i])
            break
        else
            result[i] = padding
        end
    end
    result
end

function taperfinal(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}) where {F<:Function,T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(fn, width, ᵛʷdata1)
    end

    rettype = rts(fn, (Vector{T},))
    result = Vector{rettype}(undef, n)

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    taper_idxs = ilow:n
    @inbounds for idx in taper_idxs
        @views result[idx] = fn(ᵛʷdata1[idx:end])
    end

    result
end

function taperfinal(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}) where {F<:Function,T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(fn, width, ᵛʷdata1)
    end

    rettype = rts(fn, (Vector{T}, Vector{T}))
    result = Vector{rettype}(undef, n)

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    taper_idxs = ilow:n
    @inbounds for idx in taper_idxs
        @views result[idx] = fn(ᵛʷdata1[idx:end], ᵛʷdata2[idx:end])
    end

    result
end

function taperfinal(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}) where {F<:Function,T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = nrunning(n, width)
    if iszero(nimputed_running(n, width))
        return basic_rolling(fn, width, ᵛʷdata1)
    end

    rettype = rts(fn, (Vector{T}, Vector{T}, Vector{T}))
    result = Vector{rettype}(undef, n)
    # result[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    taper_idxs = ilow:n
    @inbounds for idx in taper_idxs
        @views result[idx] = fn(ᵛʷdata1[idx:end], ᵛʷdata2[idx:end], ᵛʷdata3[idx:end])
    end

    result
end

