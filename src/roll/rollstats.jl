mad_not_normalized(x) = mad(x, normalize=false)
mad_normalized(x) = mad(x, normalize=true)

for T1 in (:T, :(Union{Missing,T}))    
    for (R,F) in ((:rollmin, :minimum), (:rollmax, :maximum),
                  (:rollmean, :mean), (:rollmedian, :median), 
                  (:rollvar, :var), (:rollstd, :std),
                  (:rollskewness, :skewness), (:rollkurtosis, :kurtosis),
                  (:rollsem, :sem), 
                  (:rollmad, :mad_not_normalized),
                  (:rollmad_normalized, :mad_normalized),
                  (:rollvariation, :variation))
        @eval begin
            $R(data::V, windowspan::Int) where {T, V<:AbstractVector{$T1}} =
                rolling($F, data, windowspan)
            $R(data::V, windowspan::Int, weighting::AbstractVector{S}) where {T, V<:AbstractVector{$T1}, S} =
                rolling($F, data, windowspan, weighting)
            $R(data::V, windowspan::Int, weighting::AbstractWeights) where {T, V<:AbstractVector{$T1}} =
                rolling($F, data, windowspan, weighting.values)
        end
    end
end


rollcor(data1::V1, data2::V2, windowspan::Int) where {T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                         V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    rolling(cor, data1, data2, windowspan)

rollcov(data1::V1, data2::V2, windowspan::Int) where {T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                         V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    rolling(cov, data1, data2, windowspan)

rollcor(data1::V1, data2::V2, windowspan::Int, weighting::AbstractVector{S}) where {S, T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                                                          V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    rolling(cor, data1, data2, windowspan, weighting)

rollcov(data1::V1, data2::V2, windowspan::Int, weighting::AbstractVector{S}) where {S, T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                                                          V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    rolling(cov, data1, data2, windowspan, weighting)

#=
repeatedly calls itself

rollcor(data1::V1, data2::V2, windowspan::Int, weighting::AbstractWeights) where {S, T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                                                        V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    rolling(cor, data1, data2, windowspan, weighting.values)

rollcov(data1::V1, data2::V2, windowspan::Int, weighting::AbstractWeights) where {S, T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                                                        V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    rolling(cov, data1, data2, windowspan, weighting.values)
=#
