
- You have a data sequence 𝐷𝑎𝑡𝑎, the Vector[1, 2, 3, 4, 5].
- The window width 𝑆𝑝𝑎𝑛 of each subsequence is 3.
- The function 𝐹𝑢𝑛𝑐 to be applied over subsequences of 𝐷𝑎𝑡𝑎 is sum.

```
using RollingFunctions

𝐷𝑎𝑡𝑎 = [1, 2, 3, 4, 5]
𝐹𝑢𝑛𝑐 = sum
𝑆𝑝𝑎𝑛 = 3

rolled = rolling(𝐹𝑢𝑛𝑐,𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛)


julia> rolled
3-element Vector{Int64}:
  6
  9
 12

#=
The first  windowed value is the 𝐹𝑢𝑛𝑐 (sum) of the first  𝑆𝑝𝑎𝑛 (3) values in 𝐷𝑎𝑡𝑎.
The second windowed value is the 𝐹𝑢𝑛𝑐 (sum) of the second 𝑆𝑝𝑎𝑛 (3) values in 𝐷𝑎𝑡𝑎.
The third  windowed value is the 𝐹𝑢𝑛𝑐 (sum) of the third  𝑆𝑝𝑎𝑛 (3) values in 𝐷𝑎𝑡𝑎.

There can be no fourth value as the third value used the fins entries in𝐷𝑎𝑡𝑎.
=#

julia> sum(𝐷𝑎𝑡𝑎[1:3]), sum(𝐷𝑎𝑡𝑎[2:4]), sum(𝐷𝑎𝑡𝑎[3:5])
(6, 9, 12)


If the width of each subsequence increases to 4..

𝑆𝑝𝑎𝑛 = 4
rolled = rolling(𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛, 𝒮);

rolled
2-element Vector{Int64}:
 10
 14
```

Generally, with data that has r rows using a width of s results in r - s + 1 rows of values.

#### with matricies

```
#=

You have n data vectors of equal length (rowcount 𝓇)
𝐷𝑎𝑡𝑎₁ .. 𝐷𝑎𝑡𝑎ᵢ .. 𝐷𝑎𝑡𝑎ₙ  collected as an 𝓇 x 𝓃 matrix 𝑀
you want to apply the same function (sum) 
to colum-wise triple row subsequences, successively

=#

using RollingFunctions

𝐷𝑎𝑡𝑎₁ = [1, 2, 3, 4, 5]
𝐷𝑎𝑡𝑎₂ = [5, 4, 3, 2, 1]
𝐷𝑎𝑡𝑎₃ = [1, 2, 3, 2, 1]

𝑀 = hcat(𝐷𝑎𝑡𝑎₁, 𝐷𝑎𝑡𝑎₂, 𝐷𝑎𝑡𝑎₃);

#=
julia> 𝑀
5×3 Matrix{Int64}:
 1  5  1
 2  4  2
 3  3  3
 4  2  2
 5  1  1
=#

𝐹𝑢𝑛𝑐 = sum
𝑆𝑝𝑎𝑛 = 3

result = rolling(𝐹𝑢𝑛𝑐, 𝑀, 𝑆𝑝𝑎𝑛)

#=
julia> result
3×3 Matrix{Int64}:
  6  12  6
  9   9  7
 12   6  6
=#

```

#### multicolumn functions

```
#=

You have n data vectors of equal length (rowcount 𝓇)
𝐷𝑎𝑡𝑎₁ .. 𝐷𝑎𝑡𝑎ᵢ .. 𝐷𝑎𝑡𝑎ₙ
you apply a function (StatsBase.cor) of n==2 arguments
to subsequences of width 3 (over successive triple rows)

=#

using RollingFunctions

𝐷𝑎𝑡𝑎₁ = [1, 2, 3, 4, 5]
𝐷𝑎𝑡𝑎₂ = [5, 4, 3, 2, 1]

𝐹𝑢𝑛𝑐 = cor
𝑆𝑝𝑎𝑛 = 3

result = rolling(𝐹𝑢𝑛𝑐,𝐷𝑎𝑡𝑎₁,𝐷𝑎𝑡𝑎₂, 𝑆𝑝𝑎𝑛)
#=
3-element Vector{Float64}:
  -1.0
  -1.0
  -1.0
=#

```
