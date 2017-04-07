# RollingFunctions.jl

### Roll a function over data or run a function along data.

#### Copyright © 2017 by Jeffrey Sarnoff.  Released under the MIT License.

-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl)   (Julia v0.6)

-----

### exports

*windowed functions yeilding vectors of length(input)-window_size* 

runminimum, runmaximum, runspan,     
runmedian, runmode, runmean,     
runstd, runvar, runmad    

*windowed functions extended to the length of the input*

runminimum_backfill, runmaximum_backfill, runspan_backfill,     
runmedian_backfill, runmode_backfill, runmean_backfill,     
runstd_backfill, runvar_backfill, runmad_backfill

*and functions that allow you to make your own*    

Roller, runner, rolling, rolling_backfill, rolling_forwardfill, rolling_centerfill

### use

This example shows how you may create other running functions.

```julia
using RollingFunctions

running_norm(n,data) = runner(rolling_backfill(norm,n), data)

data = map(float,[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]);

result = running_norm(5, data)
```


