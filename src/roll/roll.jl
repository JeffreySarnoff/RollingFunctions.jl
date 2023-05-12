#=
    unweighted rolling

    rolling(func, width, data...; 
            padfirst=nopadding, atend=false)
=#


function rolling(func::F, width::Width,
    data1::AbstractVector{T};
    padding=nopadding, atend=false) where {T,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, width, data1)
    elseif !atend
        padfirst_rolling(func, width, data1, padding)
    else
        padfinal_rolling(func, width, data1, padding)
    end
end

function rolling(func::F, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2};
    padding=nopadding, atend=false) where {T1,T2,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, width, data1, data2)
    elseif !atend
        padfirst_rolling(func, width, data1, data2, padding)
    else
        padfinal_rolling(func, width, data1, data2, padding)
    end
end

function rolling(func::F, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3};
    padding=nopadding, atend=false) where {T1,T2,T3,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, width, data1, data2, data3)
    elseif !atend
        padfirst_rolling(func, width, data1, data2, data3, padding)
    else
        padfinal_rolling(func, width, data1, data2, data3, padding)
    end
end

function rolling(func::F, width::Width,
    data1::AbstractMatrix{T};
    padding=nopadding, atend=false) where {T,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, width, data1)
    elseif !atend
        padfirst_rolling(func, width, data1, padding)
    else
        padfinal_rolling(func, width, data1, padding)
    end
end

# with weights

function rolling(func::F, width::Width,
    data1::AbstractVector{T}, weight1::Weighting{W};
    padding=nopadding, atend=false) where {T,W,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, width, data1, weight1)
    elseif !atend
        padfirst_rolling(func, width, data1, weight1, padding)
    else
        padfinal_rolling(func, width, data1, weight1, padding)
    end
end

function rolling(func::F, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2},
    weight1::Weighting{W};
    padding=nopadding, atend=false) where {T1,T2,W,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, width, data1, data2, weight1, weight1)
    elseif !atend
        padfirst_rolling(func, width, data1, data2, weight1, weight1, padding)
    else
        padfinal_rolling(func, width, data1, data2, weight1, weight1, padding)
    end
end

function rolling(func::F, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2},
    weight1::Weighting{W1}, weight2::Weighting{W2};
    padding=nopadding, atend=false) where {T1,T2,W1,W2,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, width, data1, data2, weight1, weight2)
    elseif !atend
        padfirst_rolling(func, width, data1, data2, weight1, weight2, padding)
    else
        padfinal_rolling(func, width, data1, data2, weight1, weight2, padding)
    end
end

function rolling(func::F, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::Weighting{W};
    padding=nopadding, atend=false) where {T1,T2,T3,W,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, width, data1, data2, data3, weight1, weight1, weight1)
    elseif !atend
        padfirst_rolling(func, width, data1, data2, data3, weight1, weight1, weight1, padding)
    else
        padfinal_rolling(func, width, data1, data2, data3, weight1, weight1, weight1, padding)
    end
end

function rolling(func::F, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::Weighting{W1}, weight2::Weighting{W2}, weight3::Weighting{W3};
    padding=nopadding, atend=false) where {T1,T2,T3,W1,W2,W3,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, width, data1, data2, data3, weight1, weight2, weight3)
    elseif !atend
        padfirst_rolling(func, width, data1, data2, data3, weight1, weight2, weight3, padding)
    else
        padfinal_rolling(func, width, data1, data2, data3, weight1, weight2, weight3, padding)
    end
end

function rolling(func::F, width::Width,
    data1::AbstractMatrix{T}, weight1::Weighting{W};
    padding=nopadding, atend=false) where {T,W,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, width, data1, weight1)
    elseif !atend
        padfirst_rolling(func, width, data1, weight1, padding)
    else
        padfinal_rolling(func, width, data1, weight1, padding)
    end
end

function rolling(func::F, width::Width,
    data::Tuple{<:AbstractArray}, weight1::Weighting{W};
    padding=nopadding, atend=false) where {W,F<:Function}
    if isnopadding(padding)
        basic_rolling(func, width, data, weight1)
    elseif !atend
        padfirst_rolling(func, width, data, weight1, padding)
    else
        padfinal_rolling(func, width, data, weight1, padding)
    end
end

