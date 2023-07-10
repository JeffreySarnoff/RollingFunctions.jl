#=
    unweighted rolling

    rolling(fn, width, data...; 
            padfirst=nopadding, atend=false)
=#

# --------------
# §1: unweighted
# --------------


function rolling(fn::F, width::Integer,
    data1::AbstractVector{T};
    padding=nopadding, atend=false) where {T,F<:Function}
    if hasnopadding(padding)
        basic_rolling(fn, width, data1)
    elseif !atend
        padfirst_rolling(fn, width, data1, padding)
    else
        padfinal_rolling(fn, width, data1, padding)
    end
end

function rolling(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2};
    padding=nopadding, atend=false) where {T1,T2,F<:Function}
    if hasnopadding(padding)
        basic_rolling(fn, width, data1, data2)
    elseif !atend
        padfirst_rolling(fn, width, data1, data2, padding)
    else
        padfinal_rolling(fn, width, data1, data2, padding)
    end
end

function rolling(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3};
    padding=nopadding, atend=false) where {T1,T2,T3,F<:Function}
    if hasnopadding(padding)
        basic_rolling(fn, width, data1, data2, data3)
    elseif !atend
        padfirst_rolling(fn, width, data1, data2, data3, padding)
    else
        padfinal_rolling(fn, width, data1, data2, data3, padding)
    end
end

function rolling(fn::F, width::Integer,
    data1::AbstractMatrix{T};
    padding=nopadding, atend=false) where {T,F<:Function}
    if hasnopadding(padding)
        basic_rolling(fn, width, data1)
    elseif !atend
        padfirst_rolling(fn, width, data1, padding)
    else
        padfinal_rolling(fn, width, data1, padding)
    end
end

# ----------------
# §2: with weights
# ----------------

function rolling(fn::F, width::Integer,
    data1::AbstractVector{T}, weight1::AbstractWeights{W};
    padding=nopadding, atend=false) where {T,W,F<:Function}
    if hasnopadding(padding)
        basic_rolling(fn, width, data1, weight1)
    elseif !atend
        padfirst_rolling(fn, width, data1, weight1, padding)
    else
        padfinal_rolling(fn, width, data1, weight1, padding)
    end
end

function rolling(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2},
    weight1::AbstractWeights{W};
    padding=nopadding, atend=false) where {T1,T2,W,F<:Function}
    if hasnopadding(padding)
        basic_rolling(fn, width, data1, data2, weight1, weight1)
    elseif !atend
        padfirst_rolling(fn, width, data1, data2, weight1, weight1, padding)
    else
        padfinal_rolling(fn, width, data1, data2, weight1, weight1, padding)
    end
end

function rolling(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2};
    padding=nopadding, atend=false) where {T1,T2,W1,W2,F<:Function}
    if hasnopadding(padding)
        basic_rolling(fn, width, data1, data2, weight1, weight2)
    elseif !atend
        padfirst_rolling(fn, width, data1, data2, weight1, weight2, padding)
    else
        padfinal_rolling(fn, width, data1, data2, weight1, weight2, padding)
    end
end

function rolling(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W};
    padding=nopadding, atend=false) where {T1,T2,T3,W,F<:Function}
    if hasnopadding(padding)
        basic_rolling(fn, width, data1, data2, data3, weight1, weight1, weight1)
    elseif !atend
        padfirst_rolling(fn, width, data1, data2, data3, weight1, weight1, weight1, padding)
    else
        padfinal_rolling(fn, width, data1, data2, data3, weight1, weight1, weight1, padding)
    end
end

function rolling(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}, weight3::AbstractWeights{W3};
    padding=nopadding, atend=false) where {T1,T2,T3,W1,W2,W3,F<:Function}
    if hasnopadding(padding)
        basic_rolling(fn, width, data1, data2, data3, weight1, weight2, weight3)
    elseif !atend
        padfirst_rolling(fn, width, data1, data2, data3, weight1, weight2, weight3, padding)
    else
        padfinal_rolling(fn, width, data1, data2, data3, weight1, weight2, weight3, padding)
    end
end

function rolling(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weight1::AbstractWeights{W};
    padding=nopadding, atend=false) where {T,W,F<:Function}
    typ = promote_type(T,W)
    #vdata = typ === T ? view(data1, :,:) : view(Matrix{typ}(data1), :, :)
    #vweights = typ === W ? view(weight1, :) : 
    weights = vmatrix(map(typ, weight1), ncols(data1))
    if typ === T
        weights = vmatrix(map(typ, weight1), ncols(data1))
    else
        weights = vmatrix(Vector(weight1), ncols(data1))
    end
    if hasnopadding(padding)
        basic_rolling(fn, width, data1, weight1)
    elseif !atend
        padfirst_rolling(fn, width, data1, weight1, padding)
    else
        padfinal_rolling(fn, width, data1, weight1, padding)
    end
end

function rolling(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::VectorOfVectors;
    padding=nopadding, atend=false) where {T,F<:Function}

    typ = promote_type(T, eltype(weights[1]))
    datavalues = vmatrix(typ, data)
    weightings = vmatrix(typ, weights)

    if hasnopadding(padding)
        basic_rolling(fn, width, datavalues, weightings)
    elseif !atend
        padfirst_rolling(fn, width, datavalues, weightings, padding)
    else
        padfinal_rolling(fn, width, datavalues, weightings, padding)
    end
end
