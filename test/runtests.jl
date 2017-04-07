using RollingFunctions
using Base.Test

#=
fdata = [1.0, 3.0, 5.0, 8.0,  21.0, 34.0]

@test rollmean(4, fdata)  == [1.00, 3.00,  5.0,  4.25,  9.25, 17.00]
@test rollmean_backfill(4, fdata) == [4.25, 9.25, 17.0,  8.00, 21.00, 34.00] 
=#

@test 1==1
