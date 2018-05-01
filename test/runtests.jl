using StatsBase, RollingFunctions
using Test


data = [2.0, 5.0, 3.0, 2.0, 4.0, 5.0, 4.0]

@test rollmean(data, 5) == rolling(mean, data, 5)
@test runmax(data, 4) == rolling(maximum, data, 4)
