## Rolling over Windowed Data Matrix - no padding
```
You have n data vectors of equal length (rowcount 𝓇)
`𝒟₁ .. 𝒟ᵢ ..  𝒟ₙ`  collected as an 𝓇 x 𝓃 matrix ℳ
you want to apply the same function (sum) 
to subsequences of each column using a window_span of 3
```
```
using RollingFunctions

𝒟₁ = [1, 2, 3, 4, 5, 6]
𝒟₂ = [6, 5, 4, 3, 2, 1]
𝒟₃ = [1, 2, 3, 3, 2, 1]

ℳ = hcat(𝒟₁, 𝒟₂, 𝒟₃)
#=
6×3 Matrix{Int64}:
 1  6  1
 2  5  2
 3  4  3
 4  3  3
 5  2  2
 6  1  1
=#

nrows, ncolumns = size(ℳ)

ℱ = sum
𝒲 = 3

rolled = rolling(ℱ, ℳ, 𝒲)
#=
julia> rolled
4×3 Matrix{Int64}:
  6  15  6
  9  12  8
 12   9  8
 15   6  6
=#

```
