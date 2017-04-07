using RollingFunctions
using Base.Test

fdata = [1.0, 3.0, 5.0, 8.0,  6.0, 9.0]

@test rollmean(4, fdata)  ==  [4.25, 5.5, 7.0]
@test rollmean(3, fdata)  ==  [3.0, 5.333333333333333, 6.333333333333333, 7.666666666666667]
@test rollmean_backfill(4, fdata)  ==  [4.25, 4.25, 4.25, 4.25, 5.5, 7.0]
@test rollmean_backfill(3, fdata)  ==  [3.0, 3.0, 3.0, 5.333333333333333, 6.333333333333333, 7.666666666666667]
