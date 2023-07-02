# taper first

function taperfirst(fn::F, width::Integer, data1::AbstractVector{T},
    weight::AbstractWeights{T};
    padding=nopadding) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    if padding == nopadding
        taperfirst(fn, width, ᵛʷdata1, ᵛʷweight)
    else
        taperfirstpadded(fn, width, ᵛʷdata1, ᵛʷweight, padding)
    end
end

function taperfirst(fn::F, width::Integer,
    data1::AbstractVector{T}, weight::AbstractWeights{W};
    padding=nopadding) where {F<:Function,T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    if padding == nopadding
        taperfirst(fn, width, ᵛʷdata1, ᵛʷweight)
    else
        taperfirstpadded(fn, width, ᵛʷdata1, ᵛʷweight, padding)
    end
end

function taperfirst(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2};
    padding=nopadding) where {F<:Function,T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    if padding == nopadding
        taperfirst(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
    else
        taperfirstpadded(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2, padding)
    end
end

function taperfirst(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}, weight3::AbstractWeights{W3};
    padding=nopadding) where {F<:Function,T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    if padding == nopadding
        taperfirst(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
    else
        taperfirstpadded(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3, padding)
    end
end


# taper final

function taperfinal(fn::F, width::Integer, data1::AbstractVector{T},
    weight::AbstractWeights{T}) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweight = asview(weight)

    if padding == nopadding
        taperfinal(fn, width, ᵛʷdata1, ᵛʷweight)
    else
        taperfinalpadded(fn, width, ᵛʷdata1, ᵛʷweight, padding)
    end
end

function taperfinal(fn::F, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T},
    weight1::AbstractWeights{T}, weight2::AbstractWeights{T}) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    if padding == nopadding
        taperfinal(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
    else
        taperfinalpadded(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2, padding)
    end
end

function taperfinal(fn::F, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::AbstractWeights{T}, weight2::AbstractWeights{T}, weight3::AbstractWeights{T}) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)
    ᵛʷweight3 = asview(weight3)

    if padding == nopadding
        taperfinal(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
    else
        taperfinalpadded(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3, padding)
    end
end

function taperfinal(fn::F, width::Integer,
    data1::AbstractVector{T}, weight::AbstractWeights{W}) where {F<:Function,T,W}
    typ = promote_type(T, W)
    ᵛʷdata1 = T === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷweight = W === typ ? asview(weight) : asview([typ(x) for x in weight])

    if padding == nopadding
        taperfinal(fn, width, ᵛʷdata1, ᵛʷweight)
    else
        taperfinalpadded(fn, width, ᵛʷdata1, ᵛʷweight, padding)
    end
end

function taperfinal(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}) where {F<:Function,T1,T2,W1,W2}
    typ = promote_type(T1, T2, W1, W2)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])

    if padding == nopadding
        taperfinal(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
    else
        taperfinalpadded(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2, padding)
    end
end

function taperfinal(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}, weight3::AbstractWeights{W3}) where {F<:Function,T1,T2,T3,W1,W2,W3}
    typ = promote_type(T1, T2, T3, W1, W2, W3)
    ᵛʷdata1 = T1 === typ ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = T2 === typ ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = T3 === typ ? asview(data3) : asview([typ(x) for x in data3])
    ᵛʷweight1 = W1 === typ ? asview(weight1) : asview([typ(x) for x in weight1])
    ᵛʷweight2 = W2 === typ ? asview(weight2) : asview([typ(x) for x in weight2])
    ᵛʷweight3 = W3 === typ ? asview(weight3) : asview([typ(x) for x in weight3])

    if padding == nopadding
        taperfinal(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
    else
        taperfinalpadded(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3, padding)
    endend

# IMPLEMENTATIONS

# taperfirst implementations

function taperfirstpadded(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷweight1::ViewOfWeights{T}) where {F<:Function,T}
    result = taperfirst(fn, width, ᵛʷdata1, ᵛʷweight1)
    for i = eachindex(result)
        if !isnan(result[i])
            break
        else
            result[i] = padding
        end
    end
    result
end

function taperfirstpadded(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, padding) where {F<:Function,T}
    result = taperfirst(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
    for i = eachindex(result)
        if !isnan(result[i])
            break
        else
            result[i] = padding
        end
    end
    result
end

function taperfirstpadded(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}, ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, ᵛʷweight3::ViewOfWeights{T}, padding) where {F<:Function,T}
    result = taperfirst(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
    for i = eachindex(result)
        if !isnan(result[i])
            break
        else
            result[i] = padding
        end
    end
    result
end

function taperfirst(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷweight1::ViewOfWeights{T}) where {F<:Function,T}
    n = length(ᵛʷdata1)
    check_width(n, width)
    check_weights(length(ᵛʷweight1), width)

    nvalues = rolling_wholes(n, width)

    taper_idxs = 1:n-nvalues
    rettype = rts(fn, (Vector{T},))
    result = Vector{rettype}(undef, n)

    @inbounds for idx in taper_idxs
        @views result[idx] = fn(ᵛʷdata1[1:idx] .* ᵛʷweight1[end-idx+1:end])
    end

    ilow, ihigh = 1, width
    @inline for idx in width:n
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function taperfirst(fn::F, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T},
    weight1::AbstractWeights{T}, weight2::AbstractWeights{T}) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), length(ᵛʷweight2), width)

    nvalues = rolling_wholes(n, width)

    taper_idxs = 1:n-nvalues
    rettype = rts(fn, (Vector{T}, Vector{T}))
    result = Vector{rettype}(undef, n)

    @inbounds for idx in taper_idxs
        @views result[idx] = fn(ᵛʷdata1[1:idx] .* ᵛʷweight1[end-idx+1:end], ᵛʷdata2[1:idx] .* ᵛʷweight2[end-idx+1:end])
    end

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues-(width - 1)
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function taperfirst(fn::F, width::Integer, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weight1::AbstractWeights{T}, weight2::AbstractWeights{T}, weight3::AbstractWeights{T}) where {F<:Function,T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweight1 = asview(weight1)
    ᵛʷweight2 = asview(weight2)
    ᵛʷweight3 = asview(weight3)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), length(ᵛʷweight2), length(ᵛʷweight3), width)

    nvalues = rolling_wholes(n, width)

    taper_idxs = 1:n-nvalues
    rettype = rts(fn, (Vector{T}, Vector{T}, Vector{T}))
    result = Vector{rettype}(undef, n)

    @inbounds for idx in taper_idxs
        @views result[idx] = fn(ᵛʷdata1[1:idx].* ᵛʷweight1[end-idx+1:end], ᵛʷdata2[1:idx] .* ᵛʷweight2[end-idx+1:end],ᵛʷdata3[1:idx] .* ᵛʷweight3[end-idx+1:end])
    end

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues-(width - 1)
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end


# taper final implementations

function taperfinalpadded(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷweight1::ViewOfWeights{T}) where {F<:Function,T}
    result = taperfinal(fn, width, ᵛʷdata1, ᵛʷweight1)
    for i = length(result):-1:1
        if !isnan(result[i])
            break
        else
            result[i] = padding
        end
    end
    result
end

function taperfinalpadded(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, padding) where {F<:Function,T}
    result = taperfinal(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷweight1, ᵛʷweight2)
    for i = length(result):-1:1
        if !isnan(result[i])
            break
        else
            result[i] = padding
        end
    end
    result
end

function taperfinalpadded(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T}, ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, ᵛʷweight3::ViewOfWeights{T}, padding) where {F<:Function,T}
    result = taperfinal(fn, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweight1, ᵛʷweight2, ᵛʷweight3)
    for i = length(result):-1:1
        if !isnan(result[i])
            break
        else
            result[i] = padding
        end
    end
    result
end

function taperfinal(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T},
                    ᵛʷweight::ViewOfWeights{T}) where {F<:Function,T}
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
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    taper_idxs = ilow:n
    @inbounds for idx in taper_idxs
        @views result[idx] = fn(ᵛʷdata1[idx:end] .* normalize(ᵛʷweight[end-idx+1:end]))
    end

    result
end

function taperfinal(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}) where {F<:Function,T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), width)
    check_weights(length(ᵛʷweight2), width)

    nvalues = rolling_wholes(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt fn
    tapering_width = width - 1
    tapering_idxs = n-tapering_width-1:n

    rettype = rts(fn, (Vector{T}, Vector{T}))
    result = Vector{Union{typeof(tapering),rettype}}(undef, n)
    result[tapering_idxs] .= tapering

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end

function taperfinal(fn::F, width::Integer, ᵛʷdata1::ViewOfVector{T}, ᵛʷdata2::ViewOfVector{T}, ᵛʷdata3::ViewOfVector{T},
    ᵛʷweight1::ViewOfWeights{T}, ᵛʷweight2::ViewOfWeights{T}, ᵛʷweight3::ViewOfWeights{T}) where {F<:Function,T}
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    check_width(n, width)
    check_weights(length(ᵛʷweight1), width)
    check_weights(length(ᵛʷweight2), width)
    check_weights(length(ᵛʷweight3), width)

    nvalues = rolling_wholes(n, width)
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt fn
    tapering_width = width - 1
    tapering_idxs = n-tapering_width-1:n

    rettype = rts(fn, (Vector{T}, Vector{T}, Vector{T}))
    result = Vector{Union{typeof(tapering),rettype}}(undef, n)
    result[tapering_idxs] .= tapering

    ilow, ihigh = 1, width
    @inline for idx in 1:nvalues
        @views result[idx] = fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweight1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweight2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweight3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    result
end
