#=
   basic_running(func, data1, width) ..
   basic_running(func, data1, data2, data3, data4, width)

   padfirst_running(func, data1, width; padding) ..
   padfirst_running(func, data1, data2, data3, data4, width; padding)
=#

#=
   basic_running(func, data1, width) ..
   basic_running(func, data1, data2, data3, data4, width)

   padfirst_running(func, data1, width; padding) ..
   padfirst_running(func, data1, data2, data3, data4, width; padding)
=#

function basic_running(func::Function, data1::AbstractVector{T}, width::Span, weights::AbstractWeights{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)
    n = length(ᵛʷdata1)
    nvalues = nrolled(n, width)
    ntapers = n - nvalues

    rettype  = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, n)

    @inbounds for idx in 1:ntapers
        wts = fast_normalize(ᵛʷweights[width:-1:width-idx+1])
        @views results[idx] = func(ᵛʷdata1[1:idx] .* wts)
    end

    ilow, ihigh = 1, width
    @inbounds for idx in ntapers+1:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_running(func::Function, 
    data1::AbstractVector{T}, data2::AbstractVector{T}, 
    width::Span, weights::AbstractWeights{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    nvalues = nrolled(n, width)
    ntapers = n - nvalues

    rettype  = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, n)

    @inbounds for idx in 1:ntapers
        wts = fast_normalize(ᵛʷweights[1:idx])
        @views results[idx] = func(ᵛʷdata1[1:idx] .* wts, ᵛʷdata2[1:idx] .* wts)
    end

    ilow, ihigh = 1, width
    @inbounds for idx in ntapers+1:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_running(func::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, 
                       width::Span, weights::AbstractWeights{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)
    n = min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3))
    nvalues  = nrolled(n, width)
    ntapers = n - nvalues
 
    rettype  = rts(func, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    @inbounds for idx in 1:ntapers
        wts = fast_normalize(ᵛʷweights[1:idx])
        @views results[idx] = func(ᵛʷdata1[1:idx] .* wts, ᵛʷdata2[1:idx] .* wts), ᵛʷdata3[1:idx] .* wts
    end

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_running(func::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
                       width::Span, weights::AbstractWeights{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights = asview(weights)
    n = min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3),length(ᵛʷdata4))
    nvalues  = nrolled(n, width)
    ntapers = n - nvalues

    rettype  = rts(func, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    @inbounds for idx in 1:ntapers
        wts = fast_normalize(ᵛʷweights[1:idx])
        @views results[idx] = func(ᵛʷdata1[1:idx] .* wts, ᵛʷdata2[1:idx] .* wts, ᵛʷdata3[1:idx] .* wts, ᵛʷdata4[1:idx] .* wts)
    end

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(results)
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh .* ᵛʷweights], ᵛʷdata4[ilow:ihigh .* ᵛʷweights])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad first

function padfirst_running(func::Function,
    data1::AbstractVector{T},
    width::Span, weights::AbstractWeights{T}; padding::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)
    ᵛʷpadding = asview(padding)
    n = length(ᵛʷdata1)
    npads = length(padding)
    nvalues = nrolled(n, width)
    ntapers = n - nvalues - npads

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, n)

    results[1:npads] .= ᵛʷpadding
    @inbounds for idx in npads+1:npads+ntapers
        @views results[idx] = func(ᵛʷdata1[1:idx])
    end

    ilow, ihigh = 1, width
    @inbounds for idx in npads+ntapers+1:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_running(func::Function,
    data1::AbstractVector{T}, data2::AbstractVector{T},
    width::Span, weights::AbstractWeights{T}; padding::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)
    ᵛʷpadding = asview(padding)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    npads = length(padding)
    nvalues = nrolled(n, width)
    ntapers = n - nvalues - npads

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, n)

    results[1:npads] .= ᵛʷpadding
    @inbounds for idx in npads+1:npads+ntapers
        @views results[idx] = func(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx])
    end

    ilow, ihigh = 1, width
    @inbounds for idx in npads+ntapers+1:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_running(func::Function,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    width::Span, weights::AbstractWeights{T}; padding::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)
    ᵛʷpadding = asview(padding)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    npads = length(padding)
    nvalues = nrolled(n, width)
    ntapers = n - nvalues - npads

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, n)

    results[1:npads] .= ᵛʷpadding
    @inbounds for idx in npads+1:npads+ntapers
        @views results[idx] = func(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx], ᵛʷdata3[1:idx])
    end

    ilow, ihigh = 1, width
    @inbounds for idx in npads+ntapers+1:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[1:idx])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padfirst_running(func::Function,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    width::Span, weights::AbstractWeights{T}; padding::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights = asview(weights)
    ᵛʷpadding = asview(padding)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))
    npads = length(padding)
    nvalues = nrolled(n, width)
    ntapers = n - nvalues - npads

    rettype = rts(func, (Vector{T},))
    results = Vector{rettype}(undef, n)

    results[1:npads] .= ᵛʷpadding
    @inbounds for idx in npads+1:npads+ntapers
        @views results[idx] = func(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx], ᵛʷdata3[1:idx], ᵛʷdata4[1:idx])
    end

    ilow, ihigh = 1, width
    @inbounds for idx in npads+ntapers+1:n
        @views results[idx] = func(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[1:idx], ᵛʷdata4[1:idx])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end
