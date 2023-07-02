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
        function $R(width::Integer, data1, data2; padding = zero(eltype(data1)))
            result = running(VectorizedStatistics.$F, width, data1, data2)
            if padding != nopadding
                result[1] = padding
            end
            result
        end
        function $R(width::Integer, data1, data2, weights; padding = zero(eltype(data1)))
            result = running(VectorizedStatistics.$F, width, data1, data2, weights, weights)
            if padding != nopadding
                result[1] = padding
            end
            result
        end
        function $R(width::Integer, data1, data2, weights1, weights2) =
            result = running(VectorizedStatistics.$F, width, data1, data2, weights1, weights2)
            if padding != nopadding
                result[1] = padding
            end
            result
        end
    end
end
