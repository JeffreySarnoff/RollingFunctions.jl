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
