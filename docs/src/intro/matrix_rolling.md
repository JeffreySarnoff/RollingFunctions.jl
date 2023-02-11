```
You have n data vectors of equal length (rowcount 𝓇)
`𝐃𝐚𝐭𝐚₁ .. 𝐃𝐚𝐭𝐚ᵢ ..  𝐃𝐚𝐭𝐚ₙ`  collected as an 𝓇 x 𝓃 matrix ℳ
you want to apply the same function (sum) 
to subsequences of each column using a window_span of 3
```
```
using RollingFunctions

𝐃𝐚𝐭𝐚₁ = [1, 2, 3, 4, 5]
𝐃𝐚𝐭𝐚₂ = [5, 4, 3, 2, 1]
𝐃𝐚𝐭𝐚₃ = [1, 2, 3, 2, 1]

ℳ = hcat(𝐃𝐚𝐭𝐚₁, 𝐃𝐚𝐭𝐚₂, 𝐃𝐚𝐭𝐚₃)
#=
5×3 Matrix{Int64}:
 1  5  1
 2  4  2
 3  3  3
 4  2  2
 5  1  1
=#

𝐅𝐮𝐧𝐜 = sum
𝐒𝐩𝐚𝐧 = 3

result = rolling(𝐅𝐮𝐧𝐜, ℳ, 𝐒𝐩𝐚𝐧)
#=
3×3 Matrix{Int64}:
  6  12  6
  9   9  7
 12   6  6
=#

```
