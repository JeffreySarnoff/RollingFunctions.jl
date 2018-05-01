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

### examples of use
- with a simple vector
- with a DataFrame column
- with a TimeSeries column
- with your own function

---------

## Rolling a function over data

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

## Running a function over data

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

### works with prewrapped functions
- rollmin, rollmax, rollmean, rollmedian
- rollvar, rollstd, rollsem, rollmad, rollvariation
- runmin, runmax, runmean, runmedian
- runvar, runstd, runsem, runmad, runvariation

### works with your functions
- rolling(function, data, windowsize)
- rolling(function, data, windowsize, weights)
- running(function, data, windowsize)

### also exports
- LinearAlgebra.normalize
- StatsBase: AbstractWeights, Weights
- StatsBase: FrequencyWeights, AnalyticWeights, ProbabilityWeights
