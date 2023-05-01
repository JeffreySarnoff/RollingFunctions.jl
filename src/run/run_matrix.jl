#=
     basic_running(func::Function, ::Matrix, width)
     padfirst_running(func::Function, ::Matrix, width; padding, padlast)

     basic_running(func::Function, ::Matrix, width, weights)
     padfirst_running(func::Function, ::Matrix, width, weights; padding, padlast)
=#


function basic_running(func::Function, data1::AbstractMatrix{T}, width::Span) where {T}
    ᵛʷdata1 = asview(data1)
    n = length(ᵛʷdata1)
    nvalues = nrolled(n, width)
    ntapers = n - nvalues

    rettype = rts(func, (Vector{T},))
    results = Matrix{rettype}(undef, size(data))

    @inbounds for idx in 1:ntapers
        @views results[idx] = func(ᵛʷdata1[1:idx])
    end

    ilow, ihigh = 1, width
    @inbounds for idx in ntapers+1:n
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padfirst_running(func::Function, data::AbstractMatrix{T}, width::Span;
                        padding=nopadding) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues  = nrolled(n, width) 
    rettype  = Union{typeof(padding), rts(func, (T,))}
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))
    
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the padding_width
    padding_width = width - 1  
    padding_idxs = 1:padding_width

    results = Matrix{Union{typeof(padding), rettype}}(undef, size(ᵛʷdata))  
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n 
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end
    
    results
end


# weighted

function basic_running(func::Function, data::AbstractMatrix{T}, width::Span, weights::AbstractWeights{T}) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues  = nrolled(n, width) 
    # there are 1 or more columns, each holds `n` values
    rettype  = rts(func, (T,))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :] .* weights))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padfirst_running(func::Function, data::AbstractMatrix{T}, width::Span, weights::AbstractWeights{T};
                        padding=nopadding) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues  = nrolled(n, width) 
    rettype  = Union{typeof(padding), rts(func, (T,))}
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))
    
    # only completed width coverings are resolvable
    # the first (width - 1) values are unresolved wrt func
    # this is the padding_width
    padding_width = width - 1  
    padding_idxs = 1:padding_width

    results = Matrix{Union{typeof(padding), rettype}}(undef, size(ᵛʷdata))  
    results[padding_idxs, :] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:n 
        @views results[idx, :] .= map(func, eachcol(ᵛʷdata[ilow:ihigh, :] .* weights))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end
    
    results
end
