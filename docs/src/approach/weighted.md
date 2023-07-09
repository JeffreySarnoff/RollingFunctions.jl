```
    apply functions over windows into weighted data

`rolling`, `tiling`, and `running` all provide data weighting.

The functions for weighted data follow the unweighted function signatures.
- the weighting is given after the data, as the last positional arg

Weighting for a data vector is given as one of the subtypes of StatsBase.AbstractWeights
```

To use `myweights::Vector{<:Real}` as weights

When a window is provided weights, is _important_
to normalize those weights. For most applications,
the weights should sum to 1.0 (or just less than 1.0).

The function `safeweights(weights::AbstractVector{<:AbstractFloat})`
does the this with care. The sum of a weight vector returned from 
`safeweights` is assured to be <= 1.0 while staying within
a small multiple of`eps(eltype(weights))`.

- scale the values so they sum to 1.0 (or a few eps less than 1.0)
    - `myweights1 = safeweights(myweights1)`
- convert the values to StatsBase.AnalyticWeights (usually)
    - `weighting = AnalyticWeights(myweights1)`

----

See also: [`safeweights`](safeweights.md),
          [`datastreams`](datastreams.md)

