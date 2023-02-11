You have a data sequence 𝒟, for our initial purposes it is a Vector [1, 2, 3, 4, 5].
The span of each subsequence is 3.
The function to be applied over subsequences of 𝒟 is sum.
```
using RollingFunctions

𝒟 = [1, 2, 3, 4, 5]
ℱ = sum
𝒲 = 3

result = rolling(ℱ, 𝒟, 𝒲)
julia> result
3-element Vector{Int64}:
  6
  9
 12

#=
The first  windowed value is the ℱ (`sum`) of the first  𝒲 (`3`) values in 𝒟.
The second windowed value is the ℱ (`sum`) of the second 𝒲 (`3`) values in 𝒟.
The third  windowed value is the ℱ (`sum`) of the third  𝒲 (`3`) values in 𝒟.

There can be no fourth value as the third value used the fins entries in 𝒟.
=#

julia> sum(𝒟[1:3]), sum(𝒟[2:4]), sum(𝒟[3:5])
(6, 9, 12)
If the span of each subsequence increases to 4..

𝒲 = 4
result = rolling(ℱ, 𝒟, 𝒲);

result
2-element Vector{Int64}:
 10
 14
```
Generally, with data that has r rows using a window_span of w results in r - w + 1 rows of values.

