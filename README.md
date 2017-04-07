# RollingFunctions.jl

### Roll a function over data or run a function along data.

#### Copyright © 2017 by Jeffrey Sarnoff.  Released under the MIT License.

-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl)   (Julia v0.6)

-----

### exports

*windowed functions yeilding vectors of length(input)-window_size+1*     
*and windowed functions extended to the length of the input*    

rollstd, rollvar, rollmad,    
rollmedian, rollmode, rollmean,     
rollminimum, rollmaximum, rollspan,         
# how to fill, if filling is desired
AtFirst, AtLast, AtBoth

*and functions that allow you to make your own*    

Roller, runner, rolling, 
rolling_backfill, rolling_forwardfill, rolling_centerfill

### use

This example shows how you may create other running functions.

```julia
using StatsBase
using RollingFunctions

rollgeomean{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling, geomean), n, data)
rollgeomean_backfill{T<:Number}(n::Int, data::Vector{T}) = runner(Roller(rolling_backfill, geomean), n, data)


data = map(float,[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]);

rollgeomean(5, data)
rollgeomean_backfill(5, data)

```


