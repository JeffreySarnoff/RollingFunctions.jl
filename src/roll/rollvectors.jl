#=
   basic_rolling(func, span, data1) ..
   basic_rolling(func, span, data1, data2, data3)

   padfirst_rolling(func, span, data1; padding) ..
   padfirst_rolling(func, span, data1, data2, data3; padding)

   padfinal_rolling(func, span, data1; padding) ..
   padfinal_rolling(func, span, data1, data2, data3; padding)
=#

function basic_rolling(func::Function, span::Span,
                       data1::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    n = length(ᵛʷdata1)
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
                       data1::AbstractVector{T}, data2::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    nvalues = nrolled(n, span)

    rettype = rts(func, (Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inbounds for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(func::Function,     span::Span,
                       data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
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

# pad first

function padfirst_rolling(func::Function, span::Span, data1::AbstractVector{T},
    ; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    n = length(ᵛʷdata1)

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

function padfirst_rolling(func::Function, span::Span,data1::AbstractVector{T}, data2::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))

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

function padfirst_rolling(func::Function, span::Span,data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

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

# pad last

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
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
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
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
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfinal_rolling(func::Function, span::Span, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}; padding=nopadding) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
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
    @inbounds for idx in 1:nvalues
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

