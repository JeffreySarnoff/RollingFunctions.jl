windowsize = 3
@test runmean(windowsize, datavec) == Float32[2.0, 3.0, 4.0]
#=
julia> runmean(windowsize, datavec)
ERROR: MethodError: no method matching running(::typeof(VectorizedStatistics.vmean), ::Int64, ::Vector{Float32}; padding::RollingFunctions.NoPadding, atend::Bool)
=#

expected = [2.0f0, 3.0f0, 4.0f0]
obtained = running(mean, 3, datavec)
@test Float32(eps(Float64)) > abs(sum(expected .- obtained))

expected = [1.236568f0, 1.7457432f0, 2.254918f0]
obtained = runmean(windowsize, datavec, weighting)
@test Float32(eps(Float32)) > abs(sum(expected .- obtained))

expected = [1.236568f0, 1.7457432f0, 2.254918f0]
obtained = running(mean, 3, datavec, weighting)
@test Float32(eps(Float32)) > abs(sum(expected .- obtained))

data1=[1,2,3,4,5,6,7];data2=[1,4,6,16,25,36,49];
weighting = AnalyticWeights(normalize([1.0, 2.0, 1.0, 2.0]));

expected = [2.5, 6.0, 9.5, 10.0, 12.0]
obtained = running(cov, 3, data1, data2)
@test eps(Float32) > abs(sum(expected .- obtained))

expected = [0.9751641759537001, 0.9283031155706918, 0.9749534026403799, 0.9732162133211492]
obtained = runcor(4, data1, data2, weighting)
@test eps(Float32) > abs(sum(expected .- obtained))

expected = [15.0, 20.75, 26.5]
obtained = runlcov(5, data1, data2)
@test eps(Float32) > abs(sum(expected .- obtained))

