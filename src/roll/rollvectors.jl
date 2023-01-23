#=

   basic_rolling(window_fn, data1, window_span) ..
   basic_rolling(window_fn, data1, data2, data3, data4, window_span)

   padded_rolling(window_fn, data1, window_span; padding, padfirst, padlast) ..
   padded_rolling(window_fn, data1, data2, data3, data4, window_span; padding, padfirst, padlast)

   last_padded_rolling(window_fn, data1, window_span; padding, padfirst, padlast) ..
   last_padded_rolling(window_fn,data1, data2, data3, data4, window_span; padding, padfirst, padlast)

=#

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, window_span::Int) where {T1}
    ᵛʷdata1 = asview(data1)
    nvalues  = nrolled(length(ᵛʷdata1), window_span)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1),))
    results = Vector{rettype}(undef, nvalues)

    ilow, ihigh = 1, window_span
    @inbounds for idx in eachindex(results)
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int) where {T1,T2}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2)), window_span)
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

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, 
                       window_span::Int) where {T1,T2,T3}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3)), window_span)
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

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                       window_span::Int) where {T1,T2,T3,T4}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3),length(ᵛʷdata4)), window_span)
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


# pad first

function padded_rolling(window_fn::Function, data1::AbstractVector{T1},
                        window_span::Int; padding=Nothing, padfirst=true, padlast=false) where {T1}
    ᵛʷdata1 = asview(data1)
    nvalues  = nrolled(length(ᵛʷdata1), window_span)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1),))
 
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    padding_idxs = nvalues-padding_span:nvalues
    ilow, ihigh = 1, window_span

    results = Vector{Union{typeof(padding), rettype}}(undef, nvalues)
    results[padding_idxs] .= padding

    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 

function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
                        window_span::Int; padding=Nothing, padfirst=true, padlast=false) where {T1,T2}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2)), window_span)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1), typeof(ᵛʷdata2)))

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    padding_idxs = nvalues-padding_span:nvalues
    ilow, ihigh = 1, window_span

    results = Vector{Union{typeof(padding), rettype}}(undef, nvalues)
    results[padding_idxs] .= padding

    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 

function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
                        window_span::Int; padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3)), window_span)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1), typeof(ᵛʷdata2), typeof(ᵛʷdata3)))

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    padding_idxs = nvalues-padding_span:nvalues
    ilow, ihigh = 1, window_span

    results = Vector{Union{typeof(padding), rettype}}(undef, nvalues)
    results[padding_idxs] .= padding

    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                        window_span::Int; padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3,T4}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3),length(ᵛʷdata4)), window_span)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1), typeof(ᵛʷdata2), typeof(ᵛʷdata3), typeof(ᵛʷdata4)))

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    padding_idxs = nvalues-padding_span:nvalues
    ilow, ihigh = 1, window_span

    results = Vector{Union{typeof(padding), rettype}}(undef, nvalues)
    results[padding_idxs] .= padding

    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh], ᵛʷdata4[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 

# pad last

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1},
                             window_span::Int; padding=Nothing, padfirst=true, padlast=false) where {T1}
    ᵛʷdata1 = asview(data1)
    nvalues  = nrolled(length(ᵛʷdata1), window_span)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1),))
 
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    padding_idxs = nvalues-padding_span:nvalues
    ilow, ihigh = 1, window_span

    results = Vector{Union{typeof(padding), rettype}}(undef, nvalues)
    results[padding_idxs] .= padding

    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
                             window_span::Int; padding=Nothing, padfirst=true, padlast=false) where {T1,T2}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2)), window_span)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1), typeof(ᵛʷdata2)))

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    padding_idxs = nvalues-padding_span:nvalues
    ilow, ihigh = 1, window_span

    results = Vector{Union{typeof(padding), rettype}}(undef, nvalues)
    results[padding_idxs] .= padding

    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
                             window_span::Int; padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3)), window_span)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1), typeof(ᵛʷdata2), typeof(ᵛʷdata3)))

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    padding_idxs = nvalues-padding_span:nvalues
    ilow, ihigh = 1, window_span

    results = Vector{Union{typeof(padding), rettype}}(undef, nvalues)
    results[padding_idxs] .= padding

    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                             window_span::Int; padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3,T4}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3),length(ᵛʷdata4)), window_span)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1), typeof(ᵛʷdata2), typeof(ᵛʷdata3), typeof(ᵛʷdata4)))

    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1

    padding_idxs = nvalues-padding_span:nvalues
    ilow, ihigh = 1, window_span

    results = Vector{Union{typeof(padding), rettype}}(undef, nvalues)
    results[padding_idxs] .= padding

    @inbounds for idx in 1:nvalues-padding_span
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh], ᵛʷdata2[ilow:ihigh], ᵛʷdata3[ilow:ihigh], ᵛʷdata4[ilow:ihigh])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end 


