for (R, F) in ( (:runmin, :vminimum), (:runmax, :vmaximum),
                (:runextrema, :vextrema),
                (:runmean, :vmean), (:runmedian, :vmedian),
                (:runsum, :vsum),
                (:runvar, :vvar), (:runstd, :vstd) )
    @eval begin
        $R(width::Integer, data; padding= nopadding, atend=false) =
            running(VectorizedStatistics.$F, width, data; padding, atend)
        $R(width::Integer, data, weights; padding= nopadding, atend=false) =
            running(VectorizedStatistics.$F, width, data, weights; padding, atend)
    end
end

for (R, F) in ((:runskewness, :skewness), (:runkurtosis, :kurtosis))
    @eval begin
        function $R(width::Integer, data1; padding= nopadding, atend=false)
            running($F, width, data1; padding, atend)
        end
        function $R(width::Integer, data1, weights; padding= nopadding, atend= false)
            running($F, width, data1, weights; padding, atend)
        end
    end
end

for (R, F) in ((:runcor, :vcor), (:runcov, :vcov))
    @eval begin
        function $R(width::Integer, data1, data2; padding= nopadding, atend= false)
            running(VectorizedStatistics.$F, width, data1, data2; padding, atend)
        end
        function $R(width::Integer, data1, data2, weights; padding= nopadding, atend= false)
            running(VectorizedStatistics.$F, width, data1, data2, weights, weights; padding, atend)
        end
        function $R(width::Integer, data1, data2, weights1, weights2; padding= nopadding, atend= false)
            running(VectorizedStatistics.$F, width, data1, data2, weights1, weights2; padding, atend)
        end
    end
end
