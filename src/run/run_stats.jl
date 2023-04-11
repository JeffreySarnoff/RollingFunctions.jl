var1(x) = length(x) > 1 ? var(x) : 0.0
std1(x) = length(x) > 1 ? std(x) : 0.0
sem1(x) = length(x) > 1 ? sem(x) : 0.0
variation1(x) = length(x) > 1 ? variation(x) : 0.0
skewness1(x) = length(x) > 1 ? skewness(x) : 1.0
kurtosis1(x) = length(x) > 1 ? kurtosis(x) : -1.0

for T1 in (:T, :(Union{Missing,T}))
    for (R,F) in ((:runmin, :minimum), (:runmax, :maximum),
                  (:runmean, :mean), (:runmedian, :median), 
                  (:runvar, :var1), (:runstd, :std1),
                  (:runskewness, :skewness1), (:runkurtosis, :kurtosis1),
                  (:runsem, :sem1), 
                  (:runmad, :mad_not_normalized),
                  (:runmad_normalized, :mad_normalized),
                  (:runvariation, :variation1))
        @eval begin
            $R(data::V, windowspan::Int) where {T, V<:AbstractVector{$T1}} =
                running($F, data, windowspan)
            $R(data::V, windowspan::Int, weighting::AbstractVector{S}) where {T, V<:AbstractVector{$T1}, S} =
                running($F, data, windowspan, weighting)
            $R(data::V, windowspan::Int, weighting::AbstractWeights) where {T, V<:AbstractVector{$T1}} =
                running($F, data, windowspan, weighting.values)
        end
    end
end



runcor(data1::V1, data2::V2, windowspan::Int) where {T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                         V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    running(cor, data1, data2, windowspan, 1)

runcov(data1::V1, data2::V2, windowspan::Int) where {T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                         V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    running(cov, data1, data2, windowspan, 0)

runcor(data1::V1, data2::V2, windowspan::Int, weighting::AbstractVector{S}) where {S, T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                                                         V2<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}} =
    running(cor, data1, data2, windowspan, weighting, 1)

runcov(data1::V1, data2::V2, windowspan::Int, weighting::AbstractVector{S}) where {S, T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                                                         V2<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}} =
    running(cov, data1, data2, windowspan, weighting, 0)

