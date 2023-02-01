## Rolling over Windowed Data Vectors - no padding
```
You have n data vectors of equal length (rowcount 𝓇)
`𝒟₁ .. 𝒟ᵢ ..  𝒟ₙ`
you want to apply a function of n arguments
here, n = 2 and the function is `StatsBase.cor`
to subsequences over the vectors using a window_span of 3
```
```
using RollingFunctions

𝒟₁ = [1, 2, 3, 4, 5, 6]
𝒟₂ = [6, 5, 4, 3, 2, 1]

ℱ = cor
𝒲 = 3

rolled = rolling(ℱ, 𝒟₁, 𝒟₂, 𝒲)
#=
4-element Vector{Float64}:
  -1.0
  -1.0
  -1.0
  -1.0
=#
```
