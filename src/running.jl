for (F,R) in [(:minimum, :rollminimum), (:maximum, :rollmaximum),
              (:median, :rollmedian), (:mode, :rollmode), (:mean, :rollmean),
              (:std, :rollstd), (:var, :rollvar), (:mad, :rollmad)]
    @eval begin
        $R{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling, $F), n, data)
        $R{T<:Number}(::Type{AtFirst}, n::Int, data::Vector{T})  = runner(Roller(rolling_fill_first, $F), n, data)
        $R{T<:Number}(::Type{AtLast}, n::Int, data::Vector{T})   = runner(Roller(rolling_fill_last, $F), n, data)
        $R{T<:Number}(::Type{AtCenter}, n::Int, data::Vector{T}) = runner(Roller(rolling_fill_center, $F), n, data)
    end
end
