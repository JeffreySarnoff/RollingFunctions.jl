using Statistics, StatsBase, RollingFunctions
using Test

datavec = collect(1.0f0:5.0f0)
weights = normalize([1.0f0, 2.0f0, 4.0f0])

windowsize = 3

@test rollmean(datavec, windowsize) == Float32[2.0, 3.0, 4.0]

expected = [1.236568f0, 1.7457432f0, 2.254918f0]
obtained = rollmean(datavec, windowsize, weights)
@test Float32(eps(Float64)) > abs(sum(expected .- obtained))

expected = [1.8171206f0, 2.884499f0, 3.9148676f0]
obtained = rolling(geomean, datavec, 3)
@test Float32(eps(Float64)) > abs(sum(expected .- obtained))

expected = [1.0f0, 0.8944271f0, 0.7930564f0, 1.2588986f0, 1.7085882f0]
obtained = running(geomean, datavec, 3, weights)
@test Float32(eps(Float64)) > abs(sum(expected .- obtained))
