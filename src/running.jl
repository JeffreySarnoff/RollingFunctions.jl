rollspan{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling, span), n, data)
rollstd{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling, std), n, data)
rollvar{T<:Number}(n::Int, data::Vector{T})  =  runner(Roller(rolling, var), n, data)
rollmad{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling, mad), n, data)

rollminimum{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling, minimum), n, data)
rollmaximum{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling, maximum), n, data)
rollmedian{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling, median), n, data)
rollmode{T<:Number}(n::Int, data::Vector{T})    = runner(Roller(rolling, mode), n, data)
rollmean{T<:Number}(n::Int, data::Vector{T})    = runner(Roller(rolling, mean), n, data)


rollspan_backfill{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling_backfill, span), n, data)
rollstd_backfill{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling_backfill, std), n, data)
rollvar_backfill{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling_backfill, var), n, data)
rollmad_backfill{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling_backfill, mad), n, data)

rollminimum_backfill{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling_backfill, minimum), n, data)
rollmaximum_backfill{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling_backfill, maximum), n, data)
rollmedian_backfill{T<:Number}(n::Int, data::Vector{T})  = runner(Roller(rolling_backfill, median), n, data)
rollmode_backfill{T<:Number}(n::Int, data::Vector{T})    = runner(Roller(rolling_backfill, mode), n, data)
rollmean_backfill{T<:Number}(n::Int, data::Vector{T})    = runner(Roller(rolling_backfill, mean), n, data)

