```
You have n data vectors of equal length (rowcount 𝓇)
`𝐃𝐚𝐭𝐚₁ .. 𝐃𝐚𝐭𝐚ᵢ ..  𝐃𝐚𝐭𝐚ₙ`
you want to apply a function of n arguments
here, n = 2 and the function is `StatsBase.cor`
to subsequences over the vectors using a window_span of 3
```
```
using RollingFunctions

𝐃𝐚𝐭𝐚₁ = [1, 2, 3, 4, 5]
𝐃𝐚𝐭𝐚₂ = [5, 4, 3, 2, 1]

𝐅𝐮𝐧𝐜 = cor
𝐒𝐩𝐚𝐧 = 3

result = rolling(𝐅𝐮𝐧𝐜, 𝐃𝐚𝐭𝐚₁, 𝐃𝐚𝐭𝐚₂, 𝐒𝐩𝐚𝐧)
#=
3-element Vector{Float64}:
  -1.0
  -1.0
  -1.0
=#
```
