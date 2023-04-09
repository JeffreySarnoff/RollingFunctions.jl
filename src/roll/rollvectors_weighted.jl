#=
   basic_rolling(func, data1, span, weights) ..
   basic_rolling(func, data1, data2, data3, data4, span, weights)

   padfirst_rolling(func, data1, span, weights; padding) ..
   padfirst_rolling(func, data1, data2, data3, data4, span, weights; padding)

   padfinal_rolling(func, data1, span, weights; padding) ..
   padfinal_rolling(func,data1, data2, data3, data4, span, weights; padding)

   basic_rolling(func, data1, data2, span, weights1, weights2) ..
   basic_rolling(func, data1, data2, data3, data4, span, 
                            weights1, weights2, weights3, weights4)

   padfirst_rolling(func, data1, data2, span, weights1, weights2; padding) ..
   padfirst_rolling(func, data1, data2, data3, data4, span, 
                            weights1, weights2, weights3, weights4; padding)

   padfinal_rolling(func, data1, data2. span, weights1, weights2; padding) ..
   padfinal_rolling(func,data1, data2, data3, data4, span, 
                            weights1, weights2, weights3, weights4; padding)
=#

function basic_rolling(func::Function, span::Span, data1::AbstractVector{T}, weights::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)

    n = length(ᵛʷdata1)
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, weights::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    weights::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad first

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T},
    weights::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)

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
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T},
    weights::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)

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
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)

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
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    weights::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))

    nvalues = nrolled(min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4)), span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues-padding_span
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad last

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T},
    weights::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)

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
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T},
    weights::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)

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
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)

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
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    weights::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))

    nvalues = nrolled(min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4)), span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

#
# multiple weight vectors
#

function basic_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, 
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}, weights3::AbstractWeights{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}, weights3::AbstractWeights{T}, weights4::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights4)
    ᵛʷweights4 = asview(weights4)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inline for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights4)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad first


function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)

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
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}, weights3::AbstractWeights{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)

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
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}, weights3::AbstractWeights{T}, weights4::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)
    ᵛʷweights4 = asview(weights4)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))

    nvalues = nrolled(min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4)), span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues-padding_span
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights4)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad last


function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)

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
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}, weights3::AbstractWeights{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)

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
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    weights1::AbstractWeights{T}, weights2::AbstractWeights{T}, weights3::AbstractWeights{T}, weights4::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)
    ᵛʷweights4 = asview(weights4)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))

    nvalues = nrolled(min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4)), span)
    # only completed span coverings are resolvable
    # the first (span - 1) values are unresolved wrt func
    padding_span = span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(func, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inline for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights4)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 
