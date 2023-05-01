for T1 in (:T, :(Union{Missing,T}))
    for (R, F) in ((:tilemin, :vminimum), (:tilemax, :vmaximum),
        (:tilemean, :vmean), (:tilesum, :vsum),
        (:tilevar, :vvar), (:tilestd, :vstd))
        @eval begin
            $R(width::Span, data::V; padding=nopadding, padlast=false) where {T, V<:AbstractVector{$T1}} =
                tiling($F, width, data; padding, padlast)
            $R(width::Span, data::V, weights::W; padding=nopadding, padlast=false) where {T, V<:AbstractVector{$T1}, W<:AbstractWeights} =
                tiling($F, width, data, weights; padding, padlast)
        end
    end
end

for T1 in (:T, :(Union{Missing,T}))
    for (R, F) in ((:tilecor, :vcor), (:tilecov, :vcov))
        @eval begin
            $R(width::Span, data1::V, data2::V; padding=nopadding, padlast=false) where {T,V<:AbstractVector{$T1}} =
                tiling($F, width, data1, data2; padding, padlast)
            $R(width::Span, data1::V, data2::V, weights::W; padding=nopadding, padlast=false) where {T,V<:AbstractVector{$T1},W<:AbstractWeights} =
                tiling($F, width, data1, data2, weights, weights; padding, padlast)
            $R(width::Span, data1::V, data2::V, weights1::W, weights2::W; padding=nopadding, padlast=false) where {T,V<:AbstractVector{$T1},W<:AbstractWeights} =
                tiling($F, width, data1, data2, weights1, weights2; padding, padlast)
        end
    end
end
