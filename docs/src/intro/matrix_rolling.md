## Rolling over Windowed Data Matrix - no padding
```
You have n data vectors of equal length (rowcount 𝓇)
`𝒟₁ .. 𝒟ᵢ ..  𝒟ₙ`  collected as an 𝓇 x 𝓃 matrix ℳ
you want to apply the same function (sum) 
to subsequences of each column using a window_span of 3
```
```
using RollingFunctions

𝒟₁ = [1, 2, 3, 4, 5]
𝒟₂ = [5, 4, 3, 2, 1]
𝒟₃ = [1, 2, 3, 2, 1]

ℳ = hcat(𝒟₁, 𝒟₂, 𝒟₃)
#=
5×3 Matrix{Int64}:
 1  5  1
 2  4  2
 3  3  3
 4  2  2
 5  1  1
=#

ℱ = sum
𝒲 = 3

result = rolling(ℱ, ℳ, 𝒲)
#=
3×3 Matrix{Int64}:
  6  12  6
  9   9  7
 12   6  6
=#

```
