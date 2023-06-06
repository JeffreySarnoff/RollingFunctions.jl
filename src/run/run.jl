#=
    unweighted running

    running(func, width, data...; 
            taperfirst=nopadding, atend=false)
=#

function running(func::F, width::Integer,
    data1::AbstractVector{T}; atend=false) where {T,F<:Function}
    if !atend
        taperfirst(func, width, data1)
    else
        taperfinal(func, width, data1)
    end
end

function running(func::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2};
    atend=false) where {T1,T2,F<:Function}
    if !atend
        taperfirst(func, width, data1, data2)
    else
        taperfinal(func, width, data1, data2)
    end
end

function running(func::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3};
    atend=false) where {T1,T2,T3,F<:Function}
    if !atend
        taperfirst(func, width, data1, data2, data3)
    else
        taperfinal(func, width, data1, data2, data3)
    end
end

function running(func::F, width::Integer,
    data1::AbstractMatrix{T};
    atend=false) where {T,F<:Function}
    if !atend
        taperfirst(func, width, data1)
    else
        taperfinal(func, width, data1)
    end
end

# with weights

function running(func::F, width::Integer,
    data1::AbstractVector{T}, weight1::AbstractWeights{W};
    atend=false) where {T,W,F<:Function}
    if !atend
        taperfirst(func, width, data1, weight1)
    else
        taperfinal(func, width, data1, weight1)
    end
end

function running(func::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, 
    weight1::AbstractWeights{W}; 
    atend=false) where {T1,T2,W,F<:Function}
    if !atend
        taperfirst(func, width, data1, data2, weight1, weight1)
    else
        taperfinal(func, width, data1, data2, weight1, weight1)
    end
end

function running(func::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2};
    atend=false) where {T1,T2,W1,W2,F<:Function}
    if !atend
        taperfirst(func, width, data1, data2, weight1, weight2)
    else
        taperfinal(func, width, data1, data2, weight1, weight2)
    end
end

function running(func::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W};
    atend=false) where {T1,T2,T3,W,F<:Function}
    if !atend
        taperfirst(func, width, data1, data2, data3, weight1, weight1, weight1)
    else
        taperfinal(func, width, data1, data2, data3, weight1, weight1, weight1)
    end
end

function running(func::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}, weight3::AbstractWeights{W3};
    atend=false) where {T1,T2,T3,W1,W2,W3,F<:Function}
    if !atend
        taperfirst(func, width, data1, data2, data3, weight1, weight2, weight3)
    else
        taperfinal(func, width, data1, data2, data3, weight1, weight2, weight3)
    end
end

function running(func::F, width::Integer,
    data::AbstractMatrix{T}, weight::W;
    atend=false) where {T,W<:AbstractWeights,F<:Function}
    check_weights(length(weight), width)
    if !atend
        taperfirst(func, width, data, weight)
    else
        taperfinal(func, width, data, weight)
    end
end

function running(func::F, width::Integer,
    data::AbstractMatrix{T}, weights::W;
    atend=false) where {T,W<:AbstractVector{<:AbstractWeights},F<:Function}
    check_weights(length(weights[1]), width)
    if !atend
        taperfirst(func, width, data, weights)
    else
        taperfinal(func, width, data, weights)
    end
end

function running(func::F, width::Integer,
    data::Tuple{<:AbstractArray}, weight1::AbstractWeights{W};
    atend=false) where {W,F<:Function}
    if !atend
        taperfirst(func, width, data, weight1)
    else
        taperfinal(func, width, data, weight1)
    end
end

