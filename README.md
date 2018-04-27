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
- columns from a DataFrame or an IndexedTable
- columns from a CSV.jl readable file

### works with filters
- weights that are simple vectors and with StatsBase.AbstractWeights

---------

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

We support using prepared values to `prime the rolling evaluation`.
Alternatively, one may just copy over the first few (earliest)
observations and begin growing the taper from those values.

```julia
using RollingFunctions, StatsBase
# and any of these or others as you may select:
# CSV, DataFrames, IndexedTables, JuliaDB, TimeSeries 
data = vector_from_datasource( datasource )
rollingfun = geomean
windowspan = 200

n2prep = 15
taperprep = [median(data[1:idx]) for idx=1:n2prep]

taper = tapering(rollingfun, data[1:windowspan-1], taperprep)
```
To copy over the first observations and let them serve as the taperprep
```julia
using RollingFunctions, StatsBase
data = vector_from_datasource( datasource )
rollingfun = geomean
windowspan = 200

n2copy = 15
taper = tapering(rollingfun, data[1:windowspan-1], n2copy)
```
