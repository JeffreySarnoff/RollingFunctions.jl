#=
   basic_rolling(window_fn, data1, window_span) ..
   basic_rolling(window_fn, data1, data2, data3, data4, window_span)

   padded_rolling(window_fn, data1, window_span; padding, padfirst, padlast) ..
   padded_rolling(window_fn, data1, data2, data3, data4, window_span; padding, padfirst, padlast)

   last_padded_rolling(window_fn, data1, window_span; padding, padfirst, padlast) ..
   last_padded_rolling(window_fn,data1, data2, data3, data4, window_span; padding, padfirst, padlast)

   basic_rolling(window_fn, data1, window_span, weights) ..
   basic_rolling(window_fn, data1, data2, data3, data4, window_span, weights)

   padded_rolling(window_fn, data1, window_span, weights; padding, padfirst, padlast) ..
   padded_rolling(window_fn, data1, data2, data3, data4, window_span, weights; padding, padfirst, padlast)
   
   last_padded_rolling(window_fn, data1, window_span, weights; padding, padfirst, padlast) ..
   last_padded_rolling(window_fn, data1, data2, data3, data4, window_span, weights; padding, padfirst, padlast)
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
    results = Vector{rettype}(undef, nvalues)

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
    results = Vector{rettype}(undef, nvalues)

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
    results = Vector{rettype}(undef, nvalues)

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
    n = length(ᵛʷdata1)
    nvalues  = nrolled(n, window_span)
    rettype  = rts(window_fn, (typeof(ᵛʷdata1),))
 
    # only completed window_span coverings are resolvable
    # the first (window_span - 1) values are unresolved wrt window_fn
    # this is the padding_span
    padding_span = window_span - 1
    padding_idxs = nvalues-padding_span:nvalues

    results = Vector{Union{typeof(padding), rettype}}(undef, n)
    results[padding_idxs] .= padding

    ilow, ihigh = 1, window_span
    @inbounds for idx in window_span:n
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

#=
   basic_rolling(window_fn, data1, window_span, weights) ..
   basic_rolling(window_fn, data1, data2, data3, data4, window_span, weights)
   padded_rolling(window_fn, data1, window_span, weights; padding, padfirst, padlast) ..
   padded_rolling(window_fn, data1, data2, data3, data4, window_span, weights; padding, padfirst, padlast)
   last_padded_rolling(window_fn, data1, window_span, weights; padding, padfirst, padlast) ..
   last_padded_rolling(window_fn, data1, data2, data3, data4, window_span, weights; padding, padfirst, padlast)
=#

function basic_rolling(window_fn::Function, data1::AbstractVector{T1},
                       window_span::Int, weights::AbstractVector{TW}) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_rolling(window_fn, ᵛʷdata1, window_span, ᵛʷweights)
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
                       window_span::Int, weights::AbstractVector{TW}) where {T1,T2, TW}
    typ = promote_type(T1,T2,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights)
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
                       window_span::Int, weights::AbstractVector{TW}) where {T1,T2,T3, TW}
    typ = promote_type(T1,T2,T3,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights)
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                       window_span::Int, weights::AbstractVector{TW}) where {T1,T2,T3,T4, TW}
    typ = promote_type(T1,T2,T3,T4,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights)
end

function basic_rolling(window_fn::Function, data1::Matrix{T1},
                       window_span::Int, weights::AbstractVector{TW}) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_rolling(window_fn, ᵛʷdata1, window_span, ᵛʷweights)
end

# padded rolling

function padded_rolling(window_fn::Function, data1::AbstractVector{T1},
                        window_span::Int, weights::AbstractVector{TW};
                        padding=Nothing, padfirst=true, padlast=false) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_rolling(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding, padfirst, padlast)
end
    
function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
                        window_span::Int, weights::AbstractVector{TW};
                        padding=Nothing, padfirst=true, padlast=false) where {T1,T2, TW}
    typ = promote_type(T1,T2,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights; padding, padfirst, padlast)
end

function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
                        window_span::Int, weights::AbstractVector{TW};
                        padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3, TW}
    typ = promote_type(T1,T2,T3,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights; padding, padfirst, padlast)
end

function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                        window_span::Int, weights::AbstractVector{TW};
                        padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3,T4, TW}
    typ = promote_type(T1,T2,T3,T4,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights; padding, padfirst, padlast)
end

function padded_rolling(window_fn::Function, data1::AbstractMatrix{T1},
                        window_span::Int, weights::AbstractVector{TW};
                        padding=Nothing, padfirst=true, padlast=false) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_rolling(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding, padfirst, padlast)
end

# last_padded rolling

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, 
                             window_span::Int, weights::AbstractVector{TW};
                             padding=Nothing, padfirst=true, padlast=false) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_rolling(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding, padfirst, padlast)
end
    
function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, 
                             window_span::Int, weights::AbstractVector{TW};
                             padding=Nothing, padfirst=true, padlast=false) where {T1,T2, TW}
    typ = promote_type(T1,T2,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights; padding, padfirst, padlast)
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, 
                             window_span::Int, weights::AbstractVector{TW};
                             padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3, TW}
    typ = promote_type(T1,T2,T3,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights; padding, padfirst, padlast)
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                             window_span::Int, weights::AbstractVector{TW};
                             padding=Nothing, padfirst=true, padlast=false) where {T1,T2,T3,T4, TW}
    typ = promote_type(T1,T2,T3,T4,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights; padding, padfirst, padlast)
end


function last_padded_rolling(window_fn::Function, data1::AbstractMatrix{T1}, 
                             window_span::Int, weights::AbstractVector{TW};
                             padding=Nothing, padfirst=true, padlast=false) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_rolling(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding, padfirst, padlast)
end

