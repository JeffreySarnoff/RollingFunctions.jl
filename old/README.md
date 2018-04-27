# RollingFunctions.jl

### Roll a function over data, run a statistic along a [weighted] data window.

#### Copyright © 2017-2018 by Jeffrey Sarnoff.  Released under the MIT License.

-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl)
-----

### works with data
- data that is a simple vector
- nonsimple data organizations that support CartesianIndexing
- sequentially retreivable data streams

### works with filters
- weights that are simple vectors and with StatsBase.AbstractWeights

### exports


#### windowed functions
```julia
roll_minimum, roll_maximum, 
roll_mean, roll_median,
roll_std, roll_var, roll_mad, 
roll_sum, roll_prod, roll_norm
```

#### windowed function construction
```julia
rolling
```

#### how to fill, if desired
```julia
FILL_FIRST, FILL_LAST, FILL_BOTH,     # same value used repeatedly    
TAPER_FIRST, TAPER_LAST, TAPER_BOTH   # smaller windows (to `tapered_size`) used, copies last repeatedly    
                                      # note: `tapered_size = max(2, tapered_size)`, needed for coherence
```

### use

This example shows how you may create other running functions.   
You do not need to define all of the forms, just the ones you want to use.


```julia
import StatsBase: middle
using RollingFunctions

# Roll a function.
# define it
roll_middle{T<:Real}(window_span::Int, data::Vector{T}) =
    rolling(middle, window_span, data)
# use it
rolled = roll_middle(window_span, data)


# Roll a function filling the first part with NaNs.
# define it
roll_middle{T<:Real}(FILL_FIRST, window_span::Int, filler::T, data::Vector{T})  =
    rolling(FILL_FIRST, middle, window_span, filler, data)
# specialize it
roll_middle_NaN{T<:Real}(window_span::Int, data::Vector{T}) =
    roll_middle(FILL_FIRST, window_span, (T)NaN, data)
# use it
rolled = roll_middle_NaN(window, data)


# Roll a function over weighted windows.
# define it
roll_middle{T<:Real}(weights::Vector{T}, data::Vector{T}) =
    rolling(middle, weights, data)
# use it
rolled_weighted = roll_middle(weights, data)


```

Here are all of the forms

```julia
import StatsBase: middle
using RollingFunctions

roll_middle{T<:Real}(window_size::Int, data::Vector{T}) =
    rolling(middle, window_size, data)

roll_middle{T<:Real}(FILL_FIRST, window_size::Int, data::Vector{T})  =
    rolling(FILL_FIRST, middle, window_size, data)
roll_middle{T<:Real}(FILL_LAST, window_size::Int, data::Vector{T})  =
    rolling(FILL_LAST, middle, window_size, data)
roll_middle{T<:Real}(FILL_BOTH, window_size::Int, data::Vector{T})  =
    rolling(FILL_BOTH, middle, window_size, data)
roll_middle{T<:Real}(FILL_BOTH, window_size::Int, data::Vector{T}, alpha)  =
    rolling(FILL_BOTH, middle, window_size, data, alpha) @ 0.0 <= alpha <= 1.0

roll_middle{T<:Real}(FILL_FIRST, window_size::Int, filler::T, data::Vector{T})  =
    rolling(FILL_FIRST, middle, window_size, filler, data)
roll_middle{T<:Real}(FILL_LAST, window_size::Int, filler::T, data::Vector{T})  =
    rolling(FILL_LAST, middle, window_size, filler, data)
roll_middle{T<:Real}(FILL_BOTH, window_size::Int, filler::T, data::Vector{T})  =
    rolling(FILL_BOTH, middle, window_size, filler, data)
roll_middle{T<:Real}(FILL_BOTH, window_size::Int, filler::T, data::Vector{T}, alpha)  =
    rolling(FILL_BOTH, middle, window_size, filler, data, alpha) # 0.0 <= alpha <= 1.0

roll_middle{T<:Real}(TAPER_FIRST, window_size::Int, tapered_size::Int, data::Vector{T})  =
    rolling(TAPER_FIRST, middle, window_size, tapered_size, data)
roll_middle{T<:Real}(TAPER_LAST, window_size::Int, tapered_size::Int, data::Vector{T})  =
    rolling(TAPER_LAST, middle, window_size, tapered_size, data)
roll_middle{T<:Real}(TAPER_BOTH, window_size::Int, tapered_size::Int, data::Vector{T})  =
    rolling(TAPER_BOTH, middle, window_size, tapered_size, data)
roll_middle{T<:Real}(TAPER_BOTH, window_size::Int, tapered_size::Int, data::Vector{T}, alpha)  =
    rolling(TAPER_BOTH, middle, window_size, tapered_size, data, alpha) @ 0.0 <= alpha <= 1.0


data = [ 1.0, 3.0, 5.0, 7.0, 11.0, 15.0 ];

roll_middle(3, data)                 #           [ 3.0,  5.0,  8.0,  11.0 ]

roll_middle(FILL_FIRST, 3, data)     # [ 3.0, 3.0, 3.0,  5.0,  8.0,  11.0 ]
roll_middle(FILL_LAST,  3, data)     #           [ 3.0,  5.0,  8.0,  11.0, 11.0, 11.0 ]
roll_middle(FILL_BOTH,  3, data)     #      [ 3.0, 4.0,  5.5,  8.0,   9.5, 11.0 ]

roll_middle(TAPER_FIRST,3, 2, data)  #      [ 2.0, 2.0, 3.0,  5.0,  8.0, 11.0 ]
roll_middle(TAPER_LAST, 3, 2, data)  #      [ 3.0, 5.0, 8.0, 11.0, 13.0, 13.0 ]
roll_middle(TAPER_BOTH, 3, 2, data)  #      [ 2.5, 3.5, 5.5,  8.0, 10.5, 12.0 ]

weights = [1/8, 2/8, 5/8]
roll_middle(3, weights, data)        #           [ 1.625, 2.375, 3.75, 5.125 ]

```

### note

If the window length equals or exceeds the vector length, these routines will return a vector filled entirely with the default fill value.

### Also Consider

 - The mapwindow function from [ImageFiltering](https://github.com/JuliaImages/ImageFiltering.jl)
    supports multidimensional window indexing and different maps.
