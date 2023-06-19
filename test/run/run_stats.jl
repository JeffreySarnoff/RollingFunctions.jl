datavec = collect(1.0f0:5.0f0)
data1 = Float32[1, 2, 3, 4, 5, 6, 7]
data2 = Float32[1, 4, 6, 16, 25, 36, 49]
weighting = AnalyticWeights(normalize([1.0f0, 2.0f0, 4.0f0]))
windowsize = 3

expected = Float32[1.0, 1.5, 2.0, 3.0, 4.0]
@test isapprox(runmean(windowsize, datavec), expected)

obtained = running(mean, 3, datavec)
@test isapprox(obtained, expected)

expected = [0.872872f0, 1.09109f0, 1.23657f0, 1.74574f0, 2.25492f0]
obtained = runmean(windowsize, datavec, weighting)
@test isapprox(expected, obtained)

@test isapprox(runmin(windowsize, datavec), running(minimum, windowsize, datavec))

expected = [NaN, 1.5, 2.5, 6.0, 9.5, 10.0, 12.0]
obtained = running(cov, 3, data1, data2)
@test isapprox(filter(!isnan,obtained), filter(!isnan,expected))

expected = Float32[3.1904764, 11.047618, 20.190474, 0.0, 0.0, 0.0, 0.0]
obtained = map(Float32, runcov(windowsize, data1, data2, weighting))
@test isapprox(obtained, expected)
obtained = map(Float32, running(VectorizedStatistics.vcov, windowsize, data1, data2, weighting))
@test isapprox(obtained, expected)
