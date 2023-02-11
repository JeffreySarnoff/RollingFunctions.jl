#=
   basic_rolling(window_fn, data1, window_span, weights) ..
   basic_rolling(window_fn, data1, data2, data3, data4, window_span, weights)

   padded_rolling(window_fn, data1, window_span, weights; padding) ..
   padded_rolling(window_fn, data1, data2, data3, data4, window_span, weights; padding)

   last_padded_rolling(window_fn, data1, window_span, weights; padding) ..
   last_padded_rolling(window_fn,data1, data2, data3, data4, window_span, weights; padding)

   basic_rolling(window_fn, data1, data2, window_span, weights1, weights2) ..
   basic_rolling(window_fn, data1, data2, data3, data4, window_span, 
                            weights1, weights2, weights3, weights4)

   padded_rolling(window_fn, data1, data2, window_span, weights1, weights2; padding) ..
   padded_rolling(window_fn, data1, data2, data3, data4, window_span, 
                            weights1, weights2, weights3, weights4; padding)

   last_padded_rolling(window_fn, data1, data2. window_span, weights1, weights2; padding) ..
   last_padded_rolling(window_fn,data1, data2, data3, data4, window_span, 
                            weights1, weights2, weights3, weights4; padding)
=#

function basic_rolling(window_fn::Function, data1::AbstractVector{T}, window_span::Int, weights::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)

    n = length(ᵛʷdata1)
    nvalues = nrolled(n, window_span)

    rettype = rts(window_fn, (Vector{T},))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, window_span::Int, weights::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    nvalues = nrolled(n, window_span)

    rettype = rts(window_fn, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    window_span::Int, weights::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    nvalues = nrolled(n, window_span)

    rettype = rts(window_fn, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    window_span::Int, weights::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))
    nvalues = nrolled(n, window_span)

    rettype = rts(window_fn, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad last

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T},
    window_span::Int, weights::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)

    n = length(ᵛʷdata1)

    nvalues = nrolled(n, window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(window_fn, (Vector{T},))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T},
    window_span::Int, weights::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))

    nvalues = nrolled(n, window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(window_fn, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    window_span::Int, weights::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues = nrolled(n, window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(window_fn, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    window_span::Int, weights::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))

    nvalues = nrolled(min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4)), window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(window_fn, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

#
# multiple weight vectors
#

function basic_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, window_span::Int, 
    weights1::AbstractVector{T}, weights2::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    nvalues = nrolled(n, window_span)

    rettype = rts(window_fn, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    window_span::Int, weights1::AbstractVector{T}, weights2::AbstractVector{T}, weights3::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    nvalues = nrolled(n, window_span)

    rettype = rts(window_fn, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    window_span::Int, weights1::AbstractVector{T}, weights2::AbstractVector{T}, weights3::AbstractVector{T}, weights4::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights4)
    ᵛʷweights4 = asview(weights4)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))
    nvalues = nrolled(n, window_span)

    rettype = rts(window_fn, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights4)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad first

function padded_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T},
    window_span::Int, weights1::AbstractVector{T}, weights2::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))

    nvalues = nrolled(n, window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = 1:padding_span

    rettype = rts(window_fn, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padded_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    window_span::Int, weights1::AbstractVector{T}, weights2::AbstractVector{T}, weights3::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues = nrolled(n, window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = 1:padding_span

    rettype = rts(window_fn, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padded_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    window_span::Int, weights1::AbstractVector{T}, weights2::AbstractVector{T}, weights3::AbstractVector{T}, weights4::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)
    ᵛʷweights4 = asview(weights4)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))

    nvalues = nrolled(min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4)), window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = 1:padding_span

    rettype = rts(window_fn, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights4)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad last


function last_padded_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T},
    window_span::Int, weights1::AbstractVector{T}, weights2::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))

    nvalues = nrolled(n, window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(window_fn, (Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    window_span::Int, weights1::AbstractVector{T}, weights2::AbstractVector{T}, weights3::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues = nrolled(n, window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(window_fn, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    window_span::Int, weights1::AbstractVector{T}, weights2::AbstractVector{T}, weights3::AbstractVector{T}, weights4::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)
    ᵛʷweights4 = asview(weights4)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))

    nvalues = nrolled(n, window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = n-padding_span-1:n

    rettype = rts(window_fn, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{Union{typeof(padding),rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights1, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights2, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights3, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights4)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 

