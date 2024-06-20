#=
   basic_running(window_fn, data1, window_span) ..
   basic_running(window_fn, data1, data2, data3, data4, window_span)

   padded_running(window_fn, data1, window_span; padding) ..
   padded_running(window_fn, data1, data2, data3, data4, window_span; padding)
=#

function basic_running(window_fn::Function, data1::AbstractVector{T}, window_span::Int) where {T}
    ᵛʷdata1 = asview(data1)
    n = length(ᵛʷdata1)
    nvalues = nrolled(n, window_span)
    ntapers = n - nvalues

    rettype  = rts(window_fn, (Vector{T},))
    results = Vector{rettype}(undef, n)

    @inbounds for idx in 1:ntapers
        @views results[idx] = window_fn(ᵛʷdata1[1:idx])
    end

    ilow, ihigh = 1, window_span
    @inbounds for idx in ntapers+1:n
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_running(window_fn::Function, 
    data1::AbstractVector{T}, data2::AbstractVector{T}, 
    window_span::Int) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    nvalues = nrolled(n, window_span)
    ntapers = n - nvalues

    rettype  = rts(window_fn, (Vector{T},Vector{T}))
    results = Vector{rettype}(undef, n)

    @inbounds for idx in 1:ntapers
        @views results[idx] = window_fn(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx])
    end

    ilow, ihigh = 1, window_span
    @inbounds for idx in ntapers+1:n
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_running(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, 
                       window_span::Int) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    n = min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3))
    nvalues  = nrolled(n, window_span)
   
    rettype  = rts(window_fn, (Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_running(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
                       window_span::Int) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    n = min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3),length(ᵛʷdata4))
    nvalues  = nrolled(n, window_span)
   
    rettype  = rts(window_fn, (Vector{T}, Vector{T}, Vector{T}, Vector{T}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh], ᵛʷdata4[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad first

function padded_running(window_fn::Function,
    data1::AbstractVector{T},
    window_span::Int; padding::AbstractVector) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷpadding = asview(padding)
    n = length(ᵛʷdata1)
    npads = length(padding)
    nvalues = nrolled(n, window_span)
    ntapers = n - nvalues - npads

    rettype = rts(window_fn, (Vector{T},))
    results = Vector{rettype}(undef, n)

    if npads > 0
        results[1:npads] .= ᵛʷpadding
    end
    @inbounds for idx in npads+1:npads+ntapers
        @views results[idx] = window_fn(ᵛʷdata1[1:idx])
    end

    ilow, ihigh = 1, window_span
    @inbounds for idx in npads+ntapers+1:n
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padded_running(window_fn::Function,
    data1::AbstractVector{T}, data2::AbstractVector{T},
    window_span::Int; padding::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷpadding = asview(padding)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    npads = length(padding)
    nvalues = nrolled(n, window_span)
    ntapers = n - nvalues - npads

    rettype = rts(window_fn, (Vector{T},))
    results = Vector{rettype}(undef, n)

    results[1:npads] .= ᵛʷpadding
    @inbounds for idx in npads+1:npads+ntapers
        @views results[idx] = window_fn(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx])
    end

    ilow, ihigh = 1, window_span
    @inbounds for idx in npads+ntapers+1:n
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padded_running(window_fn::Function,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    window_span::Int; padding::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷpadding = asview(padding)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    npads = length(padding)
    nvalues = nrolled(n, window_span)
    ntapers = n - nvalues - npads

    rettype = rts(window_fn, (Vector{T},))
    results = Vector{rettype}(undef, n)

    results[1:npads] .= ᵛʷpadding
    @inbounds for idx in npads+1:npads+ntapers
        @views results[idx] = window_fn(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx], ᵛʷdata3[1:idx])
    end

    ilow, ihigh = 1, window_span
    @inbounds for idx in npads+ntapers+1:n
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[1:idx])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padded_running(window_fn::Function,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    window_span::Int; padding::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷpadding = asview(padding)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))
    npads = length(padding)
    nvalues = nrolled(n, window_span)
    ntapers = n - nvalues - npads

    rettype = rts(window_fn, (Vector{T},))
    results = Vector{rettype}(undef, n)

    results[1:npads] .= ᵛʷpadding
    @inbounds for idx in npads+1:npads+ntapers
        @views results[idx] = window_fn(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx], ᵛʷdata3[1:idx], ᵛʷdata4[1:idx])
    end

    ilow, ihigh = 1, window_span
    @inbounds for idx in npads+ntapers+1:n
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[1:idx], ᵛʷdata4[1:idx])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


#
# pad last
#

function last_padded_running(window_fn::Function,
    data1::AbstractVector{T},
    window_span::Int; padding::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷpadding = asview(padding)
    n = length(ᵛʷdata1)
    npads = length(padding)
    nvalues = nrolled(n, window_span)
    ntapers = n - nvalues - npads
    padding_idxs = nvalues+1:n

    rettype = rts(window_fn, (Vector{T},))
    results = Vector{rettype}(undef, n)

    results[padding_idxs] .= ᵛʷpadding

    @inbounds for idx in nvalues+1:nvalues+ntapers
        results[idx] = window_fn(ᵛʷdata1[1:idx])
    end

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function last_padded_running(window_fn::Function,
    data1::AbstractVector{T}, data2::AbstractVector{T},
    window_span::Int; padding::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷpadding = asview(padding)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
    npads = length(padding)
    nvalues = nrolled(n, window_span)
    ntapers = n - nvalues - npads
    padding_idxs = nvalues+1:n

    rettype = rts(window_fn, (Vector{T},))
    results = Vector{rettype}(undef, n)

    results[padding_idxs] .= ᵛʷpadding
    @inbounds for idx in nvalues+1:nvalues+ntapers
        results[idx] = window_fn(ᵛʷdata1[1:idx])
    end

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function last_padded_running(window_fn::Function,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    window_span::Int; padding::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷpadding = asview(padding)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))
    npads = length(padding)
    nvalues = nrolled(n, window_span)
    ntapers = n - nvalues - npads
    padding_idxs = nvalues+1:n

    rettype = rts(window_fn, (Vector{T},))
    results = Vector{rettype}(undef, n)

    results[padding_idxs] .= ᵛʷpadding
    @inbounds for idx in npads+1:npads+ntapers
        @views results[idx] = window_fn(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx], ᵛʷdata3[1:idx])
    end

    ilow, ihigh = 1, window_span
    @inbounds for idx in npads+ntapers+1:n
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[1:idx])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function last_padded_running(window_fn::Function,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
    window_span::Int; padding::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷpadding = asview(padding)
    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))
    npads = length(padding)
    nvalues = nrolled(n, window_span)
    ntapers = n - nvalues - npads
    padding_idxs = nvalues+1:n

 
    rettype = rts(window_fn, (Vector{T},))
    results = Vector{rettype}(undef, n)

    results[padding_idxs] .= ᵛʷpadding
    @inbounds for idx in npads+1:npads+ntapers
        @views results[idx] = window_fn(ᵛʷdata1[1:idx], ᵛʷdata2[1:idx], ᵛʷdata3[1:idx])
    end

    ilow, ihigh = 1, window_span
    @inbounds for idx in npads+ntapers+1:n
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[1:idx])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

