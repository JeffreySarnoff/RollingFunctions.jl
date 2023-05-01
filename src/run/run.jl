
function running(func::F, width::Span,
                 datavec::AbstractVector{T1};
                 padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, datavec)
    elseif !padlast
        padfirst_running(func, width, datavec; padding)
    else
        padfinal_running(func, width, datavec; padding)
    end
end

function running(func::F, width::Span,
                 datavec::AbstractVector{T1},
                 weightvec::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, datavec, weightvec)
    elseif !padlast
        padfirst_running(func, width, datavec, weightvec; padding)
    else
        padfinal_running(func, width, datavec, weightvec; padding)
    end
end

function running(func::F, width::Span,
                 datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2};
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, datavec1, datavec2)
    elseif !padlast
        padfirst_running(func, width, datavec1, datavec2; padding)
    else
        padfinal_running(func, width, datavec1, datavec2; padding)
    end
end

function running(func::F, width::Span,
                 datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2},
                 weightvec::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, datavec1, datavec2, weightvec)
    elseif !padlast
        padfirst_running(func, width, datavec1, datavec2, weightvec; padding)
    else
        padfinal_running(func, width, datavec1, datavec2, weightvec; padding)
    end
end

function running(func::F, width::Span,
                 datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2},
                 weightvec1::AbstractWeights, weightvec2::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, datavec1, datavec2, weightvec1, weightvec2)
    elseif !padlast
        padfirst_running(func, width, datavec1, datavec2, weightvec1, weightvec2; padding)
    else
        padfinal_running(func, width, datavec1, datavec2, weightvec1, weightvec2; padding)
    end
end


function running(func::F, width::Span,
                 datavecs::AbstractVector{T};
                 padding=nopadding, padlast=false) where {T,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, datavecs)
    elseif !padlast
        padfirst_running(func, width, datavecs; padding)
    else
        padfinal_running(func, width, datavecs; padding)
    end
end

function running(func::F, width::Span,
                 datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2},
                 weightvec::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, datavec1, datavec2, weightvec)
    elseif !padlast
        padfirst_running(func, width, datavec1, datavec2, weightvec; padding)
    else
        padfinal_running(func, width, datavec1, datavec2, weightvec; padding)
    end
end

function running(func::F, width::Span,
                 datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2},
                 weightvec1::AbstractWeights, weightvec2::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, datavec1, datavec2, weightvec1, weightvec2)
    elseif !padlast
        padfirst_running(func, width, datavec1, datavec2, weightvec1, weightvec2; padding)
    else
        padfinal_running(func, width, datavec1, datavec2, weightvec1, weightvec2; padding)
    end
end


function running(func::F, width::Span, 
                 data::AbstractVector;
                 padding=nopadding, padlast=false,
                 weights::AkoWeight=Unweighted) where {F<:Function}
    if isunweighted(weights)
        if isnopadding(padding)
            roll_basic(func, width, data)
        elseif !padlast
            roll_padfirst(func, width, data; padding)
        else
            roll_padfirstlast(func, width, data; padding)
        end
    elseif typeof(weights) <: AbstractWeights # single weighted
        if isnopadding(padding)
            roll_basic_weights(func, width, data; weights)
        elseif !padlast
            roll_padfirst_weights(func, width, data; padding, weights)
        else
            roll_padfirstlast_weights(func, width, data; padding, weights)
        end
    else # multiple weight vectors
        if isnopadding(padding)
            roll_basic_multiweights(func, width, data; weights)
        elseif !padlast
            roll_padfirst_multiweights(func, width, data; padding, weights)
        else
            roll_padfirstlast_multiweights(func, width, data; padding, weights)
        end
    end
end

function running(func::F, width::Span,
                 data1::AbstractVector{T1}, data2::AbstractVector{T2};
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, data1, data2, width)
    elseif !padlast
        padfirst_running(func, width, data1, data2; padding)
    else
        padfinal_running(func, width, data1, data2; padding)
    end
end

function running(func::F, width::Span,
                 data1::AbstractVector{T1}, data2::AbstractVector{T2}, data...;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, data1, data2, data)
    elseif !padlast
        padfirst_running(func, width, data1, data2, data; padding)
    else
        padfinal_running(func, width, data1, data2, data; padding)
    end
end




# weighted

function running(func::F, width::Span,
                 data1::AbstractVector{T1}, 
                 weights::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_running_weighted(func, width, data1, weights)
    elseif !padlast
        padfirst_running_weighted(func, width, data1, weights; padding)
    else
        padfinal_running_weighted(func, width, data1, weights; padding)
    end
end

function running(func::F, width::Span,
                 data1::AbstractVector{T1}, 
                 weights::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, data1, weights)
    elseif !padlast
        padfirst_running(func, width, data1, weights; padding)
    else
        padfinal_running(func, width, data1, weights; padding)
    end
end

function running(func::F, width::Span,
                 data1::AbstractVector{T1}, data2::AbstractVector{T2},
                 weights::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, data1, data2, weights)
    elseif !padlast
        padfirst_running(func, width, data1, data2, weights; padding)
    else
        padfinal_running(func, width, data1, data2, weights; padding)
    end
end

function running(func::F, width::Span,
                 data::AbstractVector,
                 weights::AbstractWeights;
                 padding=nopadding, padlast=false) where {N,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, data, weights)
    elseif !padlast
        padfirst_running(func, width, data, weights; padding)
    else
        padfinal_running(func, width, data, weights; padding)
    end
end

function running(func::F, width::Span, 
                data1::AbstractMatrix{T1},
                weights::AbstractWeights;
                padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, data1, weights)
    elseif !padlast
        padfirst_running(func, width, data1, weights; padding)
    else
        padfinal_running(func, width, data1, weights; padding)
    end
end

#
# multivector multiweights
#

# weighted

function running(func::F, width::Span,
                 data1::AbstractVector{T1}, data2::AbstractVector{T2},
                 weights1::AbstractWeights, weights2::AbstractWeights;
                 padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_running(func, width, data1, data2, weights1, weights2)
    elseif !padlast
        padfirst_running(func, width, data1, data2, weights1, weights2; padding)
    else
        padfinal_running(func, width, data1, data2, weights1, weights2; padding)
    end
end

function running(func::F, width::Span,
                 data::AbstractVector,
                 weights::AkoWeight;
                 padding=nopadding, padlast=false) where {F<:Function}
    if isnopadding(padding)
        basic_running(func, width, data, weights)
    elseif !padlast
        padfirst_running(func, width, data, weights; padding)
    else
        padfinal_running(func, width, data, weights; padding)
    end
end


# intermediate functional forms

#=
   basic_running(func, data1, width) ..
   basic_running(func, data1, data2, data3, data4, width)
   padfirst_running(func, data1, width; padding, padlast) ..
   padfirst_running(func, data1, data2, data3, data4, width; padding, padlast)
   padfinal_running(func, data1, width; padding, padlast) ..
   padfinal_running(func, data1, data2, data3, data4, width; padding, padlast)
=#

function basic_running(func::Function, width::Span,
                       data1::AbstractVector{T1}, data2::AbstractVector{T2}) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))

    basic_running(func, width, ᵛʷdata1, ᵛʷdata2)
end

function basic_running(func::Function, width::Span,
                       data1::AbstractVector{T1}, data2::AbstractVector{T2}, data...) where {T1,T2}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    basic_running(func, width, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end


# padfirst running

function padfirst_running(func::Function, width::Span,
                        data1::AbstractVector{T1}, data2::AbstractVector{T2};
                        padding=nopadding) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))

    padfirst_running(func, width, ᵛʷdata1, ᵛʷdata2; padding)
end

function padfirst_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    width::Span;
    padding=nopadding) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    padfirst_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, width; padding)
end

# padfinal running

function padfinal_running(func::Function, width::Int,
                             data1::AbstractVector{T1}, data2::AbstractVector{T2},
                             padding=nopadding) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))

    padfinal_running(func, width, ᵛʷdata1, ᵛʷdata2; padding)
end

#= !!FIXME!!
function padfinal_running(func::Function, width::Span, data::DataVec;
         padding=nopadding)
    typ = promote_type(typeof.(data))
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    padfinal_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, width; padding)
end
=#

#=
   basic_running(func, data1, width, weights) ..
   basic_running(func, data1, data2, data3, data4, width, weights)
   padfirst_running(func, data1, width, weights; padding) ..
   padfirst_running(func, data1, data2, data3, data4, width, weights; padding)
   padfinal_running(func, data1, width, weights; padding) ..
   padfinal_running(func, data1, data2, data3, data4, width, weights; padding)
=#

function basic_running(func::Function, data1::AbstractVector{T1},
    width::Span, weights::AbstractWeights=Unweighted) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_running(func, ᵛʷdata1, width, ᵛʷweights)
end

function basic_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    width::Span, weights::AbstractWeights=Unweighted) where {T1,T2}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_running(func, ᵛʷdata1, ᵛʷdata2, width, ᵛʷweights)
end

function basic_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    width::Span, weights::AbstractWeights=Unweighted) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, width, ᵛʷweights)
end

function basic_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    width::Span, weights::AbstractWeights=Unweighted) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, width, ᵛʷweights)
end

function basic_running(func::Function, data1::Matrix{T1},
    width::Span, weights::AbstractWeights=Unweighted) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_running(func, ᵛʷdata1, width, ᵛʷweights)
end

# padfirst running

function padfirst_running(func::Function, data1::AbstractVector{T1},
    width::Span, weights::AbstractWeights;
    padding=nopadding) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfirst_running(func, ᵛʷdata1, width, ᵛʷweights; padding)
end

function padfirst_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    width::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfirst_running(func, ᵛʷdata1, ᵛʷdata2, width, ᵛʷweights; padding)
end

function padfirst_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    width::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfirst_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, width, ᵛʷweights; padding)
end

function padfirst_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    width::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfirst_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, width, ᵛʷweights; padding)
end

function padfirst_running(func::Function, data1::AbstractMatrix{T1},
    width::Span, weights::AbstractWeights;
    padding=nopadding) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfirst_running(func, ᵛʷdata1, width, ᵛʷweights; padding)
end

# padfinal running

function padfinal_running(func::Function, data1::AbstractVector{T1},
    width::Span, weights::AbstractWeights;
    padding=nopadding) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfinal_running(func, ᵛʷdata1, width, ᵛʷweights; padding)
end

function padfinal_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    width::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfinal_running(func, ᵛʷdata1, ᵛʷdata2, width, ᵛʷweights; padding)
end

function padfinal_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    width::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfinal_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, width, ᵛʷweights; padding)
end

function padfinal_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    width::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfinal_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, width, ᵛʷweights; padding)
end

function padfinal_running(func::Function, data1::AbstractMatrix{T1},
    width::Span, weights::AbstractWeights;
    padding=nopadding) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfinal_running(func, ᵛʷdata1, width, ᵛʷweights; padding)
end

#
# multivector multiweights
#

function basic_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    width::Span, weights1::AbstractWeights, weights2::AbstractWeights) where {T1,T2}
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

    basic_running(func, ᵛʷdata1, ᵛʷdata2, width, ᵛʷweights1, ᵛʷweights2)
end

function basic_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    width::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights) where {T1,T2,T3}
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

    basic_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, width, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3)
end

function basic_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    width::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights) where {T1,T2,T3,T4}
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

    basic_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, width, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, ᵛʷweights4)
end

# padfirst running

function padfirst_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    width::Span, weights1::AbstractWeights, weights2::AbstractWeights;
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

    padfirst_running(func, ᵛʷdata1, ᵛʷdata2, width, ᵛʷweights1, ᵛʷweights2; padding)
end

function padfirst_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    width::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights;
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

    padfirst_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, width, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3; padding)
end

function padfirst_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    width::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights, weights4::AbstractWeights;
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

    padfirst_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, width, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, ᵛʷweights4; padding)
end

# padfinal running

function padfinal_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    width::Span, weights1::AbstractWeights, weights2::AbstractWeights;
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

    padfinal_running(func, ᵛʷdata1, ᵛʷdata2, width,  ᵛʷweights1, ᵛʷweights2; padding)
end

function padfinal_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    width::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights;
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

    padfinal_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, width, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3; padding)
end

function padfinal_running(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    width::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights, weights4::AbstractWeights;
    padding=nopadding) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))

    if typ == T
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

    padfinal_running(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, width, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, ᵛʷweights4; padding)
end
