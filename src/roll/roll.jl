#=
    unweighted rolling

    rolling(func, span, data...; 
            padfirst=nopadding, padlast=false)
=#

"""
    rolling(function, window, data)
    rolling(function, window, data; padding)
    rolling(function, window, data; padding, padlast=true)

    rolling(      (a)->fn(a),       window, adata)
    rolling(    (a,b)->fn(a,b),     window, adata, bdata)
    rolling(  (a,b,c)->fn(a,b,c),   window, adata, bdata, cdata)
    rolling((a,b,c,d)->fn(a,b,c,d), window, (adata, bdata, cdata, ddata))
    rolling(      row->fn(row),     window, datamatrix)

the data is given as a vector
               or as 2 vectors
               or as 3 vectors 
               or as a tuple of n vectors
               or as matrix
"""
rolling

function rolling(func::F, span::Span,
    data1::AbstractVector{T};
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1; padding)
    else
        padfinal_rolling(func, span, ᵛʷdata1; padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T};
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2; padding)
    else
        padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2; padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T};
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3; padding)
    else
        padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3; padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractMatrix{T};
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1; padding)
    else
        padfinal_rolling(func, span, ᵛʷdata1; padding)
    end
end

function rolling(func::F, span::Span,
    data::Tuple{Vararg{<:AbstractArray}};
    padding=nopadding, padlast=false) where {F<:Function}
    ᵛʷdata = ntuple(i -> asview(data[i]), length(data))
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata; padding)
    else
        padfinal_rolling(func, span, ᵛʷdata; padding)
    end
end

# with mixed types of data

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2};
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview([typ(x) for x in data2])
    rolling(func, span, ᵛʷdata1, ᵛʷdata2; padding, padlast)
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3};
    padding=nopadding, padlast=false) where {T1,T2,T3,F<:Function}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview([typ(x) for x in data1])
    rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3; padding, padlast)
end




#=
    weighted rolling

    rolling(func, span, data, weights; 
            padfirst=nopadding, padlast=false)
=#



function rolling(func::F, span::Span,
    data1::AbstractVector{T}, weights1::AkoWeight;
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights1 = asview(weights1)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1, ᵛʷweights1)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1, ᵛʷweights1; padding)
    else
        padfinal_rolling(func, span, ᵛʷdata1, ᵛʷweights1; padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T},
    weights1::AkoWeight;
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights1 = asview(weights1)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights1, ᵛʷweights1)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights1, ᵛʷweights1; padding)
    else
        padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights1, ᵛʷweights1; padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T},
    weights1::AkoWeight, weights2::AkoWeight;
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights1, ᵛʷweights2)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights1, ᵛʷweights2; padding)
    else
        padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights1, ᵛʷweights2; padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights1::AkoWeight;
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights1 = asview(weights1)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights1, ᵛʷweights1, ᵛʷweights1)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights1, ᵛʷweights1, ᵛʷweights1; padding)
    else
        padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights1, ᵛʷweights1, ᵛʷweights1; padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T},
    weights1::AkoWeight, weights2::AkoWeight, weights3::AkoWeight;
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    ᵛʷweights1 = asview(weights1)
    ᵛʷweights2 = asview(weights2)
    ᵛʷweights3 = asview(weights3)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3; padding)
    else
        padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3; padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractMatrix{T}, weights1::AkoWeight;
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷweights1 = asview(weights1)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1, ᵛʷweights1)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1, ᵛʷweights1; padding)
    else
        padfinal_rolling(func, span, ᵛʷdata1, ᵛʷweights1; padding)
    end
end

function rolling(func::F, span::Span,
    data::Tuple{Vararg{<:AbstractArray}}, weights1::AkoWeight;
    padding=nopadding, padlast=false) where {F<:Function}
    ᵛʷdata = ntuple(i -> asview(data[i]), length(data))
    ᵛʷweights = asview(weights1)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata; padding)
    else
        padfinal_rolling(func, span, ᵛʷdata; padding)
    end
end

# with mixed types of data

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weights1::AkoWeight;
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷweights1 = asview(weights1)
    rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷweights1; padding, padlast)
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weights1::AkoWeight;
    padding=nopadding, padlast=false) where {T1,T2,T3,F<:Function}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview([typ(x) for x in data1])
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview([typ(x) for x in data2])
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview([typ(x) for x in data1])
    ᵛʷweights1 = asview(weights1)
    rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷweights1; padding, padlast)
end















#=





function rolling(func::F, span::Span,
    data1::AbstractVector{T},
    weights::Weighting=unweighted;
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1; padding, padlast)
    else
        padfinal_rolling(func, span, ᵛʷdata1; padding, padlast)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T},
    weights::Weighting=unweighted;
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2; padding, padlast)
    else
        padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2; padding, padlast)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2};
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    rolling(func, span, ᵛʷdata1, ᵛʷdata2; padding, padlast)
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T}, data2::AbstractVector{T}, data3::AbstractVector{T};
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    ᵛʷdata2 = asview(data2)
    ᵛʷdata3 = asview(data3)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3; padding, padlast)
    else
        padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3; padding, padlast)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3};
    padding=nopadding, padlast=false) where {T1,T2,T3,F<:Function}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3; padding, padlast)
end

function rolling(func::F, span::Span,
    data1::AbstractMatrix{T};
    padding=nopadding, padlast=false) where {T,F<:Function}
    ᵛʷdata1 = asview(data1)
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata1)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata1; padding, padlast)
    else
        padfinal_rolling(func, span, ᵛʷdata1; padding, padlast)
    end
end

function rolling(func::F, span::Span,
    data::Tuple{Vararg{<:AbstractArray}};
    padding=nopadding, padlast=false) where {F<:Function}
    ᵛʷdata = ntuple(i -> asview(data[i]), length(data))
    if isnopadding(padding)
        basic_rolling(func, span, ᵛʷdata)
    elseif !padlast
        padfirst_rolling(func, span, ᵛʷdata; padding, padlast)
    else
        padfinal_rolling(func, span, ᵛʷdata; padding, padlast)
    end
end








=#
#=
    weighted rolling

    rolling(func, span, data, weights; 
            padfirst=nopadding, padlast=false)



function rolling(func::F, span::Span,
    datavec::AbstractVector{T1},
    weightvec::AbstractWeights;
    padding=nopadding, padlast=false) where {T1,F<:Function}

    if isnopadding(padding)
        basic_rolling(func, span, datavec, weightvec)
    elseif !padlast
        padfirst_rolling(func, span, datavec, weightvec; padding)
    else
        padfinal_rolling(func, span, datavec, weightvec; padding)
    end
end

function rolling(func::F, span::Span,
    datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2};
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, datavec1, datavec2)
    elseif !padlast
        padfirst_rolling(func, span, datavec1, datavec2; padding)
    else
        padfinal_rolling(func, span, datavec1, datavec2; padding)
    end
end

function rolling(func::F, span::Span,
    datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2},
    weightvec::AbstractWeights;
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, datavec1, datavec2, weightvec)
    elseif !padlast
        padfirst_rolling(func, span, datavec1, datavec2, weightvec; padding)
    else
        padfinal_rolling(func, span, datavec1, datavec2, weightvec; padding)
    end
end

function rolling(func::F, span::Span,
    datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2},
    weightvec1::AbstractWeights, weightvec2::AbstractWeights;
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, datavec1, datavec2, weightvec1, weightvec2)
    elseif !padlast
        padfirst_rolling(func, span, datavec1, datavec2, weightvec1, weightvec2; padding)
    else
        padfinal_rolling(func, span, datavec1, datavec2, weightvec1, weightvec2; padding)
    end
end


function rolling(func::F, span::Span,
    datavecs::DataVecs;
    padding=nopadding, padlast=false) where {F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, datavecs)
    elseif !padlast
        padfirst_rolling(func, span, datavecs; padding)
    else
        padfinal_rolling(func, span, datavecs; padding)
    end
end

function rolling(func::F, span::Span,
    datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2},
    weightvec::AbstractWeights;
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, datavec1, datavec2, weightvec)
    elseif !padlast
        padfirst_rolling(func, span, datavec1, datavec2, weightvec; padding)
    else
        padfinal_rolling(func, span, datavec1, datavec2, weightvec; padding)
    end
end

function rolling(func::F, span::Span,
    datavec1::AbstractVector{T1}, datavec2::AbstractVector{T2},
    weightvec1::AbstractWeights, weightvec2::AbstractWeights;
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, datavec1, datavec2, weightvec1, weightvec2)
    elseif !padlast
        padfirst_rolling(func, span, datavec1, datavec2, weightvec1, weightvec2; padding)
    else
        padfinal_rolling(func, span, datavec1, datavec2, weightvec1, weightvec2; padding)
    end
end


function rolling(func::F, span::Span,
    data::DataVecs;
    padding=nopadding, padlast=false,
    weights::Union{WeightVecs,Unweighted}=unweighed) where {F<:Function}
    if isunweighted(weights)
        if isnopadding(padding)
            roll_basic(func, span, data)
        elseif !padlast
            roll_padfirst(func, span, data; padding)
        else
            roll_padfirstlast(func, span, data; padding)
        end
    elseif typeof(weights) <: AbstractWeights # single weighted
        if isnopadding(padding)
            roll_basic_weights(func, span, data; weights)
        elseif !padlast
            roll_padfirst_weights(func, span, data; padding, weights)
        else
            roll_padfirstlast_weights(func, span, data; padding, weights)
        end
    else # multiple weight vectors
        if isnopadding(padding)
            roll_basic_multiweights(func, span, data; weights)
        elseif !padlast
            roll_padfirst_multiweights(func, span, data; padding, weights)
        else
            roll_padfirstlast_multiweights(func, span, data; padding, weights)
        end
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2};
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, data2, span)
    elseif !padlast
        padfirst_rolling(func, span, data1, data2; padding)
    else
        padfinal_rolling(func, span, data1, data2; padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data...;
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, data2, data)
    elseif !padlast
        padfirst_rolling(func, span, data1, data2, data; padding)
    else
        padfinal_rolling(func, span, data1, data2, data; padding)
    end
end




# weighted

function rolling(func::F, span::Span,
    data1::AbstractVector{T1},
    weights::AbstractWeights;
    padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_rolling_weighted(func, span, data1, weights)
    elseif !padlast
        padfirst_rolling_weighted(func, span, data1, weights; padding)
    else
        padfinal_rolling_weighted(func, span, data1, weights; padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1},
    weights::AbstractWeights;
    padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, weights)
    elseif !padlast
        padfirst_rolling(func, span, data1, weights; padding)
    else
        padfinal_rolling(func, span, data1, weights; padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2},
    weights::AbstractWeights;
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, data2, weights)
    elseif !padlast
        padfirst_rolling(func, span, data1, data2, weights; padding)
    else
        padfinal_rolling(func, span, data1, data2, weights; padding)
    end
end

function rolling(func::F, span::Span,
    data::DataVecs,
    weights::AbstractWeights;
    padding=nopadding, padlast=false) where {F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data, weights)
    elseif !padlast
        padfirst_rolling(func, span, data, weights; padding)
    else
        padfinal_rolling(func, span, data, weights; padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractMatrix{T1},
    weights::AbstractWeights;
    padding=nopadding, padlast=false) where {T1,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, weights)
    elseif !padlast
        padfirst_rolling(func, span, data1, weights; padding)
    else
        padfinal_rolling(func, span, data1, weights; padding)
    end
end

#
# multivector multiweights
#

# weighted


function rolling(func::F, span::Span,
    data::DataVecs,
    weights::WeightVecs;
    padding=nopadding, padlast=false) where {F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data, weights)
    elseif !padlast
        padfirst_rolling(func, span, data, weights; padding)
    else
        padfinal_rolling(func, span, data, weights; padding)
    end
end


# intermediate functional forms

#=
   basic_rolling(func, data1, span) ..
   basic_rolling(func, data1, data2, data3, data4, span)
   padfirst_rolling(func, data1, span; padding, padlast) ..
   padfirst_rolling(func, data1, data2, data3, data4, span; padding, padlast)
   padfinal_rolling(func, data1, span; padding, padlast) ..
   padfinal_rolling(func, data1, data2, data3, data4, span; padding, padlast)
=#

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2)
end

function basic_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data...) where {T1,T2}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    basic_rolling(func, span, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3)
end


# padfirst rolling

function padfirst_rolling(func::Function, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2};
    padding=nopadding) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))

    padfirst_rolling(func, span, ᵛʷdata1, ᵛʷdata2; padding)
end

function padfirst_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    span::Span;
    padding=nopadding) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    padfirst_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, span; padding)
end

# padfinal rolling

function padfinal_rolling(func::Function, span::Int,
    data1::AbstractVector{T1}, data2::AbstractVector{T2},
    padding=nopadding) where {T1,T2}
    typ = promote_type(T1, T2)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))

    padfinal_rolling(func, span, ᵛʷdata1, ᵛʷdata2; padding)
end

#= !!FIXME!!
function padfinal_rolling(func::Function, span::Span, data::DataVec;
         padding=nopadding)
    typ = promote_type(typeof.(data))
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))

    padfinal_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, span; padding)
end
=#

#=
   basic_rolling(func, data1, span, weights) ..
   basic_rolling(func, data1, data2, data3, data4, span, weights)
   padfirst_rolling(func, data1, span, weights; padding) ..
   padfirst_rolling(func, data1, data2, data3, data4, span, weights; padding)
   padfinal_rolling(func, data1, span, weights; padding) ..
   padfinal_rolling(func, data1, data2, data3, data4, span, weights; padding)
=#

function basic_rolling(func::Function, data1::AbstractVector{T1},
    span::Span, weights::AbstractWeights=Unweighted) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_rolling(func, ᵛʷdata1, span, ᵛʷweights)
end

function basic_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    span::Span, weights::AbstractWeights=Unweighted) where {T1,T2}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_rolling(func, ᵛʷdata1, ᵛʷdata2, span, ᵛʷweights)
end

function basic_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    span::Span, weights::AbstractWeights=Unweighted) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, span, ᵛʷweights)
end

function basic_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    span::Span, weights::AbstractWeights=Unweighted) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, span, ᵛʷweights)
end

function basic_rolling(func::Function, data1::Matrix{T1},
    span::Span, weights::AbstractWeights=Unweighted) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    basic_rolling(func, ᵛʷdata1, span, ᵛʷweights)
end

# padfirst rolling

function padfirst_rolling(func::Function, data1::AbstractVector{T1},
    span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfirst_rolling(func, ᵛʷdata1, span, ᵛʷweights; padding)
end

function padfirst_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfirst_rolling(func, ᵛʷdata1, ᵛʷdata2, span, ᵛʷweights; padding)
end

function padfirst_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfirst_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, span, ᵛʷweights; padding)
end

function padfirst_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfirst_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, span, ᵛʷweights; padding)
end

function padfirst_rolling(func::Function, data1::AbstractMatrix{T1},
    span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfirst_rolling(func, ᵛʷdata1, span, ᵛʷweights; padding)
end

# padfinal rolling

function padfinal_rolling(func::Function, data1::AbstractVector{T1},
    span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfinal_rolling(func, ᵛʷdata1, span, ᵛʷweights; padding)
end

function padfinal_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2}
    typ = promote_type(T1, T2, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfinal_rolling(func, ᵛʷdata1, ᵛʷdata2, span, ᵛʷweights; padding)
end

function padfinal_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2,T3}
    typ = promote_type(T1, T2, T3, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfinal_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, span, ᵛʷweights; padding)
end

function padfinal_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1,T2,T3,T4}
    typ = promote_type(T1, T2, T3, T4, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷdata2 = typ == T2 ? asview(data2) : asview(map(typ, data2))
    ᵛʷdata3 = typ == T3 ? asview(data3) : asview(map(typ, data3))
    ᵛʷdata4 = typ == T3 ? asview(data4) : asview(map(typ, data4))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfinal_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, span, ᵛʷweights; padding)
end

function padfinal_rolling(func::Function, data1::AbstractMatrix{T1},
    span::Span, weights::AbstractWeights;
    padding=nopadding) where {T1}
    typ = promote_type(T1, TW)
    ᵛʷdata1 = typ == T1 ? asview(data1) : asview(map(typ, data1))
    ᵛʷweights = typ == TW ? asview(weights) : asview(map(typ, weights))

    padfinal_rolling(func, ᵛʷdata1, span, ᵛʷweights; padding)
end

#
# multivector multiweights
#

function basic_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    span::Span, weights1::AbstractWeights, weights2::AbstractWeights) where {T1,T2}
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

    basic_rolling(func, ᵛʷdata1, ᵛʷdata2, span, ᵛʷweights1, ᵛʷweights2)
end

function basic_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    span::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights) where {T1,T2,T3}
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

    basic_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3)
end

function basic_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    span::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights) where {T1,T2,T3,T4}
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

    basic_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, ᵛʷweights4)
end

# padfirst rolling

function padfirst_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    span::Span, weights1::AbstractWeights, weights2::AbstractWeights;
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

    padfirst_rolling(func, ᵛʷdata1, ᵛʷdata2, span, ᵛʷweights1, ᵛʷweights2; padding)
end

function padfirst_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    span::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights;
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

    padfirst_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3; padding)
end

function padfirst_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    span::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights, weights4::AbstractWeights;
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

    padfirst_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, ᵛʷweights4; padding)
end

# padfinal rolling

function padfinal_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2},
    span::Span, weights1::AbstractWeights, weights2::AbstractWeights;
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

    padfinal_rolling(func, ᵛʷdata1, ᵛʷdata2, span, ᵛʷweights1, ᵛʷweights2; padding)
end

function padfinal_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    span::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights;
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

    padfinal_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3; padding)
end

function padfinal_rolling(func::Function, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
    span::Span, weights1::AbstractWeights, weights2::AbstractWeights, weights3::AbstractWeights, weights4::AbstractWeights;
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

    padfinal_rolling(func, ᵛʷdata1, ᵛʷdata2, ᵛʷdata3, ᵛʷdata4, span, ᵛʷweights1, ᵛʷweights2, ᵛʷweights3, ᵛʷweights4; padding)
end
=#
