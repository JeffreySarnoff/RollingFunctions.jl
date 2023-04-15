for T1 in (:T, :(Union{Missing,T}))
    for (R, F) in ((:tilemin, :vminimum), (:tilemax, :vmaximum),
        (:tilemean, :vmean), (:tilesum, :vsum),
        (:tilevar, :vvar), (:tilestd, :vstd))
        @eval begin
            $R(span::Span, data::V; padding=nopadding, padlast=false) where {T, V<:AbstractVector{$T1}} =
                tiling($F, span, data; padding, padlast)
            $R(span::Span, data::V, weights::W; padding=nopadding, padlast=false) where {T, V<:AbstractVector{$T1}, W<:AbstractWeights} =
                tiling($F, span, data, weights; padding, padlast)
        end
    end
end

for T1 in (:T, :(Union{Missing,T}))
    for (R, F) in ((:tilecor, :vcor), (:tilecov, :vcov))
        @eval begin
            $R(span::Span, data1::V, data2::V; padding=nopadding, padlast=false) where {T,V<:AbstractVector{$T1}} =
                tiling($F, span, data1, data2; padding, padlast)
            $R(span::Span, data1::V, data2::V, weights::W; padding=nopadding, padlast=false) where {T,V<:AbstractVector{$T1},W<:AbstractWeights} =
                tiling($F, span, data1, data2, weights, weights; padding, padlast)
            $R(span::Span, data1::V, data2::V, weights1::W, weights2::W; padding=nopadding, padlast=false) where {T,V<:AbstractVector{$T1},W<:AbstractWeights} =
                tiling($F, span, data1, data2, weights1, weights2; padding, padlast)
        end
    end
end
