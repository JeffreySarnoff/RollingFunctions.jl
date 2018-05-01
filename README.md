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

With `ndata = length(data)`, using a window of length `windowsize`, rolling a function results in a vector of `ndata - windowsize + 1` elements.  So there will be obtained `windowsize - 1` fewer values than there are data values. All exported functions named with the prefix `roll` behave this way.

```julia
julia> data = collect(1.0f0:5.0f0); print(data)
Float32[1.0, 2.0, 3.0, 4.0, 5.0]
julia> windowsize = 3;

julia> result = rollmean(data, windowsize); print(result)
Float32[2.0, 3.0, 4.0]
```
```julia
julia> weights = normalize([1.0f0, 2.0f0, 4.0f0])
3-element Array{Float32,1}:
 0.21821788
 0.43643576
 0.8728715 
 
julia> result = rollmean(data, windowsize, weights); print(result)
Float32[1.23657, 1.74574, 2.25492]
```

## Running a function over data

To obtain the same number of output data values as are given, the initial `windowsize - 1` values output must be generated outside of the rolling behavior.  This is accomplished by tapering the needed values -- using the same function, rolling it over successively smaller window sizes.  All exported functions named with the prefix `run` behave this way.

```julia
```julia
julia> data = collect(1.0f0:5.0f0); print(data)
Float32[1.0, 2.0, 3.0, 4.0, 5.0]
julia> windowsize = 3;

julia> result = runmean(data, windowsize); print(result)
Float32[1.0, 1.5, 2.0, 3.0, 4.0]
```
```julia
julia> weights = normalize([1.0f0, 2.0f0, 4.0f0]);
 
julia> result = runmean(data, windowsize, weights); print(result)
Float32[1.0, 1.11803, 1.23657, 1.74574, 2.25492]
```

### rolling stats
- rollmin, rollmax, rollmean, rollmedian
- rollvar, rollstd, rollsem, rollmad, rollmad_normalized
- rollskewness, rollkurtosis, rollvariation

### running stats
- runmin, runmax, runmean, runmedian
- runvar, runstd, runsem, runmad, runmad_normalized
- runskewness, runkurtosis, runvariation

Some of these use a limit value for running over vec of length 1.

### works with your functions
- rolling(function, data, windowsize)
- rolling(function, data, windowsize, weights)
- running(function, data, windowsize)

### also exports
- LinearAlgebra.normalize
- StatsBase: AbstractWeights, Weights
- StatsBase: FrequencyWeights, AnalyticWeights, ProbabilityWeights
