You may pad the result with the padding value of your choice

padding is a keyword argument
- if you assign e.g. padding = missing, the result will be padded
- you may pad using any defined value and all types except Nothing
- example pads `(missing, 0, nothing, NaN, '∅', AbstractString)`

```
using RollingFunctions

𝒟₁ = [1, 2, 3, 4, 5]
𝒟₂ = [5, 4, 3, 2, 1]
𝒟₃ = [1, 2, 3, 2, 1]

ℳ = hcat(𝒟₁, 𝒟₂, 𝒟₃)
#=
5×3 Matrix{Int64}:
 1  5  1
 2  4  2
 3  3  3
 4  2  2
 5  1  1
=#

ℱ = sum
𝒲 = 3

result = rolling(ℳ, 𝒲, ℱ; padding=missing)
#=
5×3 Matrix{Union{Missing,Int64}}:
missing missing missing
missing missing missing
  6  12  6
  9   9  7
 12   6  6
=#
```

### Give me the real values first, pad to the end.
```
result = rolling(ℳ, 𝒲, ℱ; padding = missing, padlast=true)
#=
5×3 Matrix{Union{Missing,Int64}}:
  6  12  6
  9   9  7
 12   6  6
   missing    missing   missing
   missing    missing   missing
=#
```
**technical aside:** this is not the same as reverse(rolling(𝒮, 𝒟, 𝒲; padding = missing).


