```
You have n data vectors of equal length (rowcount 𝓇)
`_Data_₁ .. _Data_ᵢ ..  _Data_ₙ`  collected as an 𝓇 x 𝓃 matrix ℳ
you want to apply the same function (sum) 
to subsequences of each column using a window_span of 3
```
```
using RollingFunctions

_Data_₁ = [1, 2, 3, 4, 5]
_Data_₂ = [5, 4, 3, 2, 1]
_Data_₃ = [1, 2, 3, 2, 1]

ℳ = hcat(_Data_₁, _Data_₂, _Data_₃)
#=
5×3 Matrix{Int64}:
 1  5  1
 2  4  2
 3  3  3
 4  2  2
 5  1  1
=#

_Func_ = sum
_Span_ = 3

result = rolling(_Func_, ℳ, _Span_)
#=
3×3 Matrix{Int64}:
  6  12  6
  9   9  7
 12   6  6
=#

```
