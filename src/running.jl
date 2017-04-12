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
