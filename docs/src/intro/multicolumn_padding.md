### Rolling over Windowed Data Matrix - with padding

You may pad the result with the padding value of your choice

padding is a keyword argument
- if you assign e.g. padding = missing, the result will be padded
- you may pad using any defined value and all types except Nothing
- example pads `(missing, 0, nothing, NaN, '∅', AbstractString)`

```
using RollingFunctions

𝒟₁ = [1, 2, 3, 4, 5, 6]
𝒟₂ = [6, 5, 4, 3, 2, 1]
𝒟₃ = [1, 2, 3, 3, 2, 1]

ℱ = cov
𝒲 = 3

rolled = rolling(ℱ, 𝒟₁, 𝒟₂, 𝒲; padding = zero(eltype(ℳ)))
#=
6 element Vector {Float64}:
  0.0
  0.0
 -1.0
 -1.0
 -1.0
 -1.0
=#
```

### Give me the real values first, pad to the end.
```
rolled = rolling(ℱ, ℳ, 𝒲; padding = missing, padlast=true)
#=
6 element Vector {Float64}:
 -1.0
 -1.0
 -1.0
 -1.0
  0.0
  0.0
=#
```
**technical aside:** this is not the same as reverse(rolling(ℱ, 𝒟, 𝒲; padding = missing).


