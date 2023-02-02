#=
   basic_running(window_fn, data1, window_span) ..
   basic_running(window_fn, data1, data2, data3, data4, window_span)

   padded_running(window_fn, data1, window_span; padding) ..
   padded_running(window_fn, data1, data2, data3, data4, window_span; padding)

   last_padded_running(window_fn, data1, window_span; padding) ..
   last_padded_running(window_fn,data1, data2, data3, data4, window_span; padding)
=#

function basic_running(window_fn::Function, data1::AbstractVector{T}, window_span::Int, weights::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)

    n = length(ᵛʷdata1)
    nvalues  = nrolled(n, window_span)
   
    rettype  = rts(window_fn, (Vector{eltype(ᵛʷdata1)},))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_running(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, window_span::Int, weights::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1),length(ᵛʷdata2))
    nvalues  = nrolled(n, window_span)
   
    rettype  = rts(window_fn, (Vector{eltype(ᵛʷdata1)}, Vector{eltype(ᵛʷdata2)}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_running(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, 
                       window_span::Int, weights::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3))
    nvalues  = nrolled(n, window_span)
   
    rettype  = rts(window_fn, (Vector{eltype(ᵛʷdata1)}, Vector{eltype(ᵛʷdata2)}, Vector{eltype(ᵛʷdata3)}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_running(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
                       window_span::Int, weights::AbstractVector{T}) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3),length(ᵛʷdata4))
    nvalues  = nrolled(n, window_span)
   
    rettype  = rts(window_fn, (Vector{eltype(ᵛʷdata1)}, Vector{eltype(ᵛʷdata2)}, Vector{eltype(ᵛʷdata3)}, Vector{eltype(ᵛʷdata4)}))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


# pad first

function padded_running(window_fn::Function, data1::AbstractVector{T},
                        window_span::Int, weights::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)

    n = length(ᵛʷdata1)

    nvalues  = nrolled(n, window_span) 
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = nvalues-padding_span:nvalues

    rettype  = rts(window_fn, (Vector{eltype(ᵛʷdata1)},))
    results = Vector{Union{typeof(padding), rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in window_span:n
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 

function padded_running(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T},
                        window_span::Int, weights::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
 
    nvalues  = nrolled(n, window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = nvalues-padding_span:nvalues
 
    rettype  = rts(window_fn, (Vector{eltype(ᵛʷdata1)}, Vector{eltype(ᵛʷdata2)}))
    results = Vector{Union{typeof(padding), rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 

function padded_running(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
                        window_span::Int, weights::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues  = nrolled(n, window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = nvalues-padding_span:nvalues
   
    rettype  = rts(window_fn, (Vector{eltype(ᵛʷdata1)}, Vector{eltype(ᵛʷdata2)}, Vector{eltype(ᵛʷdata3)}))
    results = Vector{Union{typeof(padding), rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padded_running(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
                        window_span::Int, weights::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))
      
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3),length(ᵛʷdata4)), window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = nvalues-padding_span:nvalues
   
    rettype  = rts(window_fn, (Vector{eltype(ᵛʷdata1)}, Vector{eltype(ᵛʷdata2)}, Vector{eltype(ᵛʷdata3)}, Vector{eltype(ᵛʷdata4)}))
    results = Vector{Union{typeof(padding), rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 

# pad last

function last_padded_running(window_fn::Function, data1::AbstractVector{T},
                        window_span::Int, weights::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights = asview(weights)

    n = length(ᵛʷdata1)

    nvalues  = nrolled(n, window_span) 
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = n-padding_span-1:n

    rettype  = rts(window_fn, (Vector{eltype(ᵛʷdata1)},))
    results = Vector{Union{typeof(padding), rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 

function last_padded_running(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T},
                        window_span::Int, weights::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2))
 
    nvalues  = nrolled(n, window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = n-padding_span-1:n
 
    rettype  = rts(window_fn, (Vector{eltype(ᵛʷdata1)}, Vector{eltype(ᵛʷdata2)}))
    results = Vector{Union{typeof(padding), rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 

function last_padded_running(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
                        window_span::Int, weights::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3))

    nvalues  = nrolled(n, window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = n-padding_span-1:n
   
    rettype  = rts(window_fn, (Vector{eltype(ᵛʷdata1)}, Vector{eltype(ᵛʷdata2)}, Vector{eltype(ᵛʷdata3)}))
    results = Vector{Union{typeof(padding), rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function last_padded_running(window_fn::Function, data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, data4::AbstractVector{T},
                        window_span::Int, weights::AbstractVector{T}; padding=Nothing) where {T}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    ᵛʷweights = asview(weights)

    n = min(length(ᵛʷdata1), length(ᵛʷdata2), length(ᵛʷdata3), length(ᵛʷdata4))
      
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3),length(ᵛʷdata4)), window_span)
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    padding_span = window_span - 1
    padding_idxs = n-padding_span-1:n
   
    rettype  = rts(window_fn, (Vector{eltype(ᵛʷdata1)}, Vector{eltype(ᵛʷdata2)}, Vector{eltype(ᵛʷdata3)}, Vector{eltype(ᵛʷdata4)}))
    results = Vector{Union{typeof(padding), rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in 1:nvalues
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* ᵛʷweights, ᵛʷdata2[ilow:ihigh] .* ᵛʷweights, ᵛʷdata3[ilow:ihigh] .* ᵛʷweights, ᵛʷdata4[ilow:ihigh] .* ᵛʷweights)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 

