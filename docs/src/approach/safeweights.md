```
    safeweights(<:AbstractVector{T})::AbstractVector{T}
```
ensures that the sum of the weights
- does not exceed 1
- approaches or is equal to 1

`one(T) >=` __`safesum`__ `> prevfloat(one(T), k)`
- safesum = sum(safeweights(weights))
- k <= ceil(1 + log10(wlength) + wlength^(5/16))
- wlength = length(weights)

See also: [`weighted`](weighted.md)
