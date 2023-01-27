function rolling(window_fn::F, data1::AbstractVector{T1}, window_span::Int;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, window_span)
    elseif !padlast
        padded_rolling(window_fn, data1, window_span; padding)
    else
        last_padded_rolling(window_fn, data1, window_span; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, data2, window_span)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, window_span; padding)
    else
        last_padded_rolling(window_fn, data1, data2, window_span; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, window_span::Int;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, T3, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, data2, data3, window_span)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, data3, window_span; padding)
    else
        last_padded_rolling(window_fn, data1, data2, data3, window_span; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                 window_span::Int;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, T3, T4, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, data2, data3, data4, window_span)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, data3, data4, window_span; padding)
    else
        last_padded_rolling(window_fn, data1, data2, data3, data4, window_span; padding)
    end
end

function rolling(window_fn::F, data1::AbstractMatrix{T1}, window_span::Int;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, window_span)
    elseif !padlast
        padded_rolling(window_fn, data1, window_span; padding)
    else
        last_padded_rolling(window_fn, data1, window_span; padding)
    end
end

# weighted

function rolling(window_fn::F, data1::AbstractVector{T1}, window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padfirst=true, padlast=false) where {T1, TW, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, window_span, weights)
    elseif !padlast
        padded_rolling(window_fn, data1, window_span, weights; padding)
    else
        last_padded_rolling(window_fn, data1, window_span, weights; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, TW, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, data2, window_span, weights)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, window_span, weights; padding)
    else
        last_padded_rolling(window_fn, data1, data2, window_span, weights; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, T3, TW, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, data2, data3, window_span, weights)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, data3, window_span, weights; padding)
    else
        last_padded_rolling(window_fn, data1, data2, data3, window_span, weights; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                 window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, T3, T4, TW, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, data2, data3, data4, window_span, weights)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, data3, data4, window_span, weights; padding)
    else
        last_padded_rolling(window_fn, data1, data2, data3, data4, window_span, weights; padding)
    end
end

function rolling(window_fn::F, data1::AbstractMatrix{T1}, window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padfirst=true, padlast=false) where {T1, TW, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, window_span, weights)
    elseif !padlast
        padded_rolling(window_fn, data1, window_span, weights; padding)
    else
        last_padded_rolling(window_fn, data1, window_span, weights; padding)
    end
end

function rolling(window_fn::F, data1::AbstractMatrix{T1}, window_span::Int, weights::AbstractMatrix{TW};
                 padding=Nothing, padfirst=true, padlast=false) where {T1, TW, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, window_span, weights)
    elseif !padlast
        padded_rolling(window_fn, data1, window_span, weights; padding)
    else
        last_padded_rolling(window_fn, data1, window_span, weights; padding)
    end
end

# intermediate functional forms


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

