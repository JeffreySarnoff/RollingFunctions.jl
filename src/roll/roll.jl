
function rolling(window_fn::F, window_span::Span,
                 datavec::AbstractVector{T1};
                 padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, datavec)
    elseif !padlast
        padded_rolling(window_fn, window_span, datavec; padding)
    else
        last_padded_rolling(window_fn, window_span, datavec; padding)
    end
end

function rolling(window_fn::F, window_span::Span,
                 datavec::AbstractVector{T1},
                 weightvec::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, datavec, weightvec)
    elseif !padlast
        padded_rolling(window_fn, window_span, datavec, weightvec; padding)
    else
        last_padded_rolling(window_fn, window_span, datavec, weightvec; padding)
    end
end

function rolling(window_fn::F, window_span::Span,
                 datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2};
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, datavec1, datavec2)
    elseif !padlast
        padded_rolling(window_fn, window_span, datavec1, datavec2; padding)
    else
        last_padded_rolling(window_fn, window_span, datavec1, datavec2; padding)
    end
end

function rolling(window_fn::F, window_span::Span,
                 datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2},
                 weightvec::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, datavec1, datavec2, weightvec)
    elseif !padlast
        padded_rolling(window_fn, window_span, datavec1, datavec2, weightvec; padding)
    else
        last_padded_rolling(window_fn, window_span, datavec1, datavec2, weightvec; padding)
    end
end

function rolling(window_fn::F, window_span::Span,
                 datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2},
                 weightvec1::AbstractWeights, weightvec2::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, datavec1, datavec2, weightvec1, weightvec2)
    elseif !padlast
        padded_rolling(window_fn, window_span, datavec1, datavec2, weightvec1, weightvec2; padding)
    else
        last_padded_rolling(window_fn, window_span, datavec1, datavec2, weightvec1, weightvec2; padding)
    end
end


function rolling(window_fn::F, window_span::Span,
                 datavecs::DataVecs;
                 padding=nopadding, padlast=false) where {F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, datavecs)
    elseif !padlast
        padded_rolling(window_fn, window_span, datavecs; padding)
    else
        last_padded_rolling(window_fn, window_span, datavecs; padding)
    end
end

function rolling(window_fn::F, window_span::Span,
                 datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2},
                 weightvec::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, datavec1, datavec2, weightvec)
    elseif !padlast
        padded_rolling(window_fn, window_span, datavec1, datavec2, weightvec; padding)
    else
        last_padded_rolling(window_fn, window_span, datavec1, datavec2, weightvec; padding)
    end
end

function rolling(window_fn::F, window_span::Span,
                 datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2},
                 weightvec1::AbstractWeights, weightvec2::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, datavec1, datavec2, weightvec1, weightvec2)
    elseif !padlast
        padded_rolling(window_fn, window_span, datavec1, datavec2, weightvec1, weightvec2; padding)
    else
        last_padded_rolling(window_fn, window_span, datavec1, datavec2, weightvec1, weightvec2; padding)
    end
end


function rolling(window_fn::F, window_span::Span, 
                 data::DataVecs;
                 padding=nopadding, padlast=false,
                 weights::Union{WeightVecs, Unweighted}=unweighed) where {F<:Function}
    if isunweighted(weights)
        if isnopadding(padding)
            roll_basic(window_fn, window_span, data)
        elseif !padlast
            roll_padded(window_fn, window_span, data; padding)
        else
            roll_paddedlast(window_fn, window_span, data; padding)
        end
    elseif typeof(weights) <: AbstractWeights # single weighted
        if isnopadding(padding)
            roll_basic_weights(window_fn, window_span, data; weights)
        elseif !padlast
            roll_padded_weights(window_fn, window_span, data; padding, weights)
        else
            roll_paddedlast_weights(window_fn, window_span, data; padding, weights)
        end
    else # multiple weight vectors
        if isnopadding(padding)
            roll_basic_multiweights(window_fn, window_span, data; weights)
        elseif !padlast
            roll_padded_multiweights(window_fn, window_span, data; padding, weights)
        else
            roll_paddedlast_multiweights(window_fn, window_span, data; padding, weights)
        end
    end
end

function rolling(window_fn::F, window_span::Span,
                 data1::AbstractVector{T1}, data2::AbstractVector{T2};
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, data1, data2, window_span)
    elseif !padlast
        padded_rolling(window_fn, window_span, data1, data2; padding)
    else
        last_padded_rolling(window_fn, window_span, data1, data2; padding)
    end
end

function rolling(window_fn::F, window_span::Span,
                 data1::AbstractVector{T1}, data2::AbstractVector{T2}, data...;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, data1, data2, data)
    elseif !padlast
        padded_rolling(window_fn, window_span, data1, data2, data; padding)
    else
        last_padded_rolling(window_fn, window_span, data1, data2, data; padding)
    end
end




# weighted

function rolling(window_fn::F, window_span::Span,
                 data1::AbstractVector{T1}, 
                 weights::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_rolling_weighted(window_fn, window_span, data1, weights)
    elseif !padlast
        padded_rolling_weighted(window_fn, window_span, data1, weights; padding)
    else
        last_padded_rolling_weighted(window_fn, window_span, data1, weights; padding)
    end
end

function rolling(window_fn::F, window_span::Span,
                 data1::AbstractVector{T1}, 
                 weights::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, data1, weights)
    elseif !padlast
        padded_rolling(window_fn, window_span, data1, weights; padding)
    else
        last_padded_rolling(window_fn, window_span, data1, weights; padding)
    end
end

function rolling(window_fn::F, window_span::Span,
                 data1::AbstractVector{T1}, data2::AbstractVector{T2},
                 weights::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, data1, data2, weights)
    elseif !padlast
        padded_rolling(window_fn, window_span, data1, data2, weights; padding)
    else
        last_padded_rolling(window_fn, window_span, data1, data2, weights; padding)
    end
end

function rolling(window_fn::F, window_span::Span,
                 data::DataVecs,
                 weights::AbstractWeights;
                 padding=nopadding, padlast=false) where {F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, data, weights)
    elseif !padlast
        padded_rolling(window_fn, window_span, data, weights; padding)
    else
        last_padded_rolling(window_fn, window_span, data, weights; padding)
    end
end

function rolling(window_fn::F, window_span::Span, 
                data1::AbstractMatrix{T1},
                weights::AbstractWeights;
                padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, data1, weights)
    elseif !padlast
        padded_rolling(window_fn, window_span, data1, weights; padding)
    else
        last_padded_rolling(window_fn, window_span, data1, weights; padding)
    end
end

#
# multivector multiweights
#

# weighted

function rolling(window_fn::F, window_span::Span,
                 data1::AbstractVector{T1}, data2::AbstractVector{T2},
                 weights1::AbstractWeights, weights2::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, data1, data2, weights1, weights2)
    elseif !padlast
        padded_rolling(window_fn, window_span, data1, data2, weights1, weights2; padding)
    else
        last_padded_rolling(window_fn, window_span, data1, data2, weights1, weights2; padding)
    end
end

function rolling(window_fn::F, window_span::Span,
                 data::DataVecs,
                 weights::WeightVecs;
                 padding=nopadding, padlast=false) where {F<:Function}
    if isnopadding(padding)
        basic_rolling(window_fn, window_span, data, weights)
    elseif !padlast
        padded_rolling(window_fn, window_span, data, weights; padding)
    else
        last_padded_rolling(window_fn, window_span, data, weights; padding)
    end
end


# intermediate functional forms

#=
   basic_rolling(window_fn, data1, window_span) ..
   basic_rolling(window_fn, data1, data2, data3, data4, window_span)
   padded_rolling(window_fn, data1, window_span; padding, padlast) ..
   padded_rolling(window_fn, data1, data2, data3, data4, window_span; padding, padlast)
   last_padded_rolling(window_fn, data1, window_span; padding, padlast) ..
   last_padded_rolling(window_fn, data1, data2, data3, data4, window_span; padding, padlast)
=#

function basic_rolling(window_fn::Function, window_span::Span,
                       data1::AbstractVector{T1}, data2::AbstractVector{T2}) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))

    basic_rolling(window_fn, window_span, ᵛʷdata1, ᵛʷdata2)
end

function basic_rolling(window_fn::Function, window_span::Span,
                       data1::AbstractVector{T1}, data2::AbstractVector{T2}, data...) where {T1,T2}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    basic_rolling(window_fn, window_span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end


# padded rolling

function padded_rolling(window_fn::Function, window_span::Span,
                        data1::AbstractVector{T1}, data2::AbstractVector{T2};
                        padding=nopadding) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))

    padded_rolling(window_fn, window_span, ᵛʷdata1, ᵛʷdata2; padding)
end

function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Span;
    padding=nopadding) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span; padding)
end

# last_padded rolling

function last_padded_rolling(window_fn::Function, window_span::Int,
                             data1::AbstractVector{T1}, data2::AbstractVector{T2},
                             padding=nopadding) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))

    last_padded_rolling(window_fn, window_span, ᵛʷdata1, ᵛʷdata2; padding)
end

#= !!FIXME!!
function last_padded_rolling(window_fn::Function, window_span::Span, data::DataVec;
         padding=nopadding)
    typ = promote_type(typeof.(data))
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    last_padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span; padding)
end
=#

#=
   basic_rolling(window_fn, data1, window_span, weights) ..
   basic_rolling(window_fn, data1, data2, data3, data4, window_span, weights)
   padded_rolling(window_fn, data1, window_span, weights; padding) ..
   padded_rolling(window_fn, data1, data2, data3, data4, window_span, weights; padding)
   last_padded_rolling(window_fn, data1, window_span, weights; padding) ..
   last_padded_rolling(window_fn, data1, data2, data3, data4, window_span, weights; padding)
=#

function basic_rolling(window_fn::Function, data1::AbstractVector{T1},
    window_span::Span, weights::AbstractWeights=Unweighted) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_rolling(window_fn, ᵛʷdata1, window_span, ᵛʷweights)
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    window_span::Span, weights::AbstractWeights=Unweighted) where {T1,T2}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights)
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Span, weights::AbstractWeights=Unweighted) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights)
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Span, weights::AbstractWeights=Unweighted) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights)
end

function basic_rolling(window_fn::Function, data1::Matrix{T1},
    window_span::Span, weights::AbstractWeights=Unweighted) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_rolling(window_fn, ᵛʷdata1, window_span, ᵛʷweights)
end

# padded rolling

function padded_rolling(window_fn::Function, data1::AbstractVector{T1},
    window_span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padded_rolling(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding)
end

function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    window_span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights; padding)
end

function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights; padding)
end

function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights; padding)
end

function padded_rolling(window_fn::Function, data1::AbstractMatrix{T1},
    window_span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padded_rolling(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding)
end

# last_padded rolling

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1},
    window_span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    last_padded_rolling(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding)
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    window_span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    last_padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights; padding)
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    last_padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights; padding)
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    last_padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights; padding)
end

function last_padded_rolling(window_fn::Function, data1::AbstractMatrix{T1},
    window_span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    last_padded_rolling(window_fn, ᵛʷdata1, window_span, ᵛʷweights; padding)
end

#
# multivector multiweights
#

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    window_span::Span, weights1::AbstractWeights, weights2::AbstractWeights) where {T1,T2}
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

    basic_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights1, ᵛʷweights2)
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights) where {T1,T2,T3}
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

    basic_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3)
end

function basic_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights) where {T1,T2,T3,T4}
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

    basic_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, ᵛʷweights4)
end

# padded rolling

function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    window_span::Span, weights1::AbstractWeights, weights2::AbstractWeights;
    padding=nopadding) where {T1,T2}
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

    padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, window_span, ᵛʷweights1, ᵛʷweights2; padding)
end

function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights;
    padding=nopadding) where {T1,T2,T3}
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

    padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3; padding)
end

function padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights, weights4::AbstractWeights;
    padding=nopadding) where {T1,T2,T3,T4}
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

    padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, ᵛʷweights4; padding)
end

# last_padded rolling

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    window_span::Span, weights1::AbstractWeights, weights2::AbstractWeights;
    padding=nopadding) where {T1,T2}
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

    last_padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, window_span,  ᵛʷweights1, ᵛʷweights2; padding)
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    window_span::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights;
    padding=nopadding) where {T1,T2,T3}
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

    last_padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, window_span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3; padding)
end

function last_padded_rolling(window_fn::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    window_span::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights, weights4::AbstractWeights;
    padding=nopadding) where {T1,T2,T3,T4}
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

    last_padded_rolling(window_fn, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, window_span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, ᵛʷweights4; padding)
end
