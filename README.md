# RollingFunctions.jl

### Roll a [weighted] function or run a statistic along windowed data.

#### Copyright © 2017-2024 by Jeffrey Sarnoff.  Released under the MIT License.

-----

## IMPORTANT <<<

For now, rather than use e.g `runmean`, `runcov`, with version 0.8 use `running(cov, ..)`
[here is an example](https://github.com/JeffreySarnoff/RollingFunctions.jl/issues/49#issuecomment-1726955742)

-----
-----


[![Package Downloads](https://shields.io/endpoint?url=https://pkgs.genieframework.com/api/v1/badge/RollingFunctions)](https://pkgs.genieframework.com?packages=RollingFunctions&startdate=2015-12-30&enddate=2040-12-31)

-----
### works with integers, floats, and missings

### works with unweighted data
- data that is a simple vector
- data that is a CartesianIndexed vector

### works with weights
- weights given as a simple vector
- weights given as a kind of StatsBase.AbstractWeights

### applies functions (1-arg, .., 4-args)
- applied over unweighted or weighted data

### works with data matrices
- same 1-arg function applied to each column

### reasonable uses
- with a simple vector
- with a DataFrame column
- with a TimeSeries column
- with your own function

---------

## Rolling a function over data

With `ndata = length(data)`, using a window of length `windowsize`, rolling a function results in a vector of `ndata - windowsize + 1` elements.  So there will be obtained `windowsize - 1` fewer values than there are data values. All exported functions named with the prefix __`roll`__ behave this way **unless** the keyword `padding` is given with the value to use for padding (e.g. `missing`).  Using `padding` will fill the initial `windowsize - 1` values with that padding value; the result will match the length of the data.

```julia
julia> data = collect(1.0f0:5.0f0); print(data)
Float32[1.0, 2.0, 3.0, 4.0, 5.0]
julia> windowsize = 3;

julia> result = rollmean(data, windowsize); print(result)
Float32[2.0, 3.0, 4.0]

julia> result = rollmean(data, windowsize; padding=missing); print(result)
Union{Missing, Float32}[missing, missing, 2.0, 3.0, 4.0]
```

```julia
julia> weights = normalize([1.0f0, 2.0f0, 4.0f0])
3-element Array{Float32,1}:
 0.21821788
 0.43643576
 0.8728715 
 
julia> result = rollmean(data, windowsize, weights); print(result)
Float32[1.23657, 1.74574, 2.25492]

julia> result = rollmean(data, windowsize, weights; padding=missing); print(result)
Union{Missing,Float32}[missing, missing, 1.23657, 1.74574, 2.25492]
```

## Running a function over data

To obtain the same number of output data values as are given, the initial `windowsize - 1` values output must be generated outside of the rolling behavior.  This is accomplished by tapering the needed values -- using the same function, rolling it over successively smaller window sizes.  All exported functions named with the prefix __`run`__ behave this way.

```julia
julia> using RollingFunctions
julia> data = collect(1.0f0:5.0f0); print(data)
Float32[1.0, 2.0, 3.0, 4.0, 5.0]
julia> windowsize = 3;

julia> result = runmean(data, windowsize); print(result)
Float32[1.0, 1.5, 2.0, 3.0, 4.0]
```

```julia
julia> using RollingFunctions
julia> using LinearAlgebra: normalize

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

### works with functions over 1, 2, 3 or 4 data vectors
- `rolling(function, data1, data2, windowsize)`
- `rolling(function, data1, data2, windowsize, weights)`  (weights apply to both data vectors)
- `rolling(function, data1, data2, windowsize, weights1, weights2)`

- `rolling(function, data1, data2, data3, windowsize)`
- `rolling(function, data1, data2, data3, windowsize, weights)`  (weights apply to all data vectors)
- `rolling(function, data1, data2, data3, windowsize, weights1, weights2, weights3)`

- `running(function, data1, data2, data3, data4, windowsize)`
- `running(function, data1, data2, data3, data4, windowsize, weights)`  (weights apply to all data vectors)
- `running(function, data1, data2, data3, data4, windowsize, weights1, weights2, weights3, weights4)`

!! CHANGE ME !!
Many statistical functions of two or more vector variables are not well defined for vectors of length 1. 
To run these functions and get an initial tapered value that is well defined, supply the desired value as `firstresult`.

- `running(function, data1, data2, windowsize, firstresult)`
- `running(function, data1, data2, windowsize, weights, firstresult)`  (weights apply to both data vectors)

## Philosophy and Purpose

This package provides a way for rolling and for running a functional window over data.  Data is conveyed either as a vector or as a means of obtaining a vector from a matrix or 3D array or other data structure (e.g. dataframes, timeseries).  Windows move over the data.  One may use unweighted windows or windows wherein each position carries weight. Weighted windows apply the weight sequence through the window as it moves over the data.

When a window is provided with weights, the weights ~should~ must be normalized. We provide an algorithmically safe normalizing function that you may rely upon. Adding the sequence of normalized values one to the next obtains 1.0 or a value very slightly less than 1.0 -- their sum will not exceed unity.
_I do not know how to augment something already whole while respecting its integrity._

When running with a weighted window, the initial (first, second ..) values are determined using a tapering of the weighted window's span.  This requires that the weights themselves be tapered along with the determinative function that is rolled.  In this case, the weight subsequence is normalized (sums to one(T)), and that reweighting is used with the foreshortened window to taper that which rolls.

This software exists to simpilfy some of what you create and to faciliate some of the work you do. 

Some who use it insightfully share the best of that. Others write words that smile. 

All of this is expressed through the design of RollingFunctions.



## Also Consider

 - The mapwindow function from [ImageFiltering](https://github.com/JuliaImages/ImageFiltering.jl)
    supports multidimensional window indexing and different maps.
    
