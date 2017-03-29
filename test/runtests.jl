using RollingFunctions
using Base.Test

fdata = [1.0, 3.0, 5.0, 8.0,  21.0, 34.0]

@test rolling(mean, 4, fdata)       == [1.00, 3.00,  5.0,  4.25,  9.25, 17.00]
@test rolling_first(mean, 4, fdata) == [4.25, 9.25, 17.0,  8.00, 21.00, 34.00] 
@test rolling_final(mean, 4, fdata) == [1.00, 3.00,  5.0,  4.25,  9.25, 17.00]
@test rolling_start(mean, 4, fdata) == [4.25, 9.25, 17.0, 21.00, 27.50, 34.00]
@test rolling_start(mean, 4, fdata) == [1.00, 2.00,  3.0,  4.25,  9.25, 17.00]




