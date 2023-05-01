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
