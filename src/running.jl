

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
    
#=
rollminimum{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling, minimum), n, data)
rollmaximum{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling, maximum), n, data)

rollmedian{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling, median), n, data)
rollmode{T<:Number}(n::Int, data::Vector{T})    = runner(Roller(rolling, mode), n, data)
rollmean{T<:Number}(n::Int, data::Vector{T})    = runner(Roller(rolling, mean), n, data)

rollstd{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling, std), n, data)
rollvar{T<:Number}(n::Int, data::Vector{T})  =  runner(Roller(rolling, var), n, data)
rollmad{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(roll
rollspan_fill_last{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling_fill_last, span), n, data)
rollstd_fill_last{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling_fill_last, std), n, data)
rollvar_fill_last{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling_fill_last, var), n, data)
rollmad_fill_last{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling_fill_last, mad), n, data)

rollminimum_backfill{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling_backfill, minimum), n, data)
rollmaximum_backfill{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling_backfill, maximum), n, data)
rollmedian_backfill{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling_backfill, median), n, data)
rollmode_backfill{T<:Number}(n::Int, data::Vector{T})    = runner(Roller(rolling_backfill, mode), n, data)
rollmean_backfill{T<:Number}(n::Int, data::Vector{T})    = runner(Roller(rolling_backfill, mean), n, data)
=#
