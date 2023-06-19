datavec = collect(1.0f0:5.0f0)
weighting = AnalyticWeights(normalize([1.0f0, 2.0f0, 4.0f0]))

windowsize = 3

@test tilemean(windowsize, datavec) == [2.0f0]
@test tilemean(windowsize, datavec; padding=0.0f0) == [0.0f0, 2.0f0]
@test tilemean(windowsize, datavec; padding=0.0f0, atend=true) == [2.0f0, 0.0f0]

@test tilemean(windowsize, datavec, weighting) == [1.236568f0]
@test tilemean(windowsize, datavec, weighting; padding=0.0f0) == [0.0f0, 1.236568f0]
@test tilemean(windowsize, datavec, weighting; padding=0.0f0, atend=true) == [1.236568f0, 0.0f0]


data1 = Float32[1,2,3,4,5,6,7]; data2 = Float32[1,4,6,16,25,36,49];
weighting = AnalyticWeights(normalize(Float32[1.0, 2.0, 4.0]));

expected = [2.5f0, 10.0f0]
obtained = tiling(cov, windowsize, data1, data2)
@test isapprox(obtained, expected)
obtained = tilecov(windowsize, data1, data2)
@test isapprox(obtained, expected)

expected = [0.9994065f0, 0.9993029f0]
obtained = tilecor(windowsize, data1, data2, weighting)
@test isapprox(expected, obtained; rtol=eps(1.0))
obtained = tilecor(windowsize, data1, data2, weighting, weighting)
@test isapprox(expected, obtained; rtol=eps(1.0))

