for T1 in (:T, :(Union{Missing,T}))
    for (R, F) in ((:tilemin, :vminimum), (:tilemax, :vmaximum),
        (:tileextrema, :vextrema),
        (:tilemean, :vmean), (:tilesum, :vsum),
        (:tilevar, :vvar), (:tilestd, :vstd))
        @eval begin
            $R(width::Integer, data::V; padding=nopadding, atend=false) where {T, V<:AbstractVector{$T1}} =
                tiling($F, width, data; padding, atend)
            $R(width::Integer, data::V, weights::W; padding=nopadding, atend=false) where {T, V<:AbstractVector{$T1}, W<:AbstractWeights} =
                tiling($F, width, data, weights; padding, atend)
        end
    end
end

for T1 in (:T, :(Union{Missing,T}))
    for (R, F) in ((:tilecor, :vcor), (:tilecov, :vcov))
        @eval begin
            $R(width::Integer, data1::V, data2::V; padding=nopadding, atend=false) where {T,V<:AbstractVector{$T1}} =
                tiling($F, width, data1, data2; padding, atend)
            $R(width::Integer, data1::V, data2::V, weights::W; padding=nopadding, atend=false) where {T,V<:AbstractVector{$T1},W<:AbstractWeights} =
                tiling($F, width, data1, data2, weights, weights; padding, atend)
            $R(width::Integer, data1::V, data2::V, weights1::W, weights2::W; padding=nopadding, atend=false) where {T,V<:AbstractVector{$T1},W<:AbstractWeights} =
                tiling($F, width, data1, data2, weights1, weights2; padding, atend)
        end
    end
end
