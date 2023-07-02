for (R, F) in ((:tilemin, :vminimum), (:tilemax, :vmaximum),
    (:tileextrema, :vextrema),
    (:tilemean, :vmean), (:tilemedian, :vmedian),
    (:tilesum, :vsum),
    (:tilevar, :vvar), (:tilestd, :vstd))
    @eval begin
        $R(width::Integer, data; padding= nopadding, atend= false) =
            tiling(VectorizedStatistics.$F, width, data; padding, atend)
        $R(width::Integer, data, weights; padding= nopadding, atend= false) =
            tiling(VectorizedStatistics.$F, width, data, weights; padding, atend)
    end
end

for (R, F) in ((:tileskewness, :skewness), (:tilekurtosis, :kurtosis))
    @eval begin
        function $R(width::Integer, data1; padding= nopadding, atend=false)
            tiling($F, width, data1; padding, atend)
        end
        function $R(width::Integer, data1, weights; padding= nopadding, atend= false)
            tiling($F, width, data1, weights; padding, atend)
        end
    end
end

for (R, F) in ((:tilecor, :vcor), (:tilecov, :vcov))
    @eval begin
        $R(width::Integer, data1, data2; padding=nopadding, atend=false) =
            tiling(VectorizedStatistics.$F, width, data1, data2; padding, atend)
        $R(width::Integer, data1, data2, weights; padding=nopadding, atend=false) =
            tiling(VectorizedStatistics.$F, width, data1, data2, weights, weights; padding, atend)
        $R(width::Integer, data1, data2, weights1, weights2; padding=nopadding, atend=false) =
            tiling(VectorizedStatistics.$F, width, data1, data2, weights1, weights2; padding, atend)
    end
end
