Base.@deprecate rolling(fun::Function, data::AbstractVector{T}, windowspan::Int) rolling(fun::F, width::Width, data::AbstractVector{T}) where {T, F<:Function}

function rolling(func::F, data1::AbstractVector{T1}, width::Width;
    padding=nopadding, atend=false) where {T1,F<:Function}
    
    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(func, width, data_vec; ...)` instead of `rolling(func, data_vec, width; ...)`.",
        :rolling,
    )

    if isnopadding(padding)
        basic_rolling(func, data1, width)
    elseif !atend
        padfirst_rolling(func, data1, width; padding)
    else
        padfinal_rolling(func, data1, width; padding)
    end
end

function rolling(func::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, width::Width;
    padding=nopadding, atend=false) where {T1,T2,F<:Function}
    
    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(func, width, data_vec1, data_vec2; ...)` instead of `rolling(func, data_vec1, data_vec2, width; ...)`.",
        :rolling,
    )

    if isnopadding(padding)
        basic_rolling(func, data1, data2, width)
    elseif !atend
        padfirst_rolling(func, data1, data2, width; padding)
    else
        padfinal_rolling(func, data1, data2, width; padding)
    end
end

function running(func::F, data1::AbstractVector{T1}, width::Width;
    padding=nopadding) where {T1,F<:Function}
    
    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(func, width, data_vec; ...)` " *
        "instead of `running(func, data_vec, width; ...)`.",
        :running,
    )

    if isnopadding(padding)
        basic_running(func, data1, width)
    else
        padfirst_running(func, data1, width; padding)
    end
end

function running(func::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, width::Width;
    padding=nopadding) where {T1,T2,F<:Function}
    
    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(func, width, data_vec1, data_vec2; ...)` " *
        "instead of `running(func, data_vec1, data_vec2, width; ...)`.",
        :running,
    )

    if isnopadding(padding)
        basic_running(func, data1, data2, width)
    else
        padfirst_running(func, data1, data2, width; padding)
    end
end

# !! used with deprecated signatures !!
# local exceptions

WidthError(seqlength, windowwidth) =
    ErrorException("\n\tBad window width ($windowwidth) for length $seqlength.\n" )

WeightsError(nweighting, windowwidth) =
    ErrorException("\n\twindowwidth ($windowwidth) != length(weighting) ($nweighting))).\n" )
