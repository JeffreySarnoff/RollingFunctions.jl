datavec = collect(1.0f0:5.0f0)
weighting = AnalyticWeights(normalize([1.0f0, 2.0f0, 4.0f0]))

windowsize = 3

@test tilemean(windowsize, datavec) == [2.0f0]
@test tilemean(windowsize, datavec; padding=missing) == [missing, 2.0f0]
@test tilemean(windowsize, datavec; padding=missing, atend=true) == [2.0f0, missing]

@test tilemean(windowsize, datavec, weighting) == [1.236568f0]
@test tilemean(windowsize, datavec, weighting; padding=0.0f0) == [0.0f0, 1.236568f0]
@test tilemean(windowsize, datavec, weighting; padding=0.0f0, atend=true) == [1.236568f0, 0.0f0]


data1=[1,2,3,4,5,6,7];data2=[1,4,6,16,25,36,49];
weighting = AnalyticWeights(normalize([1.0, 2.0, 1.0, 2.0]));

expected = [2.5, 6.0, 9.5, 10.0, 12.0]
obtained = tiling(cov, 3, data1, data2)
@test eps(Float32) > abs(sum(expected .- obtained))

expected = [0.9751641759537001, 0.9283031155706918, 0.9749534026403799, 0.9732162133211492]
obtained = tilecor(4, data1, data2, weighting)
@test eps(Float32) > abs(sum(expected .- obtained))

expected = [15.0, 20.75, 26.5]
obtained = tilecov(5, data1, data2)
@test eps(Float32) > abs(sum(expected .- obtained))

