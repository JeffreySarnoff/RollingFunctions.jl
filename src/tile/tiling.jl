#=
    unweighted tiling

    tiling(fn, width, data...; 
            padfirst=nopadding, atend=false)
=#

function tiling(fn::F, width::Integer,
    data1::AbstractVector{T};
    padding=nopadding, atend=false) where {T,F<:Function}
    if hasnopadding(padding)
        basic_tiling(fn, width, data1)
    elseif !atend
        padfirst_tiling(fn, width, data1, padding)
    else
        padfinal_tiling(fn, width, data1, padding)
    end
end

function tiling(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2};
    padding=nopadding, atend=false) where {T1,T2,F<:Function}
    if hasnopadding(padding)
        basic_tiling(fn, width, data1, data2)
    elseif !atend
        padfirst_tiling(fn, width, data1, data2, padding)
    else
        padfinal_tiling(fn, width, data1, data2, padding)
    end
end

function tiling(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3};
    padding=nopadding, atend=false) where {T1,T2,T3,F<:Function}
    if hasnopadding(padding)
        basic_tiling(fn, width, data1, data2, data3)
    elseif !atend
        padfirst_tiling(fn, width, data1, data2, data3, padding)
    else
        padfinal_tiling(fn, width, data1, data2, data3, padding)
    end
end

function tiling(fn::F, width::Integer,
    data1::AbstractMatrix{T};
    padding=nopadding, atend=false) where {T,F<:Function}
    if hasnopadding(padding)
        basic_tiling(fn, width, data1)
    elseif !atend
        padfirst_tiling(fn, width, data1, padding)
    else
        padfinal_tiling(fn, width, data1, padding)
    end
end

# with weights

function tiling(fn::F, width::Integer,
    data1::AbstractVector{T}, weight1::AbstractWeights{W};
    padding=nopadding, atend=false) where {T,W,F<:Function}
    if hasnopadding(padding)
        basic_tiling(fn, width, data1, weight1)
    elseif !atend
        padfirst_tiling(fn, width, data1, weight1, padding)
    else
        padfinal_tiling(fn, width, data1, weight1, padding)
    end
end

function tiling(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, 
    weight1::AbstractWeights{W}; 
    padding=nopadding, atend=false) where {T1,T2,W,F<:Function}
    if hasnopadding(padding)
        basic_tiling(fn, width, data1, data2, weight1, weight1)
    elseif !atend
        padfirst_tiling(fn, width, data1, data2, weight1, weight1, padding)
    else
        padfinal_tiling(fn, width, data1, data2, weight1, weight1, padding)
    end
end

function tiling(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2};
    padding=nopadding, atend=false) where {T1,T2,W1,W2,F<:Function}
    if hasnopadding(padding)
        basic_tiling(fn, width, data1, data2, weight1, weight2)
    elseif !atend
        padfirst_tiling(fn, width, data1, data2, weight1, weight2, padding)
    else
        padfinal_tiling(fn, width, data1, data2, weight1, weight2, padding)
    end
end

function tiling(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W};
    padding=nopadding, atend=false) where {T1,T2,T3,W,F<:Function}
    if hasnopadding(padding)
        basic_tiling(fn, width, data1, data2, data3, weight1, weight1, weight1)
    elseif !atend
        padfirst_tiling(fn, width, data1, data2, data3, weight1, weight1, weight1, padding)
    else
        padfinal_tiling(fn, width, data1, data2, data3, weight1, weight1, weight1, padding)
    end
end

function tiling(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}, weight3::AbstractWeights{W3};
    padding=nopadding, atend=false) where {T1,T2,T3,W1,W2,W3,F<:Function}
    if hasnopadding(padding)
        basic_tiling(fn, width, data1, data2, data3, weight1, weight2, weight3)
    elseif !atend
        padfirst_tiling(fn, width, data1, data2, data3, weight1, weight2, weight3, padding)
    else
        padfinal_tiling(fn, width, data1, data2, data3, weight1, weight2, weight3, padding)
    end
end

function tiling(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weight1::AbstractWeights{W};
    padding=nopadding, atend=false) where {T,W,F<:Function}
    if hasnopadding(padding)
        basic_tiling(fn, width, data1, weight1)
    elseif !atend
        padfirst_tiling(fn, width, data1, weight1, padding)
    else
        padfinal_tiling(fn, width, data1, weight1, padding)
    end
end

function tiling(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weights::AbstractVector{<:AbstractWeights};
    padding=nopadding, atend=false) where {T,F<:Function}
    tiling(fn, width, data1, vmatrix(weights); padding, atend)
end

function tiling(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weights::AbstractVector{<:AbstractVector};
    padding=nopadding, atend=false) where {T,F<:Function}
    tiling(fn, width, data1, vmatrix(weights); padding, atend)
end

function tiling(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weight1::AbstractMatrix{T};
    padding=nopadding, atend=false) where {T,F<:Function}
    if hasnopadding(padding)
        basic_tiling(fn, width, data1, weight1)
    elseif !atend
        padfirst_tiling(fn, width, data1, weight1, padding)
    else
        padfinal_tiling(fn, width, data1, weight1, padding)
    end
end

function tiling(fn::F, width::Integer,
    data1::AbstractMatrix{T}, weight1::AbstractMatrix{W};
    padding=nopadding, atend=false) where {T,W,F<:Function}
    if T<:Integer
        return tiling(fn, width, Matrix{W}(data1), weight1; padding, atend)
    end
    if hasnopadding(padding)
        basic_tiling(fn, width, data1, weight1)
    elseif !atend
        padfirst_tiling(fn, width, data1, weight1, padding)
    else
        padfinal_tiling(fn, width, data1, weight1, padding)
    end
end
