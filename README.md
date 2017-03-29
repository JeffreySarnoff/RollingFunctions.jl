# RollingFunctions.jl
roll a function over data or run a function along data

```julia
using RunningFunctions

data = map(sqrt, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61,
                   67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137 ]);

runmean(n,data)  = Runner(FinalSpansRoller(mean,n), data)
result = runmean(20, data)

runmean_20(data) = runmean(20, data)
result = runmean_20(data)
```

There are a few kinds of Rollers: FinalSpansRoller, FirstSpansRoller, FullSpansRoller.    
They are used in the same way as the example above.    

**FinalSpansRoller** fully applies the spanning function after span-1 initial entries are more coarsely handled.    
This is most commonly used form.

**FirstSpansRoller** fully applies the spanning function from the first data item, the final span-1 entries are more coarsely handled.    
This form is used in some time series analysis where the newest information is less well established than the prior data.

**FullSpansRoller"" fully applies the spanning function everywhere.  It returns span-1 fewer values than it is given.

