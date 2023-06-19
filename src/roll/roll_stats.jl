for (R, F) in ((:rollmin, :vminimum), (:rollmax, :vmaximum),
    (:rollextrema, :vextrema),
    (:rollmean, :vmean), (:rollsum, :vsum),
    (:rollvar, :vvar), (:rollstd, :vstd))
    @eval begin
        $R(width::Integer, data; padding=nopadding, atend=false) =
            rolling(VectorizedStatistics.$F, width, data; padding, atend)
        $R(width::Integer, data, weights; padding=nopadding, atend=false) =
            rolling(VectorizedStatistics.$F, width, data, weights; padding, atend)
    end
end

for (R, F) in ((:rollcor, :vcor), (:rollcov, :vcov))
    @eval begin
        $R(width::Integer, data1, data2; padding=nopadding, atend=false) =
            rolling(VectorizedStatistics.$F, width, data1, data2; padding, atend)
        $R(width::Integer, data1, data2, weights; padding=nopadding, atend=false) =
            rolling(VectorizedStatistics.$F, width, data1, data2, weights, weights; padding, atend)
        $R(width::Integer, data1, data2, weights1, weights2; padding=nopadding, atend=false) =
            rolling(VectorizedStatistics.$F, width, data1, data2, weights1, weights2; padding, atend)
    end
end
