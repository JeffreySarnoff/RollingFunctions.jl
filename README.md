# RollingFunctions.jl

### Roll a function over data or run a function along data.

#### Copyright © 2017 by Jeffrey Sarnoff.  Released under the MIT License.

-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl)   (Julia v0.6)

-----

### exports

* windowed functions

rollstd, rollvar, rollmad,    
rollmedian, rollmode, rollmean,     
rollminimum, rollmaximum, rollspan,         
AtFirst, AtLast, AtCenter             # how to fill, if filling is desired

* windowed function construction tools

Roller, runner, rolling, 
rolling_fill_first, rolling_fill_last, rolling_fill_center

### use

This example shows how you may create other running functions.

```julia
using StatsBase
using RollingFunctions

rollgeomean{T<:Number}(n::Int, data::Vector{T}) =
    runner(Roller(rolling, geomean), n, data)
    
rollgeomean{T<:Number}(::Type{AtFirst}, n::Int, data::Vector{T})  =
    runner(Roller(rolling_fill_first, geoman), n, data)
rollgeomean{T<:Number}(::Type{AtLast}, n::Int, data::Vector{T})   =
    runner(Roller(rolling_fill_last, geomean), n, data)
rollgeomean{T<:Number}(::Type{AtCenter}, n::Int, data::Vector{T}) =
   runner(Roller(rolling_fill_center, geomean), n, data)

data = map(float,[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]);

rollgeomean(5, data)
rollgeomean(AtFirst, 5, data)

```


