
You have n data vectors of equal length (rowcount 𝓇)
 𝐷𝑎𝑡𝑎₁ .. 𝐷𝑎𝑡𝑎ᵢ ..  𝐷𝑎𝑡𝑎ₙ  collected as an 𝓇 x 𝓃 matrix ℳ
you want to apply the same function (sum) 
to subsequences of each column using a window_span of 3


using RollingFunctions

 𝐷𝑎𝑡𝑎₁ = [1, 2, 3, 4, 5]
 𝐷𝑎𝑡𝑎₂ = [5, 4, 3, 2, 1]
 𝐷𝑎𝑡𝑎₃ = [1, 2, 3, 2, 1]

ℳ = hcat( 𝐷𝑎𝑡𝑎₁, 𝐷𝑎𝑡𝑎₂, 𝐷𝑎𝑡𝑎₃)
#=
5×3 Matrix{Int64}:
 1  5  1
 2  4  2
 3  3  3
 4  2  2
 5  1  1
=#

𝐹𝑢𝑛𝑐 = sum
𝑆𝑝𝑎𝑛 = 3

result = rolling(𝐹𝑢𝑛𝑐, ℳ, 𝑆𝑝𝑎𝑛)
#=
3×3 Matrix{Int64}:
  6  12  6
  9   9  7
 12   6  6
=#


