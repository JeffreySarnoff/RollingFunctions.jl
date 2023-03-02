function rolling(window_fn::F, data1::AbstractVector{T1}, window_span::Int;
    padding=Nothing, padlast=false) where {T1,F<:Function}
    
    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(window_fn, window_span, data_vec; ...)` instead of `rolling(window_fn, data_vec, window_span; ...)`.",
        :rolling,
    )

    if isNothing(padding)
        basic_rolling(window_fn, data1, window_span)
    elseif !padlast
        padded_rolling(window_fn, data1, window_span; padding)
    else
        last_padded_rolling(window_fn, data1, window_span; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int;
    padding=Nothing, padlast=false) where {T1,T2,F<:Function}
    
    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(window_fn, window_span, data_vec1, data_vec2; ...)` instead of `rolling(window_fn, data_vec1, data_vec2, window_span; ...)`.",
        :rolling,
    )

    if isNothing(padding)
        basic_rolling(window_fn, data1, data2, window_span)
    elseif !padlast
        padded_rolling(window_fn, data1, data2, window_span; padding)
    else
        last_padded_rolling(window_fn, data1, data2, window_span; padding)
    end
end

function running(window_fn::F, data1::AbstractVector{T1}, window_span::Int;
    padding=Nothing) where {T1,F<:Function}
    
    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(window_fn, window_span, data_vec; ...)` " *
        "instead of `running(window_fn, data_vec, window_span; ...)`.",
        :running,
    )

    if isNothing(padding)
        basic_running(window_fn, data1, window_span)
    else
        padded_running(window_fn, data1, window_span; padding)
    end
end

function running(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Int;
    padding=Nothing) where {T1,T2,F<:Function}
    
    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(window_fn, window_span, data_vec1, data_vec2; ...)` " *
        "instead of `running(window_fn, data_vec1, data_vec2, window_span; ...)`.",
        :running,
    )

    if isNothing(padding)
        basic_running(window_fn, data1, data2, window_span)
    else
        padded_running(window_fn, data1, data2, window_span; padding)
    end
end
