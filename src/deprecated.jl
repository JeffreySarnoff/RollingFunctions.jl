
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

function rolling(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4}, width::Integer;
    padding=nopadding, atend=false) where {T1,T2,T3,T4,F<:Function}

    Base.depwarn(
        "The function `rolling` with 4 data vectors is unsupported.
        Please use `rolling(fn, width, datamatrix; ...)` where
        datamatrix = hcat(data1, data2, data3, data4) instead.",
        :rolling,
    )
end


function running(fn::F, data1::AbstractVector{T1}, width::Integer) where {T1,F<:Function}
    
    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(fn, width, data)` instead of `running(fn, data, width)`.",
        :running,
    )

    basic_running(fn, width, data1)
end

function running(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, width::Integer) where {T1,T2,F<:Function}
    
    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(fn, width, data1, data2)` instead of `running(fn, data1, data2, width)`.",
        :running,
    )

    basic_running(fn, width, data1, data2)
end

function running(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, width::Integer) where {T1,T2,T3,F<:Function}

    Base.depwarn(
        "The function `running` has changed. You are using a deprecated call signature. " *
        "Please use `running(fn, width, data1, data2, data3)` instead of `running(fn, data1, data2, data3, width)`.",
        :running,
    )

    basic_running(fn, width, data1, data2, data3)
end

function running(fn::F, data1::AbstractVector{T1}, data2::AbstractVector{T2}, data3::AbstractVector{T3}, data4::AbstractVector{T4}, width::Integer) where {T1,T2,T3,T4,F<:Function}

    Base.depwarn(
        "The function `running` with 4 data vectors is unsupported.
        Please use `running(fn, width, datamatrix)` where
        datamatrix = hcat(data1, data2, data3, data4) instead.",
        :running,
    )
end



# !! used with deprecated signatures !!
# local exceptions

WidthError(seqlength, windowwidth) =
    ErrorException("\n\tBad window width ($windowwidth) for length $seqlength.\n" )

WeightsError(nweighting, windowwidth) =
    ErrorException("\n\twindowwidth ($windowwidth) != length(weighting) ($nweighting))).\n" )
