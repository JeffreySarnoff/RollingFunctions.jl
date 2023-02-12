You may pad the result with the _value_ of your choice

#### padding is a keyword argument

- if you assign e.g. padding = missing, the result will be padded
- you may pad using any defined value and all types except Nothing
- example pads(missing, 0, nothing, NaN, '∅', AbstractString)

```
using RollingFunctions

𝐷𝑎𝑡𝑎 = [1, 2, 3, 4, 5]
𝐹𝑢𝑛𝑐 = sum
𝑆𝑝𝑎𝑛 = 3

result = rolling(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = missing);
#=
julia> result
5-element Vector{Union{Missing, Int64}}:
   missing
   missing
  6
  9
 12
=#
 
result = rolling(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = zero(eltype(𝐷𝑎𝑡𝑎));
#=
julia> result
5-element Vector{Int64}:
  0
  0
  6
  9
 12
=#
```

#### Give me the real values first, pad to the end.

```
result = rolling(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = missing, padlast=true);
#=
julia> result
5-element Vector{Union{Missing,Int64}}:
  6
  9
 12
  missing
  missing
=#
```

**technical aside:** this is not the same as reverse(rolling(𝐹𝑢𝑛𝑐,𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = zero(eltype(𝐷𝑎𝑡𝑎)).
