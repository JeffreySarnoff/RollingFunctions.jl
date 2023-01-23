function rolling(window_fn::F, data1::AbstractVector{T1}, window_span::Int;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, window_span)
    elseif !padlast
        padded_rolling(window_fn, data1, window_span; padding)
    else
        last_padded_rolling(window_fn, data1, window_span; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, data2, window_span)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, window_span; padding)
    else
        last_padded_rolling(window_fn, data1, data2, window_span; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, window_span::Int;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, T3, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, data2, data3, window_span)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, data3, window_span; padding)
    else
        last_padded_rolling(window_fn, data1, data2, data3, window_span; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                 window_span::Int;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, T3, T4, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, data2, data3, data4, window_span)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, data3, data4, window_span; padding)
    else
        last_padded_rolling(window_fn, data1, data2, data3, data4, window_span; padding)
    end
end

function rolling(window_fn::F, data1::AbstractMatrix{T1}, window_span::Int;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, window_span)
    elseif !padlast
        padded_rolling(window_fn, data1, window_span; padding)
    else
        last_padded_rolling(window_fn, data1, window_span; padding)
    end
end

# weighted

function rolling(window_fn::F, data1::AbstractVector{T1}, window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padfirst=true, padlast=false) where {T1, TW, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, window_span, weights)
    elseif !padlast
        padded_rolling(window_fn, data1, window_span, weights; padding)
    else
        last_padded_rolling(window_fn, data1, window_span, weights; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, TW, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, data2, window_span, weights)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, window_span, window_fn; padding)
    else
        last_padded_rolling(window_fn, data1, data2, window_span, window_fn; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, T3, TW, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, data2, data3, window_span, weights)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, data3, window_span, weights; padding)
    else
        last_padded_rolling(window_fn, data1, data2, data3, window_span, weights; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                 window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, T3, T4, TW, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, data2, data3, data4, window_span, weights)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, data3, data4, window_span, weights; padding)
    else
        last_padded_rolling(window_fn, data1, data2, data3, data4, window_span, weights; padding)
    end
end

function rolling(window_fn::F, data1::AbstractMatrix{T1}, window_span::Int, weights::AbstractVector{TW};
                 padding=Nothing, padfirst=true, padlast=false) where {T1, TW, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, window_span, weights)
    elseif !padlast
        padded_rolling(window_fn, data1, window_span, weights; padding)
    else
        last_padded_rolling(window_fn, data1, window_span, weights; padding)
    end
end

function rolling(window_fn::F, data1::AbstractMatrix{T1}, window_span::Int, weights::AbstractMatrix{TW};
                 padding=Nothing, padfirst=true, padlast=false) where {T1, TW, F<:Function}
    if  isNothing(padding)
        basic_rolling(window_fn, data1, window_span, weights)
    elseif !padlast
        padded_rolling(window_fn, data1, window_span, weights; padding)
    else
        last_padded_rolling(window_fn, data1, window_span, weights; padding)
    end
end
