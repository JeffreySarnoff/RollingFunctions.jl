
function basic_rolling(data1::AbstractVector{T1}, window_span::Int, window_fn::F) where {T1}
    ᵛʷdata1 = asview(data1)
    nvalues  = nrolled(length(ᵛʷdata1), windowspan)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1),))

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
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int, window_fn::F) where {T1,T2}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2)), windowspan)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1), typeof(ᵛʷdata2)))

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
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, 
                       window_span::Int, window_fn::F) where {T1,T2,T3}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3)), windowspan)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1), typeof(ᵛʷdata2), typeof(ᵛʷdata3)))

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
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data3::AbstractVector{T4}, data4::AbstractVector{T4},
                       window_span::Int, window_fn::F) where {T1,T2,T3}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3),length(ᵛʷdata4)), windowspan)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1), typeof(ᵛʷdata2), typeof(ᵛʷdata3), typeof(ᵛʷdata4)))

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
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end


