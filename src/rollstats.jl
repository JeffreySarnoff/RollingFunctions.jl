for (R,F) in ((:rollmin, :minimum), (:rollmax, :maximum),
              (:rollmean, :mean), (:rollmedian, :median), 
              (:rollvar, :var), (:rollstd, :std),
              (:rollskewness, :skewness), (:rollkurtosis, :kurtosis),
              (:rollsem, :sem), (:rollmad, :mad),
              (:rollvariation, :variation))
    @eval begin
        $R(data::AbstractVector{T}, windowspan::Int) where {T} =
            rolling($F, data, windowspan)
    end
end
