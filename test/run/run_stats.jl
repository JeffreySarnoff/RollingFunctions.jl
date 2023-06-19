datavec = collect(1.0f0:5.0f0)
weighting = AnalyticWeights(normalize([1.0f0, 2.0f0, 4.0f0]))
windowsize = 3

expected = Float32[1.0, 1.5, 2.0, 3.0, 4.0]
@test isapprox(runmean(windowsize, datavec), expected)

obtained = running(mean, 3, datavec)
@test isapprox(obtained, expected)

expected = [1.236568f0, 1.7457432f0, 2.254918f0]
obtained = runmean(windowsize, datavec, weighting)
@test Float32(eps(Float32)) > abs(sum(expected .- obtained))

@test isapprox(runmin(windowsize, datavec), running(minimum, windowsize, datavec))

data1=[1,2,3,4,5,6,7];data2=[1,4,6,16,25,36,49];
weighting = AnalyticWeights(normalize([1.0, 2.0, 1.0, 2.0]));

expected = [NaN, 1.5, 2.5, 6.0, 9.5, 10.0, 12.0]
obtained = running(cov, 3, data1, data2)
@test isapprox(filter(!isnan,obtained), filter(!isnan,expected))

#=
        FIXME       FIXME

weighting = AnalyticWeights(normalize([1.0f0, 2.0f0, 4.0f0, 5.0f0]))

expected = Float32[NaN, 1.5, 2.5, 7.83333, 12.1667, 16.5, 18.3333]
obtained = map(Float32, runcor(4, data1, data2, weighting))
@test eps(Float32) > abs(sum(expected .- obtained))

expected = [15.0, 20.75, 26.5]
obtained = runcov(5, data1, data2, weighting ,weighting)
@test eps(Float32) > abs(sum(expected .- obtained))

=#