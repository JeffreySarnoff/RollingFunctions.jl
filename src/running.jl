for (F,R) in [(:minimum, :rollminimum), (:maximum, :rollmaximum),
              (:median, :rollmedian), (:mode, :rollmode), (:mean, :rollmean),
              (:std, :rollstd), (:var, :rollvar), (:mad, :rollmad)]
    @eval begin
        $R{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling, $F), n, data)
        $R{T<:Number}(::Type{FillFirst}, n::Int, data::Vector{T})  = runner(Roller(rolling_fill_first, $F), n, data)
        $R{T<:Number}(::Type{FillLast}, n::Int, data::Vector{T})   = runner(Roller(rolling_fill_last, $F), n, data)
        $R{T<:Number}(::Type{FillCenter}, n::Int, data::Vector{T}) = runner(Roller(rolling_fill_center, $F), n, data)
    end
end
