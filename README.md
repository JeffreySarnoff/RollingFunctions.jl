# RollingFunctions.jl

### Roll a function over data, run a statistic along a [weighted] data window.

#### Copyright © 2017-2018 by Jeffrey Sarnoff.  Released under the MIT License.

-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl)
-----

### works with unweighted data
- data that is a simple vector
- data that is a CartesianIndexed vector

### works with weights
- weights given as a simple vector
- weights given as a kind of StatsBase.AbstractWeights

### works with prewrapped functions
- rollmin, rollmax, rollmean, rollmedian
- rollvar, rollstd, rollsem, rollmad, rollvariation

### works with your functions
- rolling(function, data, windowsize)
- rolling(function, data, windowsize, weights)

### examples of use
- with a simple vector
- with a DataFrame column
- with a TimeSeries column
- with your own function

---------

## Rolling

## Rolling a function over windowed data

With `ndata = length(data)` the result of rolling a function over the data will be a vector of length `ndata - windowsize + 1`.  So there will be obtained `windowsize - 1` fewer values than there are data values. All exported functions named with the prefix `roll` behave this way.

```julia
julia> data = collect(1.0:5.0); print(data)
[1.0, 2.0, 3.0, 4.0, 5.0]
julia> windowsize = 3
3
julia> rollmean(data, windowsize)
3-element Array{Float64,1}:
 2.0
 3.0
 4.0
```

## Running a function over windowed data

To obtain the same number of output data values as are given, the initial `windowsize - 1` values output must be generated outside of the rolling behavior.  This is accomplished by tapering the needed values -- using the same function that is rolled on successively smaller window sizes.  All exported functions named with the prefix `run` behave this way.

```julia
julia> data = collect(1.0:5.0); print(data)
[1.0, 2.0, 3.0, 4.0, 5.0]
julia> windowsize = 3
3
julia> runmean(data, windowsize)
5-element Array{Float64,1}:
 1.0
 1.5
 2.0
 3.0
 4.0
```

## Tapering

When rolling a window over a finite data sequence, one may prefer
to obtain a result that incorporates just as many elements as has
the source sequence.  The trailing (earliest) values are not fully
coverable by the window's span.  Tapering is one way to accomodate
this situation.  A tapered roll starts with zero or more prepared
values and grows the window from spanning very few to approaching
the analytic span.  The final tapered value uses a window that is
reduced in coverage by one element. The penultimate tapered value
uses a window that is reduced in coverage by two elements, and so.

We support using prepared values to _prime the rolling evaluation_.
Alternatively, one may just copy over the first few (earliest)
observations and begin growing the taper from those values.

```julia
using RollingFunctions, StatsBase
# and any of these or others as you may select:
# CSV, DataFrames, IndexedTables, JuliaDB, TimeSeries 
data = vector_from_datasource( datasource )

rollingfun = geomean
windowspan = 200
num2prep   = 15

taperprep  = [median(data[1:idx]) for idx=1:num2prep]

taper = tapering(rollingfun, data[1:windowspan-1], taperprep)
```
To copy over the first observations and let them serve as the taperprep
```julia
using RollingFunctions, StatsBase
data = vector_from_datasource( datasource )

rollingfun = geomean
windowspan = 200
num2copy   = 15

taper = tapering(rollingfun, data[1:windowspan-1], num2copy)
```
