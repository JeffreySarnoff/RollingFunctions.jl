You may pad the result with the padding value of your choice

padding is a keyword argument
- if you assign e.g. padding = missing, the result will be padded
- you may pad using any defined value and all types except Nothing
- example pads `(missing, 0, nothing, NaN, '∅', AbstractString)`

```
using RollingFunctions

𝐃𝐚𝐭𝐚₁ = [1, 2, 3, 4, 5]
𝐃𝐚𝐭𝐚₂ = [5, 4, 3, 2, 1]
𝐃𝐚𝐭𝐚₃ = [1, 2, 3, 2, 1]

ℳ = hcat(𝐃𝐚𝐭𝐚₁, 𝐃𝐚𝐭𝐚₂, 𝐃𝐚𝐭𝐚₃)
#=
5×3 Matrix{Int64}:
 1  5  1
 2  4  2
 3  3  3
 4  2  2
 5  1  1
=#

𝐅𝐮𝐧𝐜 = sum
𝐒𝐩𝐚𝐧 = 3

result = rolling(𝐅𝐮𝐧𝐜, ℳ, 𝐒𝐩𝐚𝐧; padding=missing)
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
result = rolling(𝐅𝐮𝐧𝐜, ℳ, 𝐒𝐩𝐚𝐧; padding = missing, padlast=true)
#=
5×3 Matrix{Union{Missing,Int64}}:
  6  12  6
  9   9  7
 12   6  6
   missing    missing   missing
   missing    missing   missing
=#
```
**technical aside:** this is not the same as reverse(rolling(𝒮, 𝐃𝐚𝐭𝐚, 𝐒𝐩𝐚𝐧; padding = missing).


