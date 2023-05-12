for T1 in (:T, :(Union{Missing,T}))
    for (R, F) in ((:runmin, :vminimum), (:runmax, :vmaximum),
        (:runmean, :vmean), (:runsum, :vsum),
        (:runvar, :vvar), (:runstd, :vstd))
        @eval begin
            $R(width::Width, data::V; padding=nopadding, atend=false) where {T, V<:AbstractVector{$T1}} =
                running($F, width, data; padding, atend)
            $R(width::Width, data::V, weights::W; padding=nopadding, atend=false) where {T, V<:AbstractVector{$T1}, W<:AbstractWeights} =
                running($F, width, data, weights; padding, atend)
        end
    end
end

for T1 in (:T, :(Union{Missing,T}))
    for (R, F) in ((:runcor, :vcor), (:runcov, :vcov))
        @eval begin
            $R(width::Width, data1::V, data2::V; padding=nopadding, atend=false) where {T,V<:AbstractVector{$T1}} =
                running($F, width, data1, data2; padding, atend)
            $R(width::Width, data1::V, data2::V, weights::W; padding=nopadding, atend=false) where {T,V<:AbstractVector{$T1},W<:AbstractWeights} =
                running($F, width, data1, data2, weights, weights; padding, atend)
            $R(width::Width, data1::V, data2::V, weights1::W, weights2::W; padding=nopadding, atend=false) where {T,V<:AbstractVector{$T1},W<:AbstractWeights} =
                running($F, width, data1, data2, weights1, weights2; padding, atend)
        end
    end
end

#=
mad_not_normalized(x) = mad(x, normalize=false)
mad_normalized(x) = mad(x, normalize=true)

for T1 in (:T, :(Union{Missing,T}))    
    for (R,F) in ((:runmin, :minimum), (:runmax, :maximum),
                  (:runmean, :mean), (:runmedian, :median), 
                  (:runvar, :var), (:runstd, :std),
                  (:runskewness, :skewness), (:runkurtosis, :kurtosis),
                  (:runsem, :sem), 
                  (:runmad, :mad_not_normalized),
                  (:runmad_normalized, :mad_normalized),
                  (:runvariation, :variation))
        @eval begin
            $R(data::V, windowwidth::Int) where {T, V<:AbstractVector{$T1}} =
                running($F, data, windowwidth)
            $R(data::V, windowwidth::Int, weighting::AbstractVector{S}) where {T, V<:AbstractVector{$T1}, S} =
                running($F, data, windowwidth, weighting)
            $R(data::V, windowwidth::Int, weighting::AbstractWeights) where {T, V<:AbstractVector{$T1}} =
                running($F, data, windowwidth, weighting.values)
        end
    end
end


runcor(data1::V1, data2::V2, windowwidth::Int) where {T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                         V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    running(cor, data1, data2, windowwidth)

runcov(data1::V1, data2::V2, windowwidth::Int) where {T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                         V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    running(cov, data1, data2, windowwidth)

runcor(data1::V1, data2::V2, windowwidth::Int, weighting::AbstractVector{S}) where {S, T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                                                          V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    running(cor, data1, data2, windowwidth, weighting)

runcov(data1::V1, data2::V2, windowwidth::Int, weighting::AbstractVector{S}) where {S, T, V1<:Union{AbstractVector{T}, AbstractVector{Union{Missing,T}}}, 
                                                                                          V2<:Union{AbstractVector{T},AbstractVector{Union{Missing,T}}}} =
    running(cov, data1, data2, windowwidth, weighting)
=#