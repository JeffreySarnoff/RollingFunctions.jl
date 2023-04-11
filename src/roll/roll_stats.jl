for T1 in (:T, :(Union{Missing,T}))
    for (R, F) in ((:rollmin, :vminimum), (:rollmax, :vmaximum),
        (:rollmean, :vmean), (:rollsum, :vsum),
        (:rollvar, :vvar), (:rollstd, :vstd))
        @eval begin
            $R(span::Span, data::V; padding=nopadding, padlast=false) where {T, V<:AbstractVector{$T1}} =
                rolling($F, span, data; padding, padlast)
            $R(span::Span, data::V, weights::W; padding=nopadding, padlast=false) where {T, V<:AbstractVector{$T1}, W<:AbstractWeights} =
                rolling($F, span, data, weights; padding, padlast)
        end
    end
end

for T1 in (:T, :(Union{Missing,T}))
    for (R, F) in ((:rollcor, :vcor), (:rollcov, :vcov))
        @eval begin
            $R(span::Span, data1::V, data2::V; padding=nopadding, padlast=false) where {T,V<:AbstractVector{$T1}} =
                rolling($F, span, data1, data2; padding, padlast)
            $R(span::Span, data1::V, data2::V, weights::W; padding=nopadding, padlast=false) where {T,V<:AbstractVector{$T1},W<:AbstractWeights} =
                rolling($F, span, data1, data2, weights, weights; padding, padlast)
            $R(span::Span, data1::V, data2::V, weights1::W, weights2::W; padding=nopadding, padlast=false) where {T,V<:AbstractVector{$T1},W<:AbstractWeights} =
                rolling($F, span, data1, data2, weights1, weights2; padding, padlast)
        end
    end
end


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
