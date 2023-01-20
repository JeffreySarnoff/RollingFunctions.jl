#=

   basic_rolling(data1, window_span, window_fn, weights) ..
   basic_rolling(data1, data2, data3, data4, window_span, window_fn, weights)

   padded_rolling(data1, window_span, window_fn, weights; padding, padfirst, padlast) ..
   padded_rolling(data1, data2, data3, data4, window_span, window_fn, weights; padding, padfirst, padlast)

   last_padded_rolling(data1, window_span, window_fn, weights; padding, padfirst, padlast) ..
   last_padded_rolling(data1, data2, data3, data4, window_span, window_fn, weights; padding, padfirst, padlast)

=#


function basic_rolling(data1::AbstractVector{T1}, window_span::Int, window_fn::F, weights::AbstractVector{TW}) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_rolling(ᵛʷdata1, window_span, window_fn, ᵛʷweights)
end
    
function basic_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int, window_fn::F, weights::TW) where {T1,T2, TW}
    typ = promote_type(T1,T2,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_rolling(ᵛʷdata1, ᵛʷdata2, window_span, window_fn, ᵛʷweights)
end

function basic_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, window_span::Int, window_fn::F, weights::TW) where {T1,T2,T3, TW}
    typ = promote_type(T1,T2,T3,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_rolling(ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, window_fn, ᵛʷweights)
end

function basic_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4}, window_span::Int, window_fn::F, weights::TW) where {T1,T2,T3,T4, TW}
    typ = promote_type(T1,T2,T3,T4,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_rolling(ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, window_fn, ᵛʷweights)
end

# padded rolling

function padded_rolling(data1::AbstractVector{T1}, window_span::Int, window_fn::F, weights::AbstractVector{TW};
                        padding=Nothing, padfirst=true, padlast=false) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_rolling(ᵛʷdata1, window_span, window_fn, ᵛʷweights; padding, padfirst, padlast)
end
    
function padded_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int, window_fn::F, weights::TW;
                        padding=Nothing, padfirst=true, padlast=false) where {T1,T2, TW}
    typ = promote_type(T1,T2,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_rolling(ᵛʷdata1, ᵛʷdata2, window_span, window_fn, ᵛʷweights; padding, padfirst, padlast)
end

function padded_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, window_span::Int, window_fn::F, weights::TW;
                        padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3, TW}
    typ = promote_type(T1,T2,T3,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_rolling(ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, window_fn, ᵛʷweights; padding, padfirst, padlast)
end

function padded_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4}, window_span::Int, window_fn::F, weights::TW;
                        padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3,T4, TW}
    typ = promote_type(T1,T2,T3,T4,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_rolling(ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, window_fn, ᵛʷweights; padding, padfirst, padlast)
end

# last_padded rolling

function last_padded_rolling(data1::AbstractVector{T1}, window_span::Int, window_fn::F, weights::AbstractVector{TW};
                        padding=Nothing, padfirst=true, padlast=false) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_rolling(ᵛʷdata1, window_span, window_fn, ᵛʷweights; padding, padfirst, padlast)
end
    
function last_padded_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int, window_fn::F, weights::TW;
                        padding=Nothing, padfirst=true, padlast=false) where {T1,T2, TW}
    typ = promote_type(T1,T2,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_rolling(ᵛʷdata1, ᵛʷdata2, window_span, window_fn, ᵛʷweights; padding, padfirst, padlast)
end

function last_padded_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, window_span::Int, window_fn::F, weights::TW;
                        padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3, TW}
    typ = promote_type(T1,T2,T3,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_rolling(ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, window_fn, ᵛʷweights; padding, padfirst, padlast)
end

function last_padded_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4}, window_span::Int, window_fn::F, weights::TW;
                        padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3,T4, TW}
    typ = promote_type(T1,T2,T3,T4,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_rolling(ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, window_fn, ᵛʷweights; padding, padfirst, padlast)
end


# implementions

function basic_rolling(data1::AbstractVector{T}, window_span::Int, window_fn::F, weights::AbstractVector{T}) where {T}
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
        @views results[idx] = window_fn(ᵛʷdata1[ilow:ihigh] .* weights[ilow])
        ilow = ilow + 1
        ihigh = ihigh + 1
    end

    results
end

function basic_rolling(data1::AbstractVector{T}, data2::AbstractVector{T}, window_span::Int, window_fn::F, weights::T) where {T}
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

function basic_rolling(data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T}, 
                       window_span::Int, window_fn::F, weights::AbstractVector{T}) where {T}
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


# pad first

function padded_rolling(data1::AbstractVector{T1},
                        window_span::Int, window_fn::F; padding=Nothing, padfirst=true, padlast=false) where {T1}
    ᵛʷdata1 = asview(data1)
    nvalues  = nrolled(length(ᵛʷdata1), windowspan)
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

function padded_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2},
                        window_span::Int, window_fn::F; padding=Nothing, padfirst=true, padlast=false) where {T1,T2}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2)), windowspan)
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

function padded_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
                        window_span::Int, window_fn::F; padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3)), windowspan)
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

function padded_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                        window_span::Int, window_fn::F; padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3,T4}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3),length(ᵛʷdata4)), windowspan)
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

function last_padded_rolling(data1::AbstractVector{T1},
                             window_span::Int, window_fn::F; padding=Nothing, padfirst=true, padlast=false) where {T1}
    ᵛʷdata1 = asview(data1)
    nvalues  = nrolled(length(ᵛʷdata1), windowspan)
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

function last_padded_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2},
                             window_span::Int, window_fn::F; padding=Nothing, padfirst=true, padlast=false) where {T1,T2}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2)), windowspan)
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

function last_padded_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
                             window_span::Int, window_fn::F; padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3)), windowspan)
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

function last_padded_rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                             window_span::Int, window_fn::F; padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3,T4}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷdata4 = asview(data4)
    nvalues  = nrolled(min(length(ᵛʷdata1),length(ᵛʷdata2),length(ᵛʷdata3),length(ᵛʷdata4)), windowspan)
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

