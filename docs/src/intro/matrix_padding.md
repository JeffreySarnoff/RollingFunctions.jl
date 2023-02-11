You may pad the result with the padding value of your choice

padding is a keyword argument
- if you assign e.g. padding = missing, the result will be padded
- you may pad using any defined value and all types except Nothing
- example pads `(missing, 0, nothing, NaN, '∅', AbstractString)`

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

result = rolling(_Func_, ℳ, _Span_; padding=missing)
#=
5×3 Matrix{Union{Missing,Int64}}:
missing missing missing
missing missing missing
  6  12  6
  9   9  7
 12   6  6
=#
```

### Give me the real values first, pad to the end.
```
result = rolling(_Func_, ℳ, _Span_; padding = missing, padlast=true)
#=
5×3 Matrix{Union{Missing,Int64}}:
  6  12  6
  9   9  7
 12   6  6
   missing    missing   missing
   missing    missing   missing
=#
```
**technical aside:** this is not the same as reverse(rolling(𝒮, _Data_, _Span_; padding = missing).


