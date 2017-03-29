# RollingFunctions.jl
roll a function over data or run a function along data

```julia
using RunningFunctions

data = map(sqrt, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61,
                   67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137 ]);

runmean(n,data)  = Runner(RollFinalSpans(mean,n), data)
result = runmean(20, data)

runmean_20(data) = runmean(20, data)
result = runmean_20(data)
```

