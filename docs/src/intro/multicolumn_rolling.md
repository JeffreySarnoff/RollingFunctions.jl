
You have n data vectors of equal length (rowcount 𝓇)
𝐷𝑎𝑡𝑎₁ ..𝐷𝑎𝑡𝑎ᵢ .. 𝐷𝑎𝑡𝑎ₙ
you want to apply a function of n arguments
here, n = 2 and the function isStatsBase.cor
to subsequences over the vectors using a window_span of 3


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

