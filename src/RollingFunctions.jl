module RollingFunctions

export roll_minimum, roll_maximum, roll_mean, 
       roll_std, roll_var, roll_mad,
       roll_std_filled, roll_var_filled, roll_mad_filled,
       roll_minimum_tapered, roll_maximum_tapered, roll_mean_tapered, 
       # these are used to make other roll_ functions
       rolling, rolling_fill_first, rolling_fill_last, rolling_taper_first, rolling_taper_last
       
using StatsBase

const FIRST = :FIRST
const LAST  = :LAST
const BOTH  = :BOTH

include("rolling.jl")
include("running.jl")

end # module
