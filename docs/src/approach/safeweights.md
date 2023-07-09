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

----

__note:__ This normalization is not the same as calling
`LinearAlgebra.normalize(weights)`, as that divides
each weight by their 2-norm (the sqrt of the sum of squares).
If your application expects weights to be normalized using
something other the 1-norm, do it yourself.

----

See also: [`weighted`](weighted.md)
