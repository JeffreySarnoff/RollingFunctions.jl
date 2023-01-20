function rolling(data1::AbstractVector{T1}, window_span::Int, window_fn::F;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, F<:Function}
    if  isNothing(padding)
        basic_rolling(data1, window_span, window_fn)
    elseif !padlast
        padded_rolling(data1, window_span, window_fn; padding)
    else
        last_padded_rolling(data1, window_span, window_fn; padding)
    end
end

function rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int, window_fn::F;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, F<:Function}
    if  isNothing(padding)
        basic_rolling(data1, data2, window_span, window_fn)
    elseif !padlast
        padded_rolling(data1, data2, window_span, window_fn; padding)
    else
        last_padded_rolling(data1, data2, window_span, window_fn; padding)
    end
end

function rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, window_span::Int, window_fn::F;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, T3, F<:Function}
    if  isNothing(padding)
        basic_rolling(data1, data2, data3, window_span, window_fn)
    elseif !padlast
        padded_rolling(data1, data2, data3, window_span, window_fn; padding)
    else
        last_padded_rolling(data1, data2, data3, window_span, window_fn; padding)
    end
end

function rolling(data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4},
                 window_span::Int, window_fn::F;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, T2, T3, T4, F<:Function}
    if  isNothing(padding)
        basic_rolling(data1, data2, data3, data4, window_span, window_fn)
    elseif !padlast
        padded_rolling(data1, data2, data3, data4, window_span, window_fn; padding)
    else
        last_padded_rolling(data1, data2, data3, data4, window_span, window_fn; padding)
    end
end

function rolling(data1::AbstractMatrix{T1}, window_span::Int, window_fn::F;
                 padding=Nothing, padfirst=true, padlast=false) where {T1, F<:Function}
    if  isNothing(padding)
        basic_rolling(data1, window_span, window_fn)
    elseif !padlast
        padded_rolling(data1, window_span, window_fn; padding)
    else
        last_padded_rolling(data1, window_span, window_fn; padding)
    end
end
