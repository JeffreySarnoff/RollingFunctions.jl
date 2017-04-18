using RollingFunctions
using Base.Test

fdata = [1.0, 3.0, 5.0, 8.0,  6.0, 9.0]

@test rolling(mean, 4, fdata)  ==  [4.25, 5.5, 7.0]
@test rolling(mean, 3, fdata)  ==  [3.0, 5.333333333333333, 6.333333333333333, 7.666666666666667]

@test rolling_mean(FILL_FIRST, 4, fdata) == [4.25, 4.25, 4.25, 4.25, 5.5, 7.0]
@test rolling_mean(FILL_LAST, 4, fdata) == [4.25, 5.5, 7.0, 7.0, 7.0, 7.0]
@test string(rolling_mean(FILL_FIRST, 4, NaN, fdata)) == string([NaN, NaN, NaN, 4.25, 5.5, 7.0])
@test string(rolling_mean(FILL_LAST, 4, NaN, fdata)) == string([4.25, 5.5, 7.0, NaN, NaN, NaN])

@test rolling_mean(TAPER_FIRST, 4, 3, fdata) == [3.0, 3.0, 3.0, 4.25, 5.5, 7.0]
@test rolling_mean(TAPER_FIRST, 4, 2, fdata) == [2.0, 2.0, 3.0, 4.25, 5.5, 7.0]
@test rolling_mean(TAPER_LAST, 4, 3, fdata) == [4.25, 5.5, 7.0, 7.666666666666667, 7.666666666666667, 7.666666666666667]
@test rolling_mean(TAPER_LAST, 4, 2, fdata) == [4.25, 5.5, 7.0, 7.666666666666667, 7.5, 7.5]
