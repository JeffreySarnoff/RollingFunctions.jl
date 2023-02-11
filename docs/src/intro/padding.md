You may pad the result with the padding value of your choice

padding is a keyword argument
- if you assign e.g. padding = missing, the result will be padded
- you may pad using any defined value and all types except Nothing
- example pads `(missing, 0, nothing, NaN, '∅', AbstractString)`

```
using RollingFunctions

𝒟 = [1, 2, 3, 4, 5]
ℱ = sum
𝒲 = 3

result = rolling(𝒟, 𝒲, ℱ; padding = missing);
#=
5-element Vector{Union{Missing, Int64}}:
   missing
   missing
  6
  9
 12
=#
 
result = rolling(𝒟, 𝒲, ℱ; padding = zero(eltype(𝒟));
#=
5-element Vector{Int64}:
  0
  0
  6
  9
 12
=#
```

### Give me the real values first, pad to the end.
```
result = rolling(𝒟, 𝒲, ℱ; padding = missing, padlast=true);
#=
5-element Vector{Union{Missing,Int64}}:
  6
  9
 12
  missing
  missing
=#
```

**technical aside:** this is not the same as reverse(rolling(𝒟, 𝒲, ℱ; padding = zero(eltype(𝒟)).
