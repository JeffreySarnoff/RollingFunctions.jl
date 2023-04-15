#=
     basic_tupled_rolling(func::Function, span, ::Tuple)
     padfirst_tupled_rolling(func::Function, span, ::Tuple; padding)
     padfinal_tupled_rolling(func::Function, span, ::Tuple; padding, padlast)

     basic_tupled_rolling(func::Function, span, ::Matrix, weight)
     padfirst_tupled_rolling(func::Function, span, ::Tuple, weight; padding)
     padfinal_tupled_rolling(func::Function, span, ::Tuple, weight; padding, padlast)
=#

function basic_tupled_rolling(func::Function, span::Span, data::Tuple{<:AbstractVector})
    check_empty(data)
    check_span(span, minimum(map(length, data)))

    nvectors = length(data)
    if nvectors < 4
        return basic_rolling(func, span, data...)
    end
    typ = promote_type(map(eltype, data)...)
    ᵛʷdata = map(dta -> asviewtype(typ, dta), data)

    nvalues = nrolled(n, span)
    rettype = rts(func, map(typeof, ᵛʷdata))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inbounds for idx in eachindex(results)
        @views results[idx] = func((getindex(dta, ilow:ihigh) for dta in ᵛʷdata)...)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies at the start with a given padding value
# do not move the windowed data

function padfirst_tupled_rolling(func::Function, span::Span, data::Tuple{<:AbstractVector}, padding)
    check_empty(data)
    check_span(span, minimum(map(length, data)))

    nvectors = length(data)
    if nvectors < 4
        return padfirst_rolling(func, span, data...)
    end

    typ = promote_type(map(eltype, data)...)
    ᵛʷdata = map(dta -> asviewtype(typ, dta), data)

    nvalues = nrolled(n, span)
    rettype = rts(func, map(typeof, ᵛʷdata))
    results = Vector{rettype}(undef, nvalues)

    padding_span = span - 1
    padding_idxs = 1:padding_span
    results[padding_idxs] .= padding
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in span:nvalues
        @views results[idx] .= func(map(dta -> getindex(dta, ilow:ihigh), data)...)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies at the end with a given padding value
# move windowed data back into the first entries

function padfinal_tupled_rolling(func::Function, span::Span, data::Tuple{<:AbstractVector}, padding)
    check_empty(data)
    check_span(span, minimum(map(length, data)))

    nvectors = length(data)
    if nvectors < 4
        return padfinal_rolling(func, span, data..., weights...)
    end

    typ = promote_type(map(eltype, data)...)
    ᵛʷdata = map(dta -> asviewtype(typ, dta), data)

    nvalues = nrolled(n, span)
    rettype = rts(func, map(typeof, ᵛʷdata))
    results = Vector{rettype}(undef, nvalues)

    padding_span = span - 1
    padding_idxs = n-padding_span:n
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in in
        1:n-padding_span
        @views results[idx] .= func(map(dta -> getindex(dta, ilow:ihigh), data)...)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# with weightings

function basic_tupled_rolling(func::Function, span::Span, data::Tuple{<:AbstractVector}, weights::Tuple{<:AbstractWeights})
    check_empty(data)
    check_empty(weights)
    check_span(minimum(map(length, data)), span)
    check_weights(map(length, weights), span)

    nvectors = length(data)
    if nvectors < 4
        return basic_rolling(func, span, data..., weights...)
    end
    typ = promote_type(map(eltype, data)...)
    ᵛʷdata = map(dta -> asviewtype(typ, dta), data)

    nvalues = nrolled(n, span)
    rettype = rts(func, map(typeof, ᵛʷdata))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, span
    @inbounds for idx in eachindex(results)
        @views results[idx] = func((getindex(dta, ilow:ihigh) for dta in ᵛʷdata)...)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies at the start with a given padding value
# do not move the windowed data

function padfirst_tupled_rolling(func::Function, span::Span, data::Tuple{<:AbstractVector}, weights::Tuple{<:AbstractWeights}, padding)
    check_empty(data)
    check_empty(weights)
    check_span(minimum(map(length, data)), span)
    check_weights(map(length, weights), span)

    nvectors = length(data)
    if nvectors < 4
        return padfirst_rolling(func, span, data...)
    end

    typ = promote_type(map(eltype, data)...)
    ᵛʷdata = map(dta -> asviewtype(typ, dta), data)

    nvalues = nrolled(n, span)
    rettype = rts(func, map(typeof, ᵛʷdata))
    results = Vector{rettype}(undef, nvalues)

    padding_span = span - 1
    padding_idxs = 1:padding_span
    results[padding_idxs] .= padding
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in span:nvalues
        @views results[idx] .= func(map(dta -> getindex(dta, ilow:ihigh), data)...)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies at the end with a given padding value
# move windowed data back into the first entries

function padfinal_tupled_rolling(func::Function, span::Span, data::Tuple{<:AbstractVector}, weights::Tuple{<:AbstractWeights}, padding)
    check_empty(data)
    check_empty(weights)
    check_span(minimum(map(length, data)), span)
    check_weights(map(length, weights), span)

    nvectors = length(data)
    if nvectors < 4
        return padfinal_rolling(func, span, data...)
    end

    typ = promote_type(map(eltype, data)...)
    ᵛʷdata = map(dta -> asviewtype(typ, dta), data)

    nvalues = nrolled(n, span)
    rettype = rts(func, map(typeof, ᵛʷdata))
    results = Vector{rettype}(undef, nvalues)

    padding_span = span - 1
    padding_idxs = n-padding_span:n
    results[padding_idxs] .= padding

    ilow, ihigh = 1, span
    @inbounds for idx in in
        1:n-padding_span
        @views results[idx] .= func(map(dta -> getindex(dta, ilow:ihigh), data)...)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end
