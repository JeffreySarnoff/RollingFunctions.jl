#=
   basic_rolling(fn, width, data1) ..
   basic_rolling(fn, width, data1, data2, data3)

   padfirst_rolling(fn, width, data1, padding) ..
   padfirst_rolling(fn, width, data1, data2, data3, padding)

   padfinal_rolling(fn, width, data1, padding) ..
   padfinal_rolling(fn, width, data1, data2, data3, padding)
=#

# basic_rolling

function basic_rolling(fn::Function, width::Integer,
    data1::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)

    basic_rolling(fn, width, ᵛʷdata1)
end

function basic_rolling(fn::Function, width::Integer,
    data1::AbstractVector{T}, data2::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)

    basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2)
end

function basic_rolling(fn::Function, width::Integer,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)

    basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end

function basic_rolling(fn::Function, width::Integer,
    data1::AbstractVector{T}, data2::AbstractVector{T},
    data3::AbstractVector{T}, data4::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)

    basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4)
end

function basic_rolling(fn::Function, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])

    basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2)
end

function basic_rolling(fn::Function, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])

    basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end

function basic_rolling(fn::Function, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, 
    data3::AbstractVector{T3}, data4::AbstractVector{T4}) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷdata4 = T4 === typ ? asview(data4) : asview([typ(x) for x in data4])

    basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4)
end

# padfirst_rolling

function padfirst_rolling(fn::Function, width::Integer, data1::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)

    padfirst_rolling(fn, width, ᵛʷdata1, padding)
end

function padfirst_rolling(fn::Function, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)

    padfirst_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, padding)
end

function padfirst_rolling(fn::Function, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)

    padfirst_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, padding)
end

function padfirst_rolling(fn::Function, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}, 
                          data3::AbstractVector{T}, data4::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)

    padfirst_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata3, padding)
end

# padfinal_rolling

function padfinal_rolling(fn::Function, width::Integer, data1::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)

    padfinal_rolling(fn, width, ᵛʷdata1, padding)
end

function padfinal_rolling(fn::Function, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)

    padfinal_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, padding)
end

function padfinal_rolling(fn::Function, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)

    padfinal_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, padding)
end

function padfinal_rolling(fn::Function, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}, 
                          data3::AbstractVector{T}, data4::AbstractVector{T}, padding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)

    padfinal_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, padding)
end

# basic_rolling implementation

function basic_rolling(fn::Function, width::Integer,
    ᵛʷdata1::ViewOfVector{T}) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    nvalues = rolling_wholes(n, width)

    rettype = rts(fn, (Vector{T},))
    result = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(result)
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function basic_rolling(fn::Function, width::Integer,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    nvalues = rolling_wholes(n, width)

    rettype = rts(fn, (Vector{T}, Vector{T}))
    result = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(result)
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function basic_rolling(fn::Function, width::Integer,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    nvalues = rolling_wholes(n, width)

    rettype = rts(fn, (Vector{T}, Vector{T}, Vector{T}))
    result = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(result)
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function basic_rolling(fn::Function, width::Integer,
    ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, 
    ᵛʷdata3::ViewOfVector{T}, ᵛʷdata4::ViewOfVector{T}) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))
    check_width(n, width)

    nvalues = rolling_wholes(n, width)

    rettype = rts(fn, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    result = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(result)
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh], ᵛʷdata4[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

# padfirst_rolling implementation

function padfirst_rolling(fn::Function, width::Integer, ᵛʷdata1::ViewOfVector{T}, padding) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    if iszero(rolling_parts(n, width))
        return basic_rolling(fn, width, ᵛʷdata1)
    end

    padding_idxs = n-width:n
    rettype = rts(fn, (Vector{T},))
    result = Vector{Union{typeof(padding),rettype}}(undef, n)
    result[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

# padfirst implementation

function padfirst_rolling(fn::Function, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    if iszero(rolling_parts(n, width))
        return basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2)
    end
    
    padding_idxs = n-width:n
    rettype = rts(fn, (Vector{T}, Vector{T}))
    result = Vector{Union{typeof(padding),rettype}}(undef, n)
    result[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function padfirst_rolling(fn::Function, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    if iszero(rolling_parts(n, width))
        return basic_rolling(fn, width, ᵛʷdata1,  ᵛʷdata2,  ᵛʷdata3)
    end

    padding_idxs = n-width:n
    rettype = rts(fn, (Vector{T}, Vector{T}, Vector{T}))
    result = Vector{Union{typeof(padding),rettype}}(undef, n)
    result[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function padfirst_rolling(fn::Function, width::Integer, 
                          ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, 
                          ᵛʷdata3::ViewOfVector{T}, ᵛʷdata4::ViewOfVector{T},
                          padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))
    check_width(n, width)

    if iszero(rolling_parts(n, width))
        return basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4)
    end

    padding_idxs = n-width:n
    rettype = rts(fn, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    result = Vector{Union{typeof(padding),rettype}}(undef, n)
    result[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh], ᵛʷdata4[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

# padfinal_rolling implementation

function padfinal_rolling(fn::Function, width::Integer, ᵛʷdata1::ViewOfVector{T}, padding) where {T}
    n = length(ᵛʷdata1)
    check_width(n, width)

    if iszero(rolling_parts(n, width))
        return basic_rolling(fn, width, ᵛʷdata1)
    end

    padding_idxs = n-width:n
    rettype = rts(fn, (Vector{T},))
    result = Vector{Union{typeof(padding),rettype}}(undef, n)
    result[padding_idxs] .= padding

    nvalues = rolling_wholes(n, width)
    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function padfinal_rolling(fn::Function, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)

    if iszero(rolling_parts(n, width))
        return basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2)
    end

    padding_idxs = n-width:n
    rettype = rts(fn, (Vector{T}, Vector{T}))
    result = Vector{Union{typeof(padding),rettype}}(undef, n)
    result[padding_idxs] .= padding

    nvalues = rolling_wholes(n, width)
    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function padfinal_rolling(fn::Function, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}, padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)

    if iszero(rolling_parts(n, width))
        return basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, ʷdata3)
    end

    padding_idxs = n-width:n
    rettype = rts(fn, (Vector{T}, Vector{T}, Vector{T}))
    result = Vector{Union{typeof(padding),rettype}}(undef, n)
    result[padding_idxs] .= padding

    nvalues = rolling_wholes(n, width)
    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function padfinal_rolling(fn::Function, width::Integer, 
                          ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T},
                          ᵛʷdata3::ViewOfVector{T}, ᵛʷdata4::ViewOfVector{T},
                          padding) where {T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))
    check_width(n, width)

    if iszero(rolling_parts(n, width))
        return basic_rolling(fn, width, ᵛʷdata1, ᵛʷdata2, ʷdata3, ʷdata4)
    end

    padding_idxs = n-width:n
    rettype = rts(fn, (Vector{T}, Vector{T}, Vector{T}))
    result = Vector{Union{typeof(padding),rettype}}(undef, n)
    result[padding_idxs] .= padding

    nvalues = rolling_wholes(n, width)
    ilow, ihigh = 1, width
    @inbounds for idx in 1:nvalues
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh], ᵛʷdata4[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

