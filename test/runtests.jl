using RollingFunctions
using Statistics
using StatsBase
using LinearAlgebra
using Test

datavec = collect(1.0f0:5.0f0)
weighting = normalize([1.0f0, 2.0f0, 4.0f0])

windowsize = 3

@test rollmean(datavec, windowsize) == Float32[2.0, 3.0, 4.0]

expected = [1.236568f0, 1.7457432f0, 2.254918f0]
obtained = rollmean(datavec, windowsize, weighting)
@test Float32(eps(Float64)) > abs(sum(expected .- obtained))

expected = [1.8171206f0, 2.884499f0, 3.9148676f0]
obtained = rolling(geomean, datavec, 3)
@test Float32(eps(Float64)) > abs(sum(expected .- obtained))

expected = [1.0f0, 0.8944271f0, 0.7930564f0, 1.2588986f0, 1.7085882f0]
obtained = running(geomean, datavec, 3, weighting)
@test Float32(eps(Float64)) > abs(sum(expected .- obtained))

data1=[1,2,3,4,5,6,7];data2=[1,4,6,16,25,36,49];
weighting = normalize([1.0, 2.0, 1.0, 2.0]);

expected = [2.5, 6.0, 9.5, 10.0, 12.0]
obtained = rolling(cov, data1, data2, 3)
@test eps(Float32) > abs(sum(expected .- obtained))

expected = [0.9751641759537001, 0.9283031155706918, 0.9749534026403799, 0.9732162133211492]
obtained = rollcor(data1, data2, 4, weighting)
@test eps(Float32) > abs(sum(expected .- obtained))

expected = [0.0, 1.5, 2.5, 7.833333333333333, 15.0, 20.75, 26.5]
obtained = runcov(data1, data2, 5)
@test eps(Float32) > abs(sum(expected .- obtained))

data = [1.0, 2.0, missing, 4.0, 5.0]
expected = [3.0, missing, missing, 9.0]
@test all(rolling(sum, data, 2) .=== expected)

a = [1,2,missing,4,5,6]; b=[1,2,3,4,5,6];
expected = [0.5, missing, missing, 0.5, 0.5]
@test all(rolling(cov, a, b, 2) .=== expected)
@test all(rolling(cov, b, a, 2) .=== expected)
