# RollingFunctions.jl

### Roll a function over data or run a function along data.

#### Copyright © 2017 by Jeffrey Sarnoff.  Released under the MIT License.

-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl)   (Julia v0.6)

-----

### exports

#### windowed functions

roll_minimum, roll_maximum, roll_mean,
roll_std, roll_var, roll_mad
#### versions that fill to the length of the data vector
roll_minimum_filled, roll_maximum_filled, roll_mean_filled,
roll_std_filled, roll_var_filled, roll_mad_filled
#### versions that taper the window to fill the length
roll_minimum_tapered, roll_maximum_tapered, roll_mean_tapered

#### how to fill, if desired
FillFirst, FillLast, FillCenter

#### windowed function construction tools
rolling, 
rolling_fill_first, rolling_fill_last, rolling_fill_both,
rolling_taper_first, rolling_taper_last, rolling_taper_both


### use

This example shows how you may create other running functions.

```julia
import StatsBase: middle
using RollingFunctions

roll_middle{T<:Real}(window_size::Int, data::Vector{T}) =
    rolling(middle, window_size, data)
    
roll_middle_filled{T<:Real}(window_size::Int, data::Vector{T})  =
    rolling_fill_first(middle, window_size, data)

roll_middle_filled{T<:Real}(window_size::Int, filler::T, data::Vector{T})  =
    rolling_fill_first(middle, window_size, filler, data)

roll_middle_tapered{T<:Real}(window_size::Int, data::Vector{T})  =
    rolling_taper_first(middle, window_size, data)
    
function roll_middle_taper{T<:Real}(::Type{FillCenter}, n::Int, data::Vector{T}; fillfirst::Bool=true)
    if fillfirst
       rolling_taper_first(middle, window_size, data)
    else
       rolling_taper_last(middle, window_size, data)
    end
end


data = [ 1.0, 3.0, 5.0, 7.0, 11.0, 15.0 ];

rollmiddle(3, data)               #           [ 3.0,  5.0,  8.0,  11.0 ]
rollmiddle(AtFirst,  3, data)     # [ 3.0, 3.0, 3.0,  5.0,  8.0,  11.0 ]
rollmiddle(AtLast,   3, data)     #           [ 3.0,  5.0,  8.0,  11.0, 11.0, 11.0 ]
rollmiddle(AtCenter, 3, data)     #      [ 3.0, 4.0,  5.5,  8.0,   9.5, 11.0 ]

```


