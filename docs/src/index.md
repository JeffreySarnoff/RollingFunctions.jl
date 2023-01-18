## RollingFunctions.jl

- You have a data sequence 𝒟, for our initial purposes it is a Vector `[1, 2, 3, 4, 5]`.
- The span of each subsequence is `3`.
- The function to be applied over subsequences of 𝒟 is `sum`.

```
using RollingFunctions

𝒟 = [1, 2, 3, 4, 5]
𝒮 = sum
𝒲 = 3

rolled = rolling(𝒟, 𝒲, 𝒮)
```
```
julia> rolled
3-element Vector{Int64}:
  6
  9
 12

#=
The first  windowed value is the 𝒮 (`sum`) of the first  𝒲 (`3`) values in 𝒟.
The second windowed value is the 𝒮 (`sum`) of the second 𝒲 (`3`) values in 𝒟.
The third  windowed value is the 𝒮 (`sum`) of the third  𝒲 (`3`) values in 𝒟.

There can be no fourth value as the third value used the fins entries in 𝒟.
=#

julia> sum(𝒟 [1:3])
6

julia> sum(𝒟 [2:4])
9

julia> sum(𝒟 [3:5])
12
```
