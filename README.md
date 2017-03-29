# RollingFunctions.jl
roll a function over data or run a function along data

```julia
runmean(n,data)  = Runner(RollFinalSpans(mean,n), data)
result = runmean(20, data)

runmean_20(data) = runmean(20, data)
result = runmean_20(data)
```
