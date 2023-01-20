function rolling(data::D, window_span::Int, window_fn::F;
                 padding=Nothing, padfirst=true, padlast=false) where {T, D<:AbstractArray{T}, F<:Function}
    if  isNothing(padding)
        basic_rolling(data, window_span, window_fn)
    elseif !padlast
        padded_rolling(data, window_span, window_fn; padding)
    else
        last_padded_rolling(data, window_span, window_fn; padding)
    end
end    
    

function basic_rolling(data::D, window_span::Int, window_fn::F) where {T, D<:AbstractVector{T}, F<:Function}
    ᵛʷdata = asview(data1)
    nvalues = length(ᵛʷdata)
    rettype  = rts(window_fn, (typeof(ᵛʷdata),))

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    unresolved = window_span - 1

    # with the next value, a full window_span is obtained
    # only then is the first window_covered_value determined
    # with each next value (with successive indices), an updated
    # full window_span obtains, covering another window_fn value
    window_covered_values = nvalues - unresolved

    results = Vector{rettype}(undef, window_covered_values)

    ilow, ihigh = 1, window_span

    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(data::D, window_span::Int, window_fn::Function) where {T,D<:AbstractMatrix{T}}
    ᵛʷdata = asview(data)
    # there are 1 or more columns, each holds `nvalues` values
    nvalues = nrows(ᵛʷdata)
    rettype  = rts(window_fn, (typeof(ᵛʷdata[:,1]),))

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    unresolved = window_span - 1

    # with the next value, a full window_span is obtained
    # only then is the first window_covered_value determined
    # with each next value (with successive indices), an updated
    # full window_span obtains, covering another window_fn value
    window_covered_values = nvalues - unresolved

    results = Matrix{rettype}(undef, window_covered_values, ncols(data))

    ilow, ihigh = 1, window_span

    @inbounds for idx in eachindex(eachrow(results))
        @views results[idx, :] .= map(window_fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padded_rolling(data::D, window_span::Int, window_fn::Function;
                        padding = nothing) where {T, D<:AbstractVector{T}}
    ᵛʷdata = asview(data)
    nvalues = length(ᵛʷdata)
    rettype  = rts(window_fn, (typeof(ᵛʷdata),))

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1
  
    padding_idxs = 1:padding_span
    ilow, ihigh = 1, window_span

    results = Vector{Union{typeof(padding), rettype}}(undef, nvalues)
    results[padding_idxs] .= padding

    @inbounds for idx in window_span:nvalues
        @views results[idx] = window_fn(ᵛʷdata[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end  

function padded_rolling(data::D, window_span::Int, window_fn::Function;
                        padding=nothing) where {T, D<:AbstractMatrix{T}}
    ᵛʷdata = asview(data)
    # there are 1 or more columns, each holds `nvalues` values
    nvalues = nrows(data)
    rettype  = rts(window_fn, (typeof(ᵛʷdata[:,1]),))

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1
  
    padding_idxs = 1:padding_span
    ilow, ihigh = 1, window_span

    results = Matrix{Union{typeof(padding), rettype}}(undef, size(data))  
    results[padding_idxs, :] .= padding

    @inbounds for idx in window_span:nvalues
        @views results[idx, :] = map(window_fn, eachcol(ᵛʷdata[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end
   
    results
end   

# pad the last entries, move windowed data back to the first entries
    
function last_padded_rolling(data::D, window_span::Int, window_fn::Function;
                             padding = nothing) where {T, D<:AbstractVector{T}}
    ᵛʷdata = asview(data)
    nvalues = length(data)
    rettype  = rts(window_fn, (typeof(ᵛʷdata),))

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    padding_idxs = nvalues-padding_span:nvalues
    ilow, ihigh = 1, window_span

    results = Vector{Union{typeof(padding), rettype}}(undef, nvalues)
    results[padding_idxs] .= padding

    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end  

function last_padded_rolling(data::D, window_span::Int, window_fn::Function;
                             padding=nothing) where {T, D<:AbstractMatrix{T}}
    ᵛʷdata = asview(data)
    # there are 1 or more columns, each holds `nvalues` values
    nvalues = nrows(ᵛʷdata)
    rettype  = rts(window_fn, (typeof(ᵛʷdata[:,1]),))

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    padding_idxs = nvalues-padding_span:nvalues
    ilow, ihigh = 1, window_span

    results = Matrix{Union{typeof(padding), rettype}}(undef, size(data))
    results[padding_idxs, :] .= padding

     @inbounds for idx in 1:nvalues-padding_span
        @slice results[idx, :] = map(window_fn, eachcol(ᵛʷdata[ilow:ihigh,:]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end
   
    results
end   
