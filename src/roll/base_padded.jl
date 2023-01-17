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
        ilow += 1
        ihigh += 1
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
        ilow += 1
        ihigh += 1
    end

    results
end

function padded_rolling(data::D, window_span::Int, window_fn::Function;
                        padfirst::Bool=false, padlast::Bool=false, padding = missing) where {T, D<:AbstractVector{T}}
    !padfirst && !padlast && return basic_rolling(data, window_span, window_fn)

    # there are 1 or more columns, each holds `n` values
    nvalues = nrows(data)

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    # with the next value, a full window_span is obtained
    # only then is the first window_covered_value determined
    # with each next value (with successive indices), an updated
    # full window_span obtains, covering another window_fn value
    window_covered_values = nvalues - padding_span
    nwindows = div(window_covered_values, window_span)

    results = Vector{Union{typeof(padding), eltype(data)}}(undef, nvalues)

    if padfirst
        padding_idxs = 1:padding_span                                                                                                                             windows_idxs = window_span:nvalues
        windows_idxs = padding_span+1:nvalues
        ilow, ihigh = padding_span+1, padding_span+windowspan
    else
        padding_idxs = nvalues-padding_span+1:nvalues
        windows_idxs = 1:nvalues-padding_span
        ilow, ihigh = 1, window_span
    end

    results[padding_idxs] .= padding

    @inbounds for idx in windows_idxs
        results[idx] = window_fn(data[ilow:ihigh])
        ilow += 1
        ihigh += 1
    end

    results
end  

function padded_rolling(data::D, window_span::Int, window_fn::Function;
                        padfirst::Bool=false, padlast::Bool=false, padding = missing) where {T, D<:AbstractMatrix{T}}
    !padfirst && !padlast && return basic_rolling(data, window_span, window_fn)

    # there are 1 or more columns, each holds `n` values
    nvalues = nrows(data)

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    # with the next value, a full window_span is obtained
    # only then is the first window_covered_value determined
    # with each next value (with successive indices), an updated
    # full window_span obtains, covering another window_fn value
    window_covered_values = nvalues - padding_span
    nwindows = div(window_covered_values, window_span)

    results = Matrix{Union{typeof(padding), eltype(data)}}(undef, size(data)...)

    if padfirst
        padding_idxs = 1:padding_span
        windows_idxs = window_span:nvalues
        ilow, ihigh = padding_span+1, nvalues
    else
        padding_idxs = nvalues-padding_span+1:nvalues
        windows_idxs = 1:nvalues-padding_span
        ilow, ihigh = 1, nvalues-padding_span
    end

    results[padding_idxs, :] .= padding

    @inbounds for idx in windows_idxs
        results[idx, :] .= map(window_fn, data[idx, :])
        ilow += 1
        ihigh += 1
    end

    results
end   
