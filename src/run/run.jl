function running(window_fn::F, data1::AbstractVector{T1}, window_span::Int;
                 padding=Nothing, padlast=false) where {T1, F<:Function}
    if  isNothing(padding)
        basic_running(window_fn, data1, window_span)
    elseif !padlast
        padded_running(window_fn, data1, window_span; padding)
    else
        last_padded_running(window_fn, data1, window_span; padding)
    end
end

function running(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int;
                 padding=Nothing, padlast=false) where {T1, T2, F<:Function}
    if  isNothing(padding)
        basic_running(window_fn, data1, data2, window_span)
    elseif !padlast
        padded_running(window_fn, data1, data2, window_span; padding)
    else
        last_padded_running(window_fn, data1, data2, window_span; padding)
    end
end

function running(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, window_span::Int;
                 padding=Nothing, padlast=false) where {T1, T2, T3, F<:Function}
    if  isNothing(padding)
        basic_running(window_fn, data1, data2, data3, window_span)
    elseif !padlast
        padded_running(window_fn, data1, data2, data3, window_span; padding)
    else
        last_padded_running(window_fn, data1, data2, data3, window_span; padding)
    end
end

function running(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                 window_span::Int;
                 padding=Nothing, padlast=false) where {T1, T2, T3, T4, F<:Function}
    if  isNothing(padding)
        basic_running(window_fn, data1, data2, data3, data4, window_span)
    elseif !padlast
        padded_running(window_fn, data1, data2, data3, data4, window_span; padding)
    else
        last_padded_running(window_fn, data1, data2, data3, data4, window_span; padding)
    end
end

function running(window_fn::F, data1::AbstractMatrix{T1}, window_span::Int;
                 padding=Nothing, padlast=false) where {T1, F<:Function}
    if  isNothing(padding)
        basic_running(window_fn, data1, window_span)
    elseif !padlast
        padded_running(window_fn, data1, window_span; padding)
    else
        last_padded_running(window_fn, data1, window_span; padding)
    end
end

# weighted

function running(window_fn::F, data1::AbstractVector{T1}, window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padlast=false) where {T1, TW, F<:Function}
    if  isNothing(padding)
        basic_running(window_fn, data1, window_span, weights)
    elseif !padlast
        padded_running(window_fn, data1, window_span, weights; padding)
    else
        last_padded_running(window_fn, data1, window_span, weights; padding)
    end
end

function running(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padlast=false) where {T1, T2, TW, F<:Function}
    if  isNothing(padding)
        basic_running(window_fn, data1, data2, window_span, weights)
    elseif !padlast
        padded_running(window_fn, data1, data2, window_span, weights; padding)
    else
        last_padded_running(window_fn, data1, data2, window_span, weights; padding)
    end
end

function running(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padlast=false) where {T1, T2, T3, TW, F<:Function}
    if  isNothing(padding)
        basic_running(window_fn, data1, data2, data3, window_span, weights)
    elseif !padlast
        padded_running(window_fn, data1, data2, data3, window_span, weights; padding)
    else
        last_padded_running(window_fn, data1, data2, data3, window_span, weights; padding)
    end
end

function running(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                 window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padlast=false) where {T1, T2, T3, T4, TW, F<:Function}
    if  isNothing(padding)
        basic_running(window_fn, data1, data2, data3, data4, window_span, weights)
    elseif !padlast
        padded_running(window_fn, data1, data2, data3, data4, window_span, weights; padding)
    else
        last_padded_running(window_fn, data1, data2, data3, data4, window_span, weights; padding)
    end
end

function running(window_fn::F, data1::AbstractMatrix{T1}, window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padlast=false) where {T1, TW, F<:Function}
    if  isNothing(padding)
        basic_running(window_fn, data1, window_span, weights)
    elseif !padlast
        padded_running(window_fn, data1, window_span, weights; padding)
    else
        last_padded_running(window_fn, data1, window_span, weights; padding)
    end
end

function running(window_fn::F, data1::AbstractMatrix{T1}, window_span::Int, weights::AbstractMatrix{TW};
                 padding=Nothing, padlast=false) where {T1, TW, F<:Function}
    if  isNothing(padding)
        basic_running(window_fn, data1, window_span, weights)
    elseif !padlast
        padded_running(window_fn, data1, window_span, weights; padding)
    else
        last_padded_running(window_fn, data1, window_span, weights; padding)
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
    typ = promote_type(T1,T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
       
    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, window_span)
end

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
                       window_span::Int) where {T1,T2,T3}
    typ = promote_type(T1,T2,T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
       
    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span)
end

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                       window_span::Int) where {T1,T2,T3,T4}
    typ = promote_type(T1,T2,T3,T4)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
       
    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span)
end

# padded running

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
                        window_span::Int;
                        padding=Nothing) where {T1,T2}
    typ = promote_type(T1,T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
       
    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, window_span; padding)
end

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
                        window_span::Int;
                        padding=Nothing) where {T1,T2,T3}
    typ = promote_type(T1,T2,T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
       
    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span; padding)
end

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                        window_span::Int;
                        padding=Nothing) where {T1,T2,T3,T4}
    typ = promote_type(T1,T2,T3,T4)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
       
    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span; padding)
end

# last_padded running
    
function last_padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, 
                             window_span::Int;
                             padding=Nothing) where {T1,T2}
    typ = promote_type(T1,T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
       
    last_padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, window_span; padding)
end

function last_padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, 
                             window_span::Int;
                             padding=Nothing) where {T1,T2,T3}
    typ = promote_type(T1,T2,T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
       
    last_padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span; padding)
end

function last_padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                             window_span::Int;
                             padding=Nothing) where {T1,T2,T3,T4}
    typ = promote_type(T1,T2,T3,T4)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
       
    last_padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span; padding, padlast)
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
                       window_span::Int, weights::AbstractVector{TW}) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_running(window_fn, ᵛʷdata1, window_span, ᵛʷweights)
end

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
                       window_span::Int, weights::AbstractVector{TW}) where {T1,T2, TW}
    typ = promote_type(T1,T2,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights)
end

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
                       window_span::Int, weights::AbstractVector{TW}) where {T1,T2,T3, TW}
    typ = promote_type(T1,T2,T3,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights)
end

function basic_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                       window_span::Int, weights::AbstractVector{TW}) where {T1,T2,T3,T4, TW}
    typ = promote_type(T1,T2,T3,T4,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights)
end

function basic_running(window_fn::Function, data1::Matrix{T1},
                       window_span::Int, weights::AbstractVector{TW}) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    basic_running(window_fn, ᵛʷdata1, window_span, ᵛʷweights)
end

# padded running

function padded_running(window_fn::Function, data1::AbstractVector{T1},
                        window_span::Int, weights::AbstractVector{TW};
                        padding=Nothing) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_running(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding)
end
    
function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
                        window_span::Int, weights::AbstractVector{TW};
                        padding=Nothing) where {T1,T2, TW}
    typ = promote_type(T1,T2,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights; padding)
end

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
                        window_span::Int, weights::AbstractVector{TW};
                        padding=Nothing) where {T1,T2,T3, TW}
    typ = promote_type(T1,T2,T3,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights; padding)
end

function padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                        window_span::Int, weights::AbstractVector{TW};
                        padding=Nothing) where {T1,T2,T3,T4, TW}
    typ = promote_type(T1,T2,T3,T4,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights; padding)
end

function padded_running(window_fn::Function, data1::AbstractMatrix{T1},
                        window_span::Int, weights::AbstractVector{TW};
                        padding=Nothing) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    padded_running(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding)
end

# last_padded running

function last_padded_running(window_fn::Function, data1::AbstractVector{T1}, 
                             window_span::Int, weights::AbstractVector{TW};
                             padding=Nothing) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_running(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding)
end
    
function last_padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, 
                             window_span::Int, weights::AbstractVector{TW};
                             padding=Nothing) where {T1,T2, TW}
    typ = promote_type(T1,T2,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights; padding)
end

function last_padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, 
                             window_span::Int, weights::AbstractVector{TW};
                             padding=Nothing) where {T1,T2,T3, TW}
    typ = promote_type(T1,T2,T3,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights; padding)
end

function last_padded_running(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                             window_span::Int, weights::AbstractVector{TW};
                             padding=Nothing) where {T1,T2,T3,T4, TW}
    typ = promote_type(T1,T2,T3,T4,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_running(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights; padding)
end

function last_padded_running(window_fn::Function, data1::AbstractMatrix{T1}, 
                             window_span::Int, weights::AbstractVector{TW};
                             padding=Nothing) where {T1, TW}
    typ = promote_type(T1,TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))
       
    last_padded_running(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding)
end

