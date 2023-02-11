```
You have n data vectors of equal length (rowcount 𝓇)
`_Data_₁ .. _Data_ᵢ ..  _Data_ₙ`
you want to apply a function of n arguments
here, n = 2 and the function is `StatsBase.cor`
to subsequences over the vectors using a window_span of 3
```
```
using RollingFunctions

_Data_₁ = [1, 2, 3, 4, 5]
_Data_₂ = [5, 4, 3, 2, 1]

_Func_ = cor
_Span_ = 3

result = rolling(_Func_, _Data_₁, _Data_₂, _Span_)
#=
3-element Vector{Float64}:
  -1.0
  -1.0
  -1.0
=#
```
