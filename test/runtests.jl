using RollingFunctions
using Base.Test

idata = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43]
fdata = [1.0, 1.0, 2.0, 3.0, 5.0, 8.0, 13.0, 21.0, 34.0, 55.0]

@test rolling(mean, 4, fdata) == [1.0,  1.0,  2.0, 1.75, 2.75, 4.5, 7.25, 11.75, 19.0, 30.75]
@test rolling(median, 6, idata) ==  [2, 3, 5, 7, 11, 6, 9, 12, 15, 18, 21, 26, 30, 34]
