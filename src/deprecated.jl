function rolling(window_fn::F, data1::AbstractVector{T1}, window_span::Span;
    padding=nopadding, padlast=false) where {T1,F<:Function}
    
    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(window_fn, window_span, data_vec; ...)` instead of `rolling(window_fn, data_vec, window_span; ...)`.",
        :rolling,
    )

    if isnopadding(padding)
        basic_rolling(window_fn, data1, window_span)
    elseif !padlast
        padfirst_rolling(window_fn, data1, window_span; padding)
    else
        padfinal_rolling(window_fn, data1, window_span; padding)
    end
end

function rolling(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Span;
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    
    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(window_fn, window_span, data_vec1, data_vec2; ...)` instead of `rolling(window_fn, data_vec1, data_vec2, window_span; ...)`.",
        :rolling,
    )

    if isnopadding(padding)
        basic_rolling(window_fn, data1, data2, window_span)
    elseif !padlast
        padfirst_rolling(window_fn, data1, data2, window_span; padding)
    else
        padfinal_rolling(window_fn, data1, data2, window_span; padding)
    end
end

function running(window_fn::F, data1::AbstractVector{T1}, window_span::Span;
    padding=nopadding) where {T1,F<:Function}
    
    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(window_fn, window_span, data_vec; ...)` " *
        "instead of `running(window_fn, data_vec, window_span; ...)`.",
        :running,
    )

    if isnopadding(padding)
        basic_running(window_fn, data1, window_span)
    else
        padfirst_running(window_fn, data1, window_span; padding)
    end
end

function running(window_fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, window_span::Span;
    padding=nopadding) where {T1,T2,F<:Function}
    
    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(window_fn, window_span, data_vec1, data_vec2; ...)` " *
        "instead of `running(window_fn, data_vec1, data_vec2, window_span; ...)`.",
        :running,
    )

    if isnopadding(padding)
        basic_running(window_fn, data1, data2, window_span)
    else
        padfirst_running(window_fn, data1, data2, window_span; padding)
    end
end

# !! used with deprecated signatures !!
# local exceptions

SpanError(seqlength, windowspan) =
    ErrorException("\n\tBad window span ($windowspan) for length $seqlength.\n" )

WeightsError(nweighting, windowspan) =
    ErrorException("\n\twindowspan ($windowspan) != length(weighting) ($nweighting))).\n" )
