#=
     basic_rolling(window_fn::Function, ::Matrix, window_span)

     padded_rolling(window_fn::Function, ::Matrix, window_span; padding, padfirst, padlast)

     last_padded_rolling(window_fn::Function, ::Matrix, window_span; padding, padfirst, padlast)
=#

function basic_rolling(window_fn::Function, data::AbstractMatrix{T}, window_span::Int) where {T}
    ᵛʷdata = asview(data)
    n = nrows(ᵛʷdata)
    nvalues  = nrolled(n, window_span) 
    # there are 1 or more columns, each holds `n` values
    rettype  = rts(window_fn, (eltype(ᵛʷdata),))
    results = Matrix{rettype}(undef, (nvalues, ncols(ᵛʷdata)))

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(window_fn, eachcol(data[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padded_rolling(window_fn::Function, data::AbstractMatrix{T}, window_span::Int;
    padding=nothing, padfirst=true, padlast=false) where {T}
    ᵛʷdata = asview(data)
    # there are 1 or more columns, each holds `n` values
    nvalues = nrows(ᵛʷdata)
    rettypes  = rts.(Ref(window_fn), map(typeof, ᵛʷdata[1,:]))
    
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1
  
    padding_idxs = 1:padding_span
    ilow, ihigh = 1, window_span

    results = Matrix{Union{typeof(padding), rettypes}}(undef, size(ᵛʷdata))  
    results[padding_idxs, :] .= padding

    @inbounds for idx in window_span:nvalues
        @views results[idx, :] = map(window_fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end
   
    results
end

# pad the last entries, move windowed data back to the first entries

function last_padded_rolling(window_fn::Function, data::AbstractMatrix{T}, window_span::Int;
     padding=nothing, padfirst=true, padlast=false) where {T}
    ᵛʷdata = asview(data)
    # there are 1 or more columns, each holds `n` values
    nvalues = nrows(ᵛʷdata)
    rettypes  = rts.(Ref(window_fn), map(typeof, ᵛʷdata[1,:]))
    
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1
    padding_idxs = nvalues-padding_span:nvalues
   
    results = Matrix{Union{typeof(padding), rettypes}}(undef, size(ᵛʷdata))  
    results[padding_idxs, :] .= padding

    @inbounds for idx in 1:nvalues-padding_span
        results[idx, :] = map(window_fn, eachcol(data[ilow:ihigh,:]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end
   
    results
end   


