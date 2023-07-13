You may pad the result with the _value_ of your choice

#### padding is a keyword argument

- if you assign e.g. padding = missing, the result will be padfirst
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
result = rolling(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = missing, atend=true);
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

#### padding matrices

using RollingFunctions

𝐷𝑎𝑡𝑎₁ = [1, 2, 3, 4, 5]
𝐷𝑎𝑡𝑎₂ = [5, 4, 3, 2, 1]
𝐷𝑎𝑡𝑎₃ = [1, 2, 3, 2, 1]

𝑀 = hcat(𝐷𝑎𝑡𝑎₁,𝐷𝑎𝑡𝑎₂,𝐷𝑎𝑡𝑎₃)
#=
5×3 Matrix{Int64}:
 1  5  1
 2  4  2
 3  3  3
 4  2  2
 5  1  1
=#

𝐹𝑢𝑛𝑐 = sum
𝑆𝑝𝑎𝑛 = 3

result = rolling(𝐹𝑢𝑛𝑐, 𝑀, 𝑆𝑝𝑎𝑛; padding=missing)
#=
5×3 Matrix{Union{Missing,Int64}}:
missing missing missing
missing missing missing
  6  12  6
  9   9  7
 12   6  6
=#


### Give me the real values first, pad to the end.

result = rolling(𝐹𝑢𝑛𝑐, 𝑀, 𝑆𝑝𝑎𝑛; padding = missing, atend=true)
#=
5×3 Matrix{Union{Missing,Int64}}:
  6  12  6
  9   9  7
 12   6  6
   missing    missing   missing
   missing    missing   missing
=#

#### multicolumn padding

You may pad the result with the _value_ of your choice

#### padding is a keyword argument

- if you assign e.g. padding = missing, the result will be padfirst
- you may pad using any defined value and all types except Nothing
- example pads(missing, 0, nothing, NaN, '∅', AbstractString)

```
using RollingFunctions

𝐷𝑎𝑡𝑎₁ = [1, 2, 3, 4, 5]
𝐷𝑎𝑡𝑎₂ = [5, 4, 3, 2, 1]

𝐹𝑢𝑛𝑐 = cov
𝑆𝑝𝑎𝑛 = 3

result = rolling(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎₁, 𝐷𝑎𝑡𝑎₂, 𝑆𝑝𝑎𝑛; padding = zero(eltype(𝑀)))

#=
julia> result
5 element Vector {Float64}:
  0.0
  0.0
 -1.0
 -1.0
 -1.0
=#
```

### Give me the real values first, pad to the end.

```
result = rolling(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎₁, 𝐷𝑎𝑡𝑎₂, 𝑆𝑝𝑎𝑛; padding = missing, atend=true)

#=
5 element Vector {Float64}:
 -1.0
 -1.0
 -1.0
  missing
  missing
=#
```


