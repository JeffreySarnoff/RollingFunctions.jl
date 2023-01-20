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

ℳ = hcat(𝒟₁, 𝒟₂, 𝒟₃)
#=
6×3 Matrix{Int64}:
 1  6  1
 2  5  2
 3  4  3
 4  3  3
 5  2  2
 6  1  1
=#

𝒮 = sum
𝒲 = 3

rolled = rolling(𝒮, ℳ, 𝒲; padding = zero(eltype(ℳ)))
#=
6×3 Matrix{Int64}:
  0   0  0
  0   0  0
  6  15  6
  9  12  8
 12   9  8
 15   6  6
 =#
```

### Give me the real values first, pad to the end.
```
rolled = rolling(𝒮, ℳ, 𝒲; padding = missing, padlast=true)
#=
6×3 Matrix{Union{Missing, Int64}}:
  6         15         6
  9         12         8
 12          9         8
 15          6         6
   missing    missing   missing
   missing    missing   missing
=#
```
**technical aside:** this is not the same as reverse(rolling(𝒮, 𝒟, 𝒲; padding = missing).


