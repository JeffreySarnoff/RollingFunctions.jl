#=
    unweighted running

    running(fn, width, data...; 
            padding=nopadding, atend=false)
=#

function running(fn::F, width::Integer,
    data1::AbstractVector{T}; 
    padding=nopadding, atend=false) where {T,F<:Function}
    if !atend
        taperfirst(fn, width, data1; padding)
    else
        taperfinal(fn, width, data1; padding)
    end
end

function running(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2};
    padding=nopadding, atend = false) where {T1,T2,F<:Function}
    if !atend
        taperfirst(fn, width, data1, data2; padding)
    else
        taperfinal(fn, width, data1, data2; padding)
    end
end

function running(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3};
    padding=nopadding, atend=false) where {T1,T2,T3,F<:Function}
    if !atend
        taperfirst(fn, width, data1, data2, data3; padding)
    else
        taperfinal(fn, width, data1, data2, data3; padding)
    end
end

function running(fn::F, width::Integer,
    data1::AbstractMatrix{T};
    padding=nopadding, atend = false) where {T,F<:Function}
    if !atend
        taperfirst(fn, width, data1; padding)
    else
        taperfinal(fn, width, data1; padding)
    end
end

# with weights

function running(fn::F, width::Integer,
    data1::AbstractVector{T}, weight1::AbstractWeights{W};
    padding=nopadding, atend = false) where {T,W,F<:Function}
    if !atend
        taperfirst(fn, width, data1, weight1; padding)
    else
        taperfinal(fn, width, data1, weight1; padding)
    end
end

function running(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, 
    weight1::AbstractWeights{W}; 
    padding=nopadding, atend = false) where {T1,T2,W,F<:Function}
    if !atend
        taperfirst(fn, width, data1, data2, weight1, weight1; padding)
    else
        taperfinal(fn, width, data1, data2, weight1, weight1; padding)
    end
end

function running(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2};
    padding=nopadding, atend = false) where {T1,T2,W1,W2,F<:Function}
    if !atend
        taperfirst(fn, width, data1, data2, weight1, weight2; padding)
    else
        taperfinal(fn, width, data1, data2, weight1, weight2; padding)
    end
end

function running(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W};
    padding=nopadding, atend=false) where {T1,T2,T3,W,F<:Function}
    if !atend
        taperfirst(fn, width, data1, data2, data3, weight1, weight1, weight1; padding)
    else
        taperfinal(fn, width, data1, data2, data3, weight1, weight1, weight1; padding)
    end
end

function running(fn::F, width::Integer,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::AbstractWeights{W1}, weight2::AbstractWeights{W2}, weight3::AbstractWeights{W3};
    padding=nopadding, atend=false) where {T1,T2,T3,W1,W2,W3,F<:Function}
    if !atend
        taperfirst(fn, width, data1, data2, data3, weight1, weight2, weight3; padding)
    else
        taperfinal(fn, width, data1, data2, data3, weight1, weight2, weight3; padding)
    end
end

function running(fn::F, width::Integer,
    data::AbstractMatrix{T}, weight::W;
    padding=nopadding, atend = false) where {T,W<:AbstractWeights,F<:Function}
    check_weights(length(weight), width)
    if !atend
        taperfirst(fn, width, data, weight; padding)
    else
        taperfinal(fn, width, data, weight; padding)
    end
end

function running(fn::F, width::Integer,
    data::AbstractMatrix{T}, weights::W;
    padding=nopadding, atend = false) where {T,W<:AbstractVector{<:AbstractWeights},F<:Function}
    check_weights(length(weights[1]), width)
    if !atend
        taperfirst(fn, width, data, weights; padding)
    else
        taperfinal(fn, width, data, weights; padding)
    end
end

