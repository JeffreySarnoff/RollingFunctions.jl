#=
    unweighted running

    running(func, width, data...; 
            taperfirst=nopadding, taperlast=false)
=#

function running(func::F, width::Width,
    data1::AbstractVector{T}; taperlast=false) where {T,F<:Function}
    if !taperlast
        taperfirst(func, width, data1)
    else
        taperfinal(func, width, data1)
    end
end

function running(func::F, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2};
    taperlast=false) where {T1,T2,F<:Function}
    if !taperlast
        taperfirst(func, width, data1, data2)
    else
        taperfinal(func, width, data1, data2)
    end
end

function running(func::F, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3};
    taperlast=false) where {T1,T2,T3,F<:Function}
    if !taperlast
        taperfirst(func, width, data1, data2, data3)
    else
        taperfinal(func, width, data1, data2, data3)
    end
end

function running(func::F, width::Width,
    data1::AbstractMatrix{T};
    taperlast=false) where {T,F<:Function}
    if !taperlast
        taperfirst(func, width, data1)
    else
        taperfinal(func, width, data1)
    end
end

# with weights

function running(func::F, width::Width,
    data1::AbstractVector{T}, weight1::Weighting{W};
    taperlast=false) where {T,W,F<:Function}
    if !taperlast
        taperfirst(func, width, data1, weight1)
    else
        taperfinal(func, width, data1, weight1)
    end
end

function running(func::F, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, 
    weight1::Weighting{W}; 
    taperlast=false) where {T1,T2,W,F<:Function}
    if !taperlast
        taperfirst(func, width, data1, data2, weight1, weight1)
    else
        taperfinal(func, width, data1, data2, weight1, weight1)
    end
end

function running(func::F, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2},
    weight1::Weighting{W1}, weight2::Weighting{W2};
    taperlast=false) where {T1,T2,W1,W2,F<:Function}
    if !taperlast
        taperfirst(func, width, data1, data2, weight1, weight2)
    else
        taperfinal(func, width, data1, data2, weight1, weight2)
    end
end

function running(func::F, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::Weighting{W};
    taperlast=false) where {T1,T2,T3,W,F<:Function}
    if !taperlast
        taperfirst(func, width, data1, data2, data3, weight1, weight1, weight1)
    else
        taperfinal(func, width, data1, data2, data3, weight1, weight1, weight1)
    end
end

function running(func::F, width::Width,
    data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3},
    weight1::Weighting{W1}, weight2::Weighting{W2}, weight3::Weighting{W3};
    taperlast=false) where {T1,T2,T3,W1,W2,W3,F<:Function}
    if !taperlast
        taperfirst(func, width, data1, data2, data3, weight1, weight2, weight3)
    else
        taperfinal(func, width, data1, data2, data3, weight1, weight2, weight3)
    end
end

function running(func::F, width::Width,
    data1::AbstractMatrix{T}, weight1::Weighting{W};
    taperlast=false) where {T,W,F<:Function}
    if !taperlast
        taperfirst(func, width, data1, weight1)
    else
        taperfinal(func, width, data1, weight1)
    end
end

function running(func::F, width::Width,
    data::Tuple{<:AbstractArray}, weight1::Weighting{W};
    taperlast=false) where {W,F<:Function}
    if !taperlast
        taperfirst(func, width, data, weight1)
    else
        taperfinal(func, width, data, weight1)
    end
end

