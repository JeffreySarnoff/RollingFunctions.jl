#=
     basic_tupled_rolling(func::Function, width, ::Tuple)
     padfirst_tupled_rolling(func::Function, width, ::Tuple; padding)
     padfinal_tupled_rolling(func::Function, width, ::Tuple; padding, atend)

     basic_tupled_rolling(func::Function, width, ::Matrix, weight)
     padfirst_tupled_rolling(func::Function, width, ::Tuple, weight; padding)
     padfinal_tupled_rolling(func::Function, width, ::Tuple, weight; padding, atend)
=#

function basic_tupled_rolling(func::Function, width::Integer, data::TupleOfVectors)
    check_empty(data)
    check_width(minimum(map(length, data)), width)

    nvectors = length(data)
    if nvectors < 4
        return basic_rolling(func, width, data...)
    end
    typ = promote_type(map(eltype, data)...)
    ᵛʷdata = map(dta -> asviewtype(typ, dta), data)

    nvalues = rolling_wholes(minimum(map(length, data)), width)
    rettype = rts(func, map(typeof, ᵛʷdata))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(results)
        @views results[idx] = func((getindex(dta, ilow:ihigh) for dta in ᵛʷdata)...)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies at the start with a given padding value
# do not move the windowed data

function padfirst_tupled_rolling(func::Function, width::Integer, data::TupleOfVectors, padding)
    check_empty(data)
    check_width(minimum(map(length, data)), width)

    nvectors = length(data)
    if nvectors < 4
        return padfirst_rolling(func, width, data...)
    end

    typ = promote_type(map(eltype, data)...)
    ᵛʷdata = map(dta -> asviewtype(typ, dta), data)

    nvalues = rolling_wholes(minimum(map(length, data)), width)
    rettype = rts(func, map(typeof, ᵛʷdata))
    results = Vector{rettype}(undef, nvalues)

    padding_width = width - 1
    padding_idxs = 1:padding_width
    results[padding_idxs] .= padding
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:nvalues
        @views results[idx] .= func(map(dta -> getindex(dta, ilow:ihigh), data)...)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies at the end with a given padding value
# move windowed data back into the first entries

function padfinal_tupled_rolling(func::Function, width::Integer, data::TupleOfVectors, padding)
    check_empty(data)
    check_width(minimum(map(length, data)), width)

    nvectors = length(data)
    if nvectors < 4
        return padfinal_rolling(func, width, data..., weights...)
    end

    typ = promote_type(map(eltype, data)...)
    ᵛʷdata = map(dta -> asviewtype(typ, dta), data)

    nvalues = rolling_wholes(minimum(map(length, data)), width)
    rettype = rts(func, map(typeof, ᵛʷdata))
    results = Vector{rettype}(undef, nvalues)

    padding_width = width - 1
    padding_idxs = n-padding_width:n
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in in
        1:n-padding_width
        @views results[idx] .= func(map(dta -> getindex(dta, ilow:ihigh), data)...)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

#
# with weightings
#

function basic_tupled_rolling(func::Function, width::Integer, data::TupleOfVectors, weights::TupleOfWeights)
    check_empty(data)
    check_empty(weights)
    check_width(minimum(map(length, data)), width)
    check_weights(map(length, weights), width)
    check_lengths(length(data), length(weights))

    nvectors = length(data)
    if nvectors < 4
        return basic_rolling(func, width, data..., weights...)
    end
    typ = promote_type(map(eltype, data)...)
    ᵛʷdata = map(dta -> asviewtype(typ, dta), data)
    ᵛʷweight = (map(dta -> asviewtype(typ, dta), map(Vector{typ},weights)))

    nvalues = rolling_wholes(minimum(map(length, data)), width)
    rettype = rts(func, map(typeof, ᵛʷdata))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, width
    @inbounds for idx in eachindex(results)
        currdata = map((c,w)->c .* w,  (getindex(dta, ilow:ihigh) for dta in ᵛʷdata), ᵛʷweight)
        @views results[idx] = func(currdata...)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies at the start with a given padding value
# do not move the windowed data

function padfirst_tupled_rolling(func::Function, width::Integer, data::TupleOfVectors, weights::TupleOfWeights, padding)
    check_empty(data)
    check_empty(weights)
    check_width(minimum(map(length, data)), width)
    check_weights(map(length, weights), width)
    check_lengths(length(data), length(weights))

    nvectors = length(data)
    if nvectors < 4
        return padfirst_rolling(func, width, data..., weights...)
    end
    typ = promote_type(typeof(padding), map(eltype, data)...)
    ᵛʷdata = map(dta -> asviewtype(typ, dta), data)
    wtyp = promote_type(map(eltype, data)...)
    ᵛʷweight = (map(dta -> asviewtype(wtyp, dta), map(Vector{wtyp}, weights)))

    nvalues = rolling_wholes(minimum(map(length, data)), width)
    rettype = rts(func, map(typeof, ᵛʷdata))
    results = Vector{rettype}(undef, nvalues)

    padding_width = width - 1
    padding_idxs = 1:padding_width
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in width:nvalues
        currdata = map((c,w)->c .* w,  (getindex(dta, ilow:ihigh) for dta in ᵛʷdata), ᵛʷweight)
        @views results[idx] = func(currdata...)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

# pad the dropped indicies at the end with a given padding value
# move windowed data back into the first entries

function padfinal_tupled_rolling(func::Function, width::Integer, data::TupleOfVectors, weights::TupleOfWeights, padding)
    check_empty(data)
    check_empty(weights)
    check_width(minimum(map(length, data)), width)
    check_weights(map(length, weights), width)
    check_lengths(length(data), length(weights))

    nvectors = length(data)
    if nvectors < 4
        return padfinal_rolling(func, width, data..., weights...)
    end
    typ = promote_type(typeof(padding), map(eltype, data)...)
    ᵛʷdata = map(dta -> asviewtype(typ, dta), data)
    wtyp = promote_type(map(eltype, data)...)
    ᵛʷweight = (map(dta -> asviewtype(wtyp, dta), map(Vector{wtyp}, weights)))

    nvalues = rolling_wholes(minimum(map(length, data)), width)
    rettype = rts(func, map(typeof, ᵛʷdata))
    results = Vector{rettype}(undef, nvalues)

    padding_width = width - 1
    padding_idxs = n-padding_width:n
    results[padding_idxs] .= padding

    ilow, ihigh = 1, width
    @inbounds for idx in in
        1:n-padding_width
        currdata = map((c, w) -> c .* w, (getindex(dta, ilow:ihigh) for dta in ᵛʷdata), ᵛʷweight)
        @views results[idx] = func(currdata...)
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end
