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

With `ndata = length(data)`, using a window of length `windowsize`, rolling a function results in a vector of `ndata - windowsize + 1` elements.  So there will be obtained `windowsize - 1` fewer values than there are data values. All exported functions named with the prefix __`roll`__ behave this way.

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

To obtain the same number of output data values as are given, the initial `windowsize - 1` values output must be generated outside of the rolling behavior.  This is accomplished by tapering the needed values -- using the same function, rolling it over successively smaller window sizes.  All exported functions named with the prefix __`run`__ behave this way.

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
- `rollmin`, `rollmax`, `rollmean`, `rollmedian`
- `rollvar`, `rollstd`, `rollsem`, `rollmad`, `rollmad_normalized`
- `rollskewness`, `rollkurtosis`, `rollvariation`
- `rollcor`, `rollcov` (over two data vectors)

### running stats
- `runmin`, `runmax`, `runmean`, `runmedian`
- `runvar`, `runstd`, `runsem`, `runmad`, `runmad_normalized`
- `runskewness`, `runkurtosis`, `runvariation`
- `runcor`, `runcov` (over two data vectors)

Some of these use a limit value for running over vec of length 1.

### works with your functions
- `rolling(function, data, windowsize)`
- `rolling(function, data, windowsize, weights)`
- `running(function, data, windowsize)`
- `running(function, data, windowsize, weights)`

### works with two data vectors
- `rolling(function, data1, data2, windowsize)`
- `rolling(function, data1, data2, windowsize, weights)`  (weights apply to both data vectors)
- `running(function, data1, data2, windowsize)`
- `running(function, data1, data2, windowsize, weights)`  (weights apply to both data vectors)

Many statistical functions of two (vector) variables are not well defined for vectors of length 1. To run these functions and get an initial tapered value that is well defined, supply the desired value as `firstresult`.

- `running(function, data1, data2, windowsize, firstresult)`
- `running(function, data1, data2, windowsize, weights, firstresult)`  (weights apply to both data vectors)

### also exports
- LinearAlgebra.normalize
- StatsBase: AbstractWeights, Weights
- StatsBase: FrequencyWeights, AnalyticWeights, ProbabilityWeights

## Philosophy and Purpose

This package provides a way for rolling and for running a functional window over data.  Data is conveyed either as a vector or as a means of obtaining a vector from a matrix or 3D array or other data structure (e.g. dataframes, timeseries).  Windows move over the data.  One may use unweighted windows or windows that are position weighted.  Weighted windows apply the weight sequence to the window as it moves over the data.

When running with a weighted window, the initial (first, second ..) values are determined using a tapering of the weighted window's span.  This requires that the weights themselves be tapered along with the determinative function that is rolled.  In this case, the weight subsequence is normalized (sums to one(T)), and that reweighting is used with the foreshortened window to taper that which rolls.

This work, and its upkeep (or its replacement by other's work), is offered as an appropriate and reliable scaffold. The work here is to be crisp, precise, accurate, and ever simplifying.  There is no desire to repletify manners of handling here.

Some additional, small, purpose driven and providentially focused packages provide the meta-synthesis and enfolding dispatches that bring the more to the here.


## Also Consider

 - The mapwindow function from [ImageFiltering](https://github.com/JuliaImages/ImageFiltering.jl)
    supports multidimensional window indexing and different maps.
    
