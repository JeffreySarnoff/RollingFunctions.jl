#=
    unweighted rolling

    rolling(func, span, data...; 
            padfirst=nopadding, padlast=false)
=#

"""
    rolling(function, window, data)
    rolling(function, window, data, padding)
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
    if isnopadding(padding)
        basic_rolling(func, span, data1)
    elseif !padlast
        padfirst_rolling(func, span, data1, padding)
    else
        padfinal_rolling(func, span, data1, padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2};
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, data2)
    elseif !padlast
        padfirst_rolling(func, span, data1, data2, padding)
    else
        padfinal_rolling(func, span, data1, data2, padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3};
    padding=nopadding, padlast=false) where {T1,T2,T3,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, data2, data3)
    elseif !padlast
        padfirst_rolling(func, span, data1, data2, data3, padding)
    else
        padfinal_rolling(func, span, data1, data2, data3, padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractMatrix{T};
    padding=nopadding, padlast=false) where {T,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1)
    elseif !padlast
        padfirst_rolling(func, span, data1, padding)
    else
        padfinal_rolling(func, span, data1, padding)
    end
end

function rolling(func::F, span::Span,
    data::Tuple{<:AbstractArray};
    padding=nopadding, padlast=false) where {F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data)
    elseif !padlast
        padfirst_rolling(func, span, data, padding)
    else
        padfinal_rolling(func, span, data, padding)
    end
end


function rolling(func::F, span::Span,
    data1::AbstractVector{T}, weights::AbstractWeights{W};
    padding=nopadding, padlast=false) where {T,W,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, weights)
    elseif !padlast
        padfirst_rolling(func, span, data1, weights, padding)
    else
        padfinal_rolling(func, span, data1, weights, padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weights::AbstractWeights{W}; 
    padding=nopadding, padlast=false) where {T1,T2,W,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, data2, weights)
    elseif !padlast
        padfirst_rolling(func, span, data1, data2, weights, padding)
    else
        padfinal_rolling(func, span, data1, data2, weights, padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, weights1::AbstractWeights{W1}, weights2::AbstractWeights{W2};
    padding=nopadding, padlast=false) where {T1,T2,W1,W2,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, data2, weights1, weights2)
    elseif !padlast
        padfirst_rolling(func, span, data1, data2, weights1, weights2, padding)
    else
        padfinal_rolling(func, span, data1, data2, weights1, weights2, padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, weights::AbstractWeights{W};
    padding=nopadding, padlast=false) where {T1,T2,T3,W,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, data2, data3, weights)
    elseif !padlast
        padfirst_rolling(func, span, data1, data2, data3, weights, padding)
    else
        padfinal_rolling(func, span, data1, data2, data3, weights, padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weights1::AbstractWeights{W1}, weights2::AbstractWeights{W2}, weights3::AbstractWeights{W3};
    padding=nopadding, padlast=false) where {T1,T2,T3,W1,W2,W3,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, data2, data3, weights1, weights2, weights3)
    elseif !padlast
        padfirst_rolling(func, span, data1, data2, data3, weights1, weights2, weights3, padding)
    else
        padfinal_rolling(func, span, data1, data2, data3, weights1, weights2, weights3, padding)
    end
end

function rolling(func::F, span::Span,
    data1::AbstractMatrix{T}, weights::AbstractWeights{W};
    padding=nopadding, padlast=false) where {T,W,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data1, weights)
    elseif !padlast
        padfirst_rolling(func, span, data1, weights, padding)
    else
        padfinal_rolling(func, span, data1, weights, padding)
    end
end

function rolling(func::F, span::Span,
    data::Tuple{<:AbstractArray}, weights::AbstractWeights{W};
    padding=nopadding, padlast=false) where {W,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, span, data, weights)
    elseif !padlast
        padfirst_rolling(func, span, data, weights, padding)
    else
        padfinal_rolling(func, span, data, weights, padding)
    end
end

