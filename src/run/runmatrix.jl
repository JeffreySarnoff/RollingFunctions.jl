#=
     basic_running(window_fn::Function, ::Matrix, window_span)
     padded_running(window_fn::Function, ::Matrix, window_span; padding, padlast)

     basic_running(window_fn::Function, ::Matrix, window_span, weights)
     padded_running(window_fn::Function, ::Matrix, window_span, weights; padding, padlast)
=#


function basic_running(window_fn::Function, data1::AbstractMatrix{T}, window_span::Int) where {T}
    ᵛʷdata1 = asview(data1)
    n = length(ᵛʷdata1)
    nvalues = nrolled(n, window_span)
    ntapers = n - nvalues

    rettype = rts(window_fn, (Vector{T},))
    results = Matrix{rettype}(undef, size(data))

    @turbo for idx in 1:ntapers
        @views results[idx] = window_fn(ᵛʷdata1[1:idx])
    end

    ilow, ihigh = 1, window_span
    @tturbo for idx in ntapers+1:n
        @views results[idx, :] .= map(window_fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padded_running(window_fn::Function, data::AbstractMatrix{T}, window_span::Int;
                        padding=nothing) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues  = nrolled(n, window_span) 
    rettype  = Union{typeof(padding), rts(window_fn, (T,))}
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))
    
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1  
    padding_idxs = 1:padding_span

    results = Matrix{Union{typeof(padding), rettype}}(undef, size(ᵛʷdata))  
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, window_span
    @tturbo for idx in window_span:n 
        @views results[idx, :] .= map(window_fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end
    
    results
end


# weighted

function basic_running(window_fn::Function, data::AbstractMatrix{T}, window_span::Int, weights::AbstractVector{T}) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues  = nrolled(n, window_span) 
    # there are 1 or more columns, each holds `n` values
    rettype  = rts(window_fn, (T,))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    ilow, ihigh = 1, window_span
    @tturbo for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(window_fn, eachcol(ᵛʷdata[ilow:ihigh, :] .* weights))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padded_running(window_fn::Function, data::AbstractMatrix{T}, window_span::Int, weights::AbstractVector{T};
                        padding=nothing) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues  = nrolled(n, window_span) 
    rettype  = Union{typeof(padding), rts(window_fn, (T,))}
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))
    
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1  
    padding_idxs = 1:padding_span

    results = Matrix{Union{typeof(padding), rettype}}(undef, size(ᵛʷdata))  
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, window_span
    @tturbo for idx in window_span:n 
        @views results[idx, :] .= map(window_fn, eachcol(ᵛʷdata[ilow:ihigh, :] .* weights))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end
    
    results
end
