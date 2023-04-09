function rolling(func::F, data1::AbstractVector{T1}, span::Span;
    padding=nopadding, padlast=false) where {T1,F<:Function}
    
    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(func, span, data_vec; ...)` instead of `rolling(func, data_vec, span; ...)`.",
        :rolling,
    )

    if isnopadding(padding)
        basic_rolling(func, data1, span)
    elseif !padlast
        padfirst_rolling(func, data1, span; padding)
    else
        padfinal_rolling(func, data1, span; padding)
    end
end

function rolling(func::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, span::Span;
    padding=nopadding, padlast=false) where {T1,T2,F<:Function}
    
    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(func, span, data_vec1, data_vec2; ...)` instead of `rolling(func, data_vec1, data_vec2, span; ...)`.",
        :rolling,
    )

    if isnopadding(padding)
        basic_rolling(func, data1, data2, span)
    elseif !padlast
        padfirst_rolling(func, data1, data2, span; padding)
    else
        padfinal_rolling(func, data1, data2, span; padding)
    end
end

function running(func::F, data1::AbstractVector{T1}, span::Span;
    padding=nopadding) where {T1,F<:Function}
    
    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(func, span, data_vec; ...)` " *
        "instead of `running(func, data_vec, span; ...)`.",
        :running,
    )

    if isnopadding(padding)
        basic_running(func, data1, span)
    else
        padfirst_running(func, data1, span; padding)
    end
end

function running(func::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, span::Span;
    padding=nopadding) where {T1,T2,F<:Function}
    
    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(func, span, data_vec1, data_vec2; ...)` " *
        "instead of `running(func, data_vec1, data_vec2, span; ...)`.",
        :running,
    )

    if isnopadding(padding)
        basic_running(func, data1, data2, span)
    else
        padfirst_running(func, data1, data2, span; padding)
    end
end

# !! used with deprecated signatures !!
# local exceptions

SpanError(seqlength, windowspan) =
    ErrorException("\n\tBad window span ($windowspan) for length $seqlength.\n" )

WeightsError(nweighting, windowspan) =
    ErrorException("\n\twindowspan ($windowspan) != length(weighting) ($nweighting))).\n" )
