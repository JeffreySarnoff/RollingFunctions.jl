# RollingFunctions.jl

### Roll a function over data or run a function along data.

#### Copyright © 2017 by Jeffrey Sarnoff.  Released under the MIT License.

-----

[![Build Status](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl.svg?branch=master)](https://travis-ci.org/JeffreySarnoff/RollingFunctions.jl)   (Julia v0.6)

-----

### exports

This package exports running_minimum, running_maximum, running_median, running_mean.    
This example shows how you may create other running functions.

```julia
using RunningFunctions

running_norm(n,data) = Runner(FinalSpansRoller(norm,n), data)

data = map(float,[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]);

result = running_norm(5, data)
```

There are a few kinds of Rollers: FinalSpansRoller, FirstSpansRoller, FullSpansRoller.    
They are used in the same way as the example above.    

**FinalSpansRoller** fully applies the spanning function after span-1 initial entries are more coarsely handled.    
This is most commonly used form.

**FirstSpansRoller** fully applies the spanning function from the first entry; the final span-1 entries are oarsely handled.    
This is used with time series where the newest information is less well established.

**FullSpansRoller** fully applies the spanning function everywhere.  It returns span-1 fewer values than it is given.    
This is used with functions that do not taiper well, and in developing other transformations.
