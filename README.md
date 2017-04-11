# RollingFunctions.jl

### Roll a function over data or run a function along data.

#### Copyright © 2017 by Jeffrey Sarnoff.  Released under the MIT License.

-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl)   (Julia v0.6)

-----

### exports

#### windowed functions

rollstd, rollvar, rollmad,    
rollmedian, rollmode, rollmean,     
rollminimum, rollmaximum, rollspan,         
FillFirst, FillLast, FillCenter        # how to fill, if filling is desired

#### windowed function construction tools

Roller, runner, rolling, 
rolling_fill_first, rolling_fill_last, rolling_fill_center

### use

This example shows how you may create other running functions.

```julia
import StatsBase: middle
using RollingFunctions

rollmiddle{T<:Number}(n::Int, data::Vector{T}) =
    runner(Roller(rolling, middle), n, data)
    
rollmiddle{T<:Number}(::Type{FillFirst}, n::Int, data::Vector{T})  =
    runner(Roller(rolling_fill_first, middle), n, data)

rollmiddle{T<:Number}(::Type{FillLast}, n::Int, data::Vector{T})  =
    runner(Roller(rolling_fill_last, middle), n, data)
    
rollmiddle{T<:Number}(::Type{FillCenter}, n::Int, data::Vector{T})  =
    runner(Roller(rolling_fill_center, middle), n, data)


data = [ 1.0, 3.0, 5.0, 7.0, 11.0, 15.0 ];

rollmiddle(3, data)               #           [ 3.0,  5.0,  8.0,  11.0 ]
rollmiddle(AtFirst,  3, data)     # [ 3.0, 3.0, 3.0,  5.0,  8.0,  11.0 ]
rollmiddle(AtLast,   3, data)     #           [ 3.0,  5.0,  8.0,  11.0, 11.0, 11.0 ]
rollmiddle(AtCenter, 3, data)     #      [ 3.0, 4.0,  5.5,  8.0,   9.5, 11.0 ]

```


