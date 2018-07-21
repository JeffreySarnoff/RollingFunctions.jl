mad_not_normalized(x) = mad(x, normalize=false)
mad_normalized(x) = mad(x, normalize=true)

for (R,F) in ((:rollmin, :minimum), (:rollmax, :maximum),
              (:rollmean, :mean), (:rollmedian, :median), 
              (:rollvar, :var), (:rollstd, :std),
              (:rollskewness, :skewness), (:rollkurtosis, :kurtosis),
              (:rollsem, :sem), 
              (:rollmad, :mad_not_normalized),
              (:rollmad_normalized, :mad_normalized),
              (:rollvariation, :variation))
    @eval begin
        $R(data::AbstractVector{T}, windowspan::Int) where {T} =
            rolling($F, data, windowspan)
        $R(data::AbstractVector{T}, windowspan::Int, weighting::AbstractVector{S}) where {T,S} =
            rolling($F, data, windowspan, weighting)
        $R(data::AbstractVector{T}, windowspan::Int, weighting::AbstractWeights) where {T} =
            rolling($F, data, windowspan, weighting.values)
    end
end
