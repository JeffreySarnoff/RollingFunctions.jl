function running(window_fn::F, window_span::Int,
                 data1::AbstractVector{T1};
                 padding=nopadding) where {T1,F<:Function}
    if isnopadding(padding)
        basic_running(window_fn, window_span, data1)
    else
        padded_running(window_fn, window_span, data1; padding)
    end
end

function running(window_fn::F, window_span::Int, 
                 data1::AbstractVector{T1}, data2::AbstractVector{T2};
                 padding=nopadding) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_running(window_fn, window_span, data1, data2)
    else
        padded_running(window_fn, window_span, data1, data2; padding)
    end
end

function running(window_fn::F, window_span::Int,
                 data1::AbstractVector{T1}, data2::AbstractVector{T2}, data...;
                 padding=nopadding) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_running(window_fn, window_span, data1, data2, data)
    else
        padded_running(window_fn, window_span, data1, data2, data; padding)
    end
end

function running(window_fn::F, window_span::Int, 
                 data1::AbstractMatrix{T1};
                 padding=nopadding) where {T1,F<:Function}
    if isnopadding(padding)
        basic_running(window_fn, window_span, data1)
    else
        padded_running(window_fn, window_span, data1; padding)
    end
end

# weighted

function running(window_fn::F, window_span::Int,
                 data1::AbstractVector{T1}, 
                 weights::AbstractVector{TW};
                 padding=nopadding) where {T1,TW,F<:Function}
    if isnopadding(padding)
        basic_running(window_fn, window_span, data1, weights)
    else
        padded_running(window_fn, window_span, data1, weights; padding)
    end
end

function running(window_fn::F, window_span::Int,
                 data1::AbstractVector{T1}, data2::AbstractVector{T2},
                 weights::AbstractVector{TW};
                 padding=nopadding) where {T1,T2,TW,F<:Function}
    if isnopadding(padding)
        basic_running(window_fn, window_span, data1, data2, weights)
    else
        padded_running(window_fn, window_span, data1, data2, weights; padding)
    end
end

function running(window_fn::F, window_span::Int,
                 data1::AbstractVector{T1}, data2::AbstractVector{T2}, data...,                weights::AbstractVector{TW};
                 padding=nopadding) where {T1,T2,TW,F<:Function}
    if isnopadding(padding)
        basic_running(window_fn, window_span, data1, data2, data, weights)
    else
        padded_running(window_fn, window_span, data1, data2, data, weights; padding)
    end
end

function running(window_fn::F, window_span::Int, 
                 data1::AbstractMatrix{T1}, 
                 weights::AbstractVector{TW};
                 padding=nopadding) where {T1,TW,F<:Function}
    if isnopadding(padding)
        basic_running(window_fn, window_span, data1, weights)
    else
        padded_running(window_fn, window_span, data1, weights; padding)
    end
end

#
# multivector multiweights
#

# weighted

function running(window_fn::F, window_span::Int,
                data1::AbstractVector{T1}, data2::AbstractVector{T2},
                weights1::AbstractVector{TW}, weights2::AbstractVector{TW};
                padding=nopadding) where {T1,T2,TW,F<:Function}
    if isnopadding(padding)
        basic_running(window_fn, window_span, data1, data2, weights1, weights2)
    else
        padded_running(window_fn, window_span, data1, data2, weights1, weights2; padding)
    end
end

function running(window_fn::F, window_span::Int,
                 data1::AbstractVector{T1}, data2::AbstractVector{T2}, data...,
    weights1::AbstractVector{TW}, weights2::AbstractVector{TW}, weights...;
    padding=nopadding) where {T1,T2,T3,TW,F<:Function}
    if isnopadding(padding)
        basic_running(window_fn, data1, data2, data3, window_span, weights1, weights2, weights3)
    else
        padded_running(window_fn, data1, data2, data3, window_span, weights1, weights2, weights3; padding)
    end
end

function running(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Int,
    weights1::AbstractVector{TW}, weights2::AbstractVector{TW}, weights3::AbstractVector{TW}, weights4::AbstractVector{TW};
    padding=nopadding) where {T1,T2,T3,T4,TW,F<:Function}
    if isnopadding(padding)
        basic_running(window_fn, data1, data2, data3, data4, window_span, weights1, weights2, weights3, weights4)
    else
        padded_running(window_fn, data1, data2, data3, data4, window_span, weights1, weights2, weights3, weights4; padding)
    end
end



# intermediate functional forms

#=
   basic_running(window_fn, data1, window_span) ..
   basic_running(window_fn, data1, data2, data3, data4, window_span)
   padded_running(window_fn, data1, window_span; padding, padlast) ..
   padded_running(window_fn, data1, data2, data3, data4, window_span; padding, padlast)
   last_padded_running(window_fn, data1, window_span; padding, padlast) ..
   last_padded_running(window_fn, data1, data2, data3, data4, window_span; padding, padlast)
=#

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    window_span::Int) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))

    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, window_span)
end

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Int) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span)
end

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Int) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))

    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span)
end

# padded running

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    window_span::Int;
    padding) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))

    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, window_span; padding)
end

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Int;
    padding::AbstractVector) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span; padding)
end

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Int;
    padding::AbstractVector) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))

    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span; padding)
end

#=
   basic_running(window_fn, data1, window_span, weights) ..
   basic_running(window_fn, data1, data2, data3, data4, window_span, weights)
   padded_running(window_fn, data1, window_span, weights; padding) ..
   padded_running(window_fn, data1, data2, data3, data4, window_span, weights; padding)
   last_padded_running(window_fn, data1, window_span, weights; padding) ..
   last_padded_running(window_fn, data1, data2, data3, data4, window_span, weights; padding)
=#

function basic_running(window_fn::Function, data1::AbstractVector{T1},
    window_span::Int, weights::AbstractVector{TW}) where {T1,TW}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_running(window_fn, ᵛʷdata1, window_span, ᵛʷweights)
end

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    window_span::Int, weights::AbstractVector{TW}) where {T1,T2,TW}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights)
end

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Int, weights::AbstractVector{TW}) where {T1,T2,T3,TW}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights)
end

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Int, weights::AbstractVector{TW}) where {T1,T2,T3,T4,TW}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights)
end

function basic_running(window_fn::Function, data1::Matrix{T1},
    window_span::Int, weights::AbstractVector{TW}) where {T1,TW}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_running(window_fn, ᵛʷdata1, window_span, ᵛʷweights)
end

# padded running

function padded_running(window_fn::Function, data1::AbstractVector{T1},
    window_span::Int, weights::AbstractVector{TW};
    padding::AbstractVector) where {T1,TW}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padded_running(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding)
end

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    window_span::Int, weights::AbstractVector{TW};
    padding::AbstractVector) where {T1,T2,TW}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights; padding)
end

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Int, weights::AbstractVector{TW};
    padding::AbstractVector) where {T1,T2,T3,TW}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights; padding)
end

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Int, weights::AbstractVector{TW};
    padding::AbstractVector) where {T1,T2,T3,T4,TW}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights; padding)
end

function padded_running(window_fn::Function, data1::AbstractMatrix{T1},
    window_span::Int, weights::AbstractVector{TW};
    padding=nopadding) where {T1,TW}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padded_running(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding)
end

#
# multivector multiweights
#

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    window_span::Int, weights1::AbstractVector{TW}, weights2::AbstractVector{TW}) where {T1,T2,TW}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    if typ == TW
        ᵛʷweights1 = asview(weights1)
        ᵛʷweights2 = asview(weights2)
    else
        ᵛʷweights1 = asview(map(typ, weights1))
        ᵛʷweights2 = asview(map(typ, weights2))
    end

    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights1, ᵛʷweights2)
end

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Int, weights1::AbstractVector{TW}, weights2::AbstractVector{TW}, weights3::AbstractVector{TW}) where {T1,T2,T3,TW}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    if typ == TW
        ᵛʷweights1 = asview(weights1)
        ᵛʷweights2 = asview(weights2)
        ᵛʷweights3 = asview(weights3)
    else
        ᵛʷweights1 = asview(map(typ, weights1))
        ᵛʷweights2 = asview(map(typ, weights2))
        ᵛʷweights3 = asview(map(typ, weights3))
    end

    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3)
end

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Int, weights1::AbstractVector{TW}, weights2::AbstractVector{TW}, weights3::AbstractVector{TW}) where {T1,T2,T3,T4,TW}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))

    if typ == TW
        ᵛʷweights1 = asview(weights1)
        ᵛʷweights2 = asview(weights2)
        ᵛʷweights3 = asview(weights3)
        ᵛʷweights4 = asview(weights4)
    else
        ᵛʷweights1 = asview(map(typ, weights1))
        ᵛʷweights2 = asview(map(typ, weights2))
        ᵛʷweights3 = asview(map(typ, weights3))
        ᵛʷweights4 = asview(map(typ, weights4))
    end

    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, ᵛʷweights4)
end

# padded running

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    window_span::Int, weights1::AbstractVector{TW}, weights2::AbstractVector{TW};
    padding::AbstractVector) where {T1,T2,TW}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))

    if typ == TW
        ᵛʷweights1 = asview(weights1)
        ᵛʷweights2 = asview(weights2)
    else
        ᵛʷweights1 = asview(map(typ, weights1))
        ᵛʷweights2 = asview(map(typ, weights2))
    end

    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights1, ᵛʷweights2; padding)
end

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Int, weights1::AbstractVector{TW}, weights2::AbstractVector{TW}, weights3::AbstractVector{TW};
    padding::AbstractVector) where {T1,T2,T3,TW}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    if typ == TW
        ᵛʷweights1 = asview(weights1)
        ᵛʷweights2 = asview(weights2)
        ᵛʷweights3 = asview(weights3)
    else
        ᵛʷweights1 = asview(map(typ, weights1))
        ᵛʷweights2 = asview(map(typ, weights2))
        ᵛʷweights3 = asview(map(typ, weights3))
    end

    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3; padding)
end

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Int, weights1::AbstractVector{TW}, weights2::AbstractVector{TW}, weights3::AbstractVector{TW}, weights4::AbstractVector{TW};
    padding::AbstractVector) where {T1,T2,T3,T4,TW}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    
    if typ == TW
        ᵛʷweights1 = asview(weights1)
        ᵛʷweights2 = asview(weights2)
        ᵛʷweights3 = asview(weights3)
        ᵛʷweights4 = asview(weights4)
    else
        ᵛʷweights1 = asview(map(typ, weights1))
        ᵛʷweights2 = asview(map(typ, weights2))
        ᵛʷweights3 = asview(map(typ, weights3))
        ᵛʷweights4 = asview(map(typ, weights4))
    end

    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, ᵛʷweights4; padding)
end
