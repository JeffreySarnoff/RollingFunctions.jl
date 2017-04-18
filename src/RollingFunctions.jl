module RollingFunctions

export roll_minimum, roll_maximum, roll_mean, 
       roll_std, roll_var, roll_mad,
       roll_minimum_filled, roll_maximum_filled, roll_mean_filled, 
       roll_std_filled, roll_var_filled, roll_mad_filled,
       roll_minimum_tapered, roll_maximum_tapered, roll_mean_tapered,
       rolling, rolling_fill_first, rolling_fill_last, rolling_taper_first, rolling_taper_last,
       FILL_FIRST, FILL_LAST, FILL_BOTH
       
using StatsBase

const FILL_FIRST = :FILL_FIRST
const FILL_LAST  = :FILL_LAST
const FILL_BOTH  = :FILL_BOTH

include("rolling.jl")
include("running.jl")

end # module
