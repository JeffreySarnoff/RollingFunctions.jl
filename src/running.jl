
rolling_mean(rollspan::Int; fillpart::AbstractFillPart=FirstPart, fillwith::AbstractFillWith=WithRepeated) =
    Roller(fillpart, fillwith, mean, rollspan)

rollmean{T<:Number}(rollspan::Int, data::Vector{T}) =
    roll(rolling_mean(rollspan), data)

rollmean{T<:Number}(fillpart::AbstractFillPart, rollspan::Int, data::Vector{T}) = 
    roll(rolling_mean(rollspan, fillpart=fillpart), data)

function rollmean{T<:Number}(fillpart::AbstractFillPart, fillwith::AbstractFillWith, rollspan::Int, data::Vector{T})
    rolling = rolling_mean(rollspan, fillpart=fillpart, fillwith=fillwith)
    return roll(rolling, data)
end

rollmean{FW, T<:Number}(::Type{FillLastPart}, ::Type{FW}, rollspan::Int, data::Vector{T}) =
    Roller(LastPart, WithRepeated, mean, rollspan)

#=
function roll{T}(roller::Roller{FillFirstPart, FillWithRepeated}, data::Vector{T})
    return rolling_fill_first(roller.rolling, roller.rollspan, data)
end

rolling_mean_fill_first=Roller(FirstPart,WithRepeated,mean,5)

data = map(Float64,collect(1:8:100))
result = roll(rolling_mean_fill_first, data)
=#

for (F,N) in [(:minimum, :rollminimum), (:maximum, :rollmaximum),
              (:median, :rollmedian), (:mode, :rollmode), (:mean, :rollmean),
              (:std, :rollstd), (:var, :rollvar), (:mad, :rollmad)]
    @eval begin
        $N{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling, $F), n, data)
        $N{T<:Number}(::Type{FillFirst}, n::Int, data::Vector{T})  = runner(Roller(rolling_fill_first, $F), n, data)
        $N{T<:Number}(::Type{FillLast}, n::Int, data::Vector{T})   = runner(Roller(rolling_fill_last, $F), n, data)
        $N{T<:Number}(::Type{FillBoth}, n::Int, data::Vector{T}) = runner(Roller(rolling_fill_center, $F), n, data)
    end
end
