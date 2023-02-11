using RollingFunctions
using Statistics
using StatsBase
using LinearAlgebra
using Test

include("rollvectors.jl")
include("rollvectors_weighted.jl")

#=
datavec = collect(1.0f0:5.0f0)
weighting = normalize([1.0f0, 2.0f0, 4.0f0])

windowsize = 3

@test rollmean(datavec, windowsize) == Float32[2.0, 3.0, 4.0]

expected = [2.0f0, 3.0f0, 4.0f0]
obtained = rolling(mean, datavec, 3)
@test Float32(eps(Float64)) > abs(sum(expected .- obtained))

expected = [1.236568f0, 1.7457432f0, 2.254918f0]
obtained = rollmean(datavec, windowsize, weighting)
@test Float32(eps(Float32)) > abs(sum(expected .- obtained))

expected = [1.0f0, 1.1180339f0, 1.236568f0, 1.7457432f0, 2.254918f0]
obtained = running(mean, datavec, 3, weighting)
@test Float32(eps(Float32)) > abs(sum(expected .- obtained))

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
=#

