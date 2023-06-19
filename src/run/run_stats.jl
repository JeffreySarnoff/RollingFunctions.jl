for (R, F) in ( (:runmin, :vminimum), (:runmax, :vmaximum),
                (:runextrema, :vextrema),
                (:runmean, :vmean), (:runsum, :vsum),
                (:runvar, :vvar), (:runstd, :vstd) )
    @eval begin
        $R(width::Integer, data) =
            running(VectorizedStatistics.$F, width, data)
        $R(width::Integer, data, weights) =
            running(VectorizedStatistics.$F, width, data, weights)
    end
end

for (R, F) in ((:runcor, :vcor), (:runcov, :vcov))
    @eval begin
        $R(width::Integer, data1, data2) =
            running(VectorizedStatistics.$F, width, data1, data2)
        $R(width::Integer, data1, data2, weights) =
            running(VectorizedStatistics.$F, width, data1, data2, weights, weights)
        $R(width::Integer, data1, data2, weights1, weights2) =
            running(VectorizedStatistics.$F, width, data1, data2, weights1, weights2)
    end
end
