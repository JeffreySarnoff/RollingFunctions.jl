module RollingFunctions

export roll_minimum, roll_maximum, roll_median, roll_mean, 
       roll_std, roll_var, roll_mad,
       roll_minimum_filled, roll_maximum_filled, roll_median_filled, roll_mean_filled, 
       roll_std_filled, roll_var_filled, roll_mad_filled,
       roll_minimum_tapered, roll_maximum_tapered, roll_median_tapered, roll_mean_tapered, 
       roll_std_tapered, roll_var_tapered, roll_mad_tapered
       
using StatsBase

const FromFirst = :FromFirst
const FromLast  = :FromLast
const FromBoth  = :FromBoth

include("rolling.jl")
include("running.jl")

end # module
