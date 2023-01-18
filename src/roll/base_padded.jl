function rolling(data::D, window_span::Int, window_fn::F;
                 padding=nothing, padfirst=true, padlast=false) where {T, D<:AbstractArray{T}, F<:Function}
    if  isnothing(padding)
        basic_rolling(data, window_span, window_fn)
    elseif padlast
        last_padded_rolling(data, window_span, window_fn; padding)
    else
        padded_rolling(data, window_span, window_fn; padding)
    end
end    
    

function basic_rolling(data::D, window_span::Int, window_fn::F) where {T, D<:AbstractVector{T}, F<:Function}
    # there are 1 or more columns, each holds `n` values
    nvalues = nrows(data)

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    unresolved = window_span - 1

    # with the next value, a full window_span is obtained
    # only then is the first window_covered_value determined
    # with each next value (with successive indices), an updated
    # full window_span obtains, covering another window_fn value
    window_covered_values = nvalues - unresolved

    results = Vector{eltype(data)}(undef, window_covered_values)

    ilow, ihigh = 1, window_span

    @inbounds for idx in eachindex(results)
        results[idx] = window_fn(data[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(data::D, window_span::Int, window_fn::Function) where {T,D<:AbstractMatrix{T}}
    # there are 1 or more columns, each holds `n` values
    nvalues = nrows(data)

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    unresolved = window_span - 1

    # with the next value, a full window_span is obtained
    # only then is the first window_covered_value determined
    # with each next value (with successive indices), an updated
    # full window_span obtains, covering another window_fn value
    window_covered_values = nvalues - unresolved

    results = Matrix{eltype(data)}(undef, window_covered_values, ncols(data))

    ilow, ihigh = 1, window_span

    @inbounds for idx in eachindex(eachrow(results))
        results[idx, :] .= map(window_fn, eachcol(data[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies with a given padding value

function padded_rolling(data::D, window_span::Int, window_fn::Function;
                        padding = nothing) where {T, D<:AbstractVector{T}}
    # there are 1 or more columns, each holds `n` values
    nvalues = nrows(data)

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1
  
    results = Vector{Union{typeof(padding), eltype(data)}}(undef, nvalues)

    padding_idxs = 1:padding_span
    windows_idxs = window_span:nvalues
    ilow, ihigh = 1, window_span

    results[padding_idxs] .= padding

    @inbounds for idx in window_span:nvalues
        results[idx] = window_fn(data[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end  

function padded_rolling(data::D, window_span::Int, window_fn::Function;
                        padding=nothing) where {T, D<:AbstractMatrix{T}}
    # there are 1 or more columns, each holds `n` values
    nvalues = nrows(data)

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1
  
    results = Matrix{Union{typeof(padding), eltype(data)}}(undef, size(data))

  
    padding_idxs = 1:padding_span
    windows_idxs = window_span:nvalues
    ilow, ihigh = 1, window_span
  
    results[padding_idxs, :] .= padding

    @inbounds for idx in window_span:nvalues
        results[idx, :] = map(window_fn, eachcol(data[ilow:ihigh, :]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end
   
    results
end   

# pad the last entries, move windowed data back to the first entries
    
function last_padded_rolling(data::D, window_span::Int, window_fn::Function;
                        padding = nothing) where {T, D<:AbstractVector{T}}
    # there are 1 or more columns, each holds `n` values
    nvalues = nrows(data)

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    results = Vector{Union{typeof(padding), eltype(data)}}(undef, nvalues)

    padding_idxs = 1:padding_span
    windows_idxs = window_span:nvalues
    ilow, ihigh = 1, window_span

    results[padding_idxs] .= padding

    @inbounds for idx in 1:nvalues-padding_span
        results[idx] = window_fn(data[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end  

function last_padded_rolling(data::D, window_span::Int, window_fn::Function;
                        padding=nothing) where {T, D<:AbstractMatrix{T}}
    # there are 1 or more columns, each holds `n` values
    nvalues = nrows(data)

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    results = Matrix{Union{typeof(padding), eltype(data)}}(undef, size(data))

    padding_idxs = 1:padding_span
    windows_idxs = window_span:nvalues
    ilow, ihigh = 1, window_span

    results[padding_idxs, :] .= padding

     @inbounds for idx in 1:nvalues-padding_span
        results[idx, :] = map(window_fn, eachcol(data[ilow:ihigh,:]))
        ilow = ilow + 1
        ihigh = ihigh + 1
    end
   
    results
end   
