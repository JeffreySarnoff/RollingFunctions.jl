mad_not_normalized(x) = mad(x, normalize=false)
mad_normalized(x) = mad(x, normalize=true)

for (T1, T2) in ((:T, :(float(T))), (:(Union{Missing,T}), :(Union{Missing,float(T)})))
  @eval begin
    
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

    for (R,F) in ((:rollcor, :cor), (:rollcov, :cov))
        @eval begin
            $R(data1::V, data2::V, windowspan::Int) where {T, V<:AbstractVector{$T1}} =
                rolling($F, data1, data2, windowspan)
            $R(data1::V, data2::V, windowspan::Int, weighting::AbstractVector{S}) where {T, V<:AbstractVector{$T1}, S} =
                rolling($F, data1, data2, windowspan, weighting)
            $R(data1::V, data2::V, windowspan::Int, weighting::AbstractWeights) where {T, V<:AbstractVector{$T1}} =
                rolling($F, data1, data2, windowspan, weighting.values)
        end
    end

  end
end
