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
