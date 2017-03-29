# RollingFunctions.jl
roll a function over data or run a function along data


runmean(n,data)  = Runner(RollFinalSpans(mean,n), data)
runmean_20(data) = runmean(20, data)

