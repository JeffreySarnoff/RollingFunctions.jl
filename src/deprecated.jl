
function rolling(fn::F, data1::AbstractVector{T1}, width::Integer;
    padding=nopadding, atend=false) where {T1,F<:Function}
    
    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(fn, width, data; ...)` instead of `rolling(fn, data, width; ...)`.",
        :rolling,
    )

    if hasnopadding(padding)
        basic_rolling(fn, width, data1)
    elseif !atend
        padfirst_rolling(fn, width, data1; padding)
    else
        padfinal_rolling(fn, width, data1; padding)
    end
end

function rolling(fn::F, data1::AbstractVector{T1}, width::Integer, weights::AbstractVector{T2};
    padding=nopadding, atend=false) where {T1,T2,F<:Function}

    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(fn, width, data, weights; ...)` instead of `rolling(fn, data, width, weights; ...)`.",
        :rolling,
    )

    if hasnopadding(padding)
        basic_rolling(fn, width, data1, weights)
    elseif !atend
        padfirst_rolling(fn, width, data1, weights; padding)
    else
        padfinal_rolling(fn, width, data1, weights; padding)
    end
end

function rolling(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, width::Integer;
    padding=nopadding, atend=false) where {T1,T2,F<:Function}
    
    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(fn, width, data1, data2; ...)` instead of `rolling(fn, data1, data2, width; ...)`.",
        :rolling,
    )

    if hasnopadding(padding)
        basic_rolling(fn, width, data1, data2)
    elseif !atend
        padfirst_rolling(fn, width, data1, data2; padding)
    else
        padfinal_rolling(fn, width, data1, data2; padding)
    end
end

function rolling(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, width::Integer, weights::AbstractVector{T3};
    padding=nopadding, atend=false) where {T1,T2,T3,F<:Function}

    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(fn, width, data1, data2, weights; ...)` instead of `rolling(fn, data1, data2, width, weights; ...)`." *
        "Note: weights must be of type StatsBase.AbstractWeights.",
        :rolling,
    )

    if hasnopadding(padding)
        basic_rolling(fn, width, data1, data2, weights)
    elseif !atend
        padfirst_rolling(fn, width, data1, data2, weights; padding)
    else
        padfinal_rolling(fn, width, data1, data2, weights; padding)
    end
end

function rolling(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, width::Integer;
    padding=nopadding, atend=false) where {T1,T2,T3,F<:Function}

    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(fn, width, data1, data2, data3; ...)` instead of `rolling(fn, data1, data2, data3, width; ...)`.",
        :rolling,
    )

    if hasnopadding(padding)
        basic_rolling(fn, width, data1, data2, data3)
    elseif !atend
        padfirst_rolling(fn, width, data1, data2, data3; padding)
    else
        padfinal_rolling(fn, width, data1, data2, data3; padding)
    end
end

function rolling(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, width::Integer, weights::AbstractVector{T4};
    padding=nopadding, atend=false) where {T1,T2,T3,T4,F<:Function}

    Base.depwarn(
        "The function `rolling` has changed. You are using a deprecated call signature. " *
        "Please use `rolling(fn, width, data1, data2, data3, weights; ...)` instead of `rolling(fn, data1, data2, data3, width, weights; ...)`." *
        "Note: weights must be of type StatsBase.AbstractWeights.",
        :rolling,
    )

    if hasnopadding(padding)
        basic_rolling(fn, width, data1, data2, data3, weights)
    elseif !atend
        padfirst_rolling(fn, width, data1, data2, data3, weights; padding)
    else
        padfinal_rolling(fn, width, data1, data2, data3, weights; padding)
    end
end

function rolling(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4}, width::Integer;
    padding=nopadding, atend=false) where {T1,T2,T3,T4,F<:Function}

    Base.depwarn(
        "The function `rolling` with 4 data vectors is unsupported.
        Please use `rolling(fn, width, datamatrix; ...)` where
        datamatrix = hcat(data1, data2, data3, data4) instead.",
        :rolling,
    )
end

function rolling(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4}, width::Integer, weights::AbstractVector{T5};
    padding=nopadding, atend=false) where {T1,T2,T3,T4,T5,F<:Function}

    Base.depwarn(
        "The function `rolling` with 4 data vectors is unsupported.
        Please use `rolling(fn, width, datamatrix; ...)` where
        datamatrix = hcat(data1, data2, data3, data4) instead." *
        "Note: weights must be of type StatsBase.AbstractWeights.",
        :rolling,
    )
end

function running(fn::F, data1::AbstractVector{T1}, width::Integer;
    padding=nopadding, atend=false) where {T1,F<:Function}

    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(fn, width, data; ...)` instead of `running(fn, data, width; ...)`.",
        :running,
    )

    if hasnopadding(padding)
        basic_running(fn, width, data1)
    elseif !atend
        padfirst_running(fn, width, data1; padding)
    else
        padfinal_running(fn, width, data1; padding)
    end
end

function running(fn::F, data1::AbstractVector{T1}, width::Integer, weights::AbstractVector{T2};
    padding=nopadding, atend=false) where {T1,T2,F<:Function}

    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(fn, width, data, weights; ...)` instead of `running(fn, data, width, weights; ...)`.",
        :running,
    )

    if hasnopadding(padding)
        basic_running(fn, width, data1, weights)
    elseif !atend
        padfirst_running(fn, width, data1, weights; padding)
    else
        padfinal_running(fn, width, data1, weights; padding)
    end
end

function running(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, width::Integer;
    padding=nopadding, atend=false) where {T1,T2,F<:Function}

    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(fn, width, data1, data2; ...)` instead of `running(fn, data1, data2, width; ...)`.",
        :running,
    )

    if hasnopadding(padding)
        basic_running(fn, width, data1, data2)
    elseif !atend
        padfirst_running(fn, width, data1, data2; padding)
    else
        padfinal_running(fn, width, data1, data2; padding)
    end
end

function running(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, width::Integer, weights::AbstractVector{T3};
    padding=nopadding, atend=false) where {T1,T2,T3,F<:Function}

    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(fn, width, data1, data2, weights; ...)` instead of `running(fn, data1, data2, width, weights; ...)`." *
        "Note: weights must be of type StatsBase.AbstractWeights.",
        :running,
    )

    if hasnopadding(padding)
        basic_running(fn, width, data1, data2, weights)
    elseif !atend
        padfirst_running(fn, width, data1, data2, weights; padding)
    else
        padfinal_running(fn, width, data1, data2, weights; padding)
    end
end

function running(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, width::Integer;
    padding=nopadding, atend=false) where {T1,T2,T3,F<:Function}

    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(fn, width, data1, data2, data3; ...)` instead of `running(fn, data1, data2, data3, width; ...)`.",
        :running,
    )

    if hasnopadding(padding)
        basic_running(fn, width, data1, data2, data3)
    elseif !atend
        padfirst_running(fn, width, data1, data2, data3; padding)
    else
        padfinal_running(fn, width, data1, data2, data3; padding)
    end
end

function running(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, width::Integer, weights::AbstractVector{T4};
    padding=nopadding, atend=false) where {T1,T2,T3,T4,F<:Function}

    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(fn, width, data1, data2, data3, weights; ...)` instead of `running(fn, data1, data2, data3, width, weights; ...)`." *
        "Note: weights must be of type StatsBase.AbstractWeights.",
        :running,
    )

    if hasnopadding(padding)
        basic_running(fn, width, data1, data2, data3, weights)
    elseif !atend
        padfirst_running(fn, width, data1, data2, data3, weights; padding)
    else
        padfinal_running(fn, width, data1, data2, data3, weights; padding)
    end
end

function running(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4}, width::Integer;
    padding=nopadding, atend=false) where {T1,T2,T3,T4,F<:Function}

    Base.depwarn(
        "The function `running` with 4 data vectors is unsupported.
        Please use `running(fn, width, datamatrix; ...)` where
        datamatrix = hcat(data1, data2, data3, data4) instead.",
        :running,
    )
end

function running(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4}, width::Integer, weights::AbstractVector{T5};
    padding=nopadding, atend=false) where {T1,T2,T3,T4,T5,F<:Function}

    Base.depwarn(
        "The function `running` with 4 data vectors is unsupported.
        Please use `running(fn, width, datamatrix; ...)` where
        datamatrix = hcat(data1, data2, data3, data4) instead." *
        "Note: weights must be of type StatsBase.AbstractWeights.",
        :running,
    )
end


# !! used with deprecated signatures !!
# local exceptions

WidthError(seqlength, windowwidth) =
    ErrorException("\n\tBad window width ($windowwidth) for length $seqlength.\n" )

WeightsError(nweighting, windowwidth) =
    ErrorException("\n\twindowwidth ($windowwidth) != length(weighting) ($nweighting))).\n" )
