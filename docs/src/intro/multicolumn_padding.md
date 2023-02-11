You may pad the result with the padding value of your choice

padding is a keyword argument
- if you assign e.g. padding = missing, the result will be padded
- you may pad using any defined value and all types except Nothing
- example pads `(missing, 0, nothing, NaN, '∅', AbstractString)`

```
using RollingFunctions

_Data_₁ = [1, 2, 3, 4, 5]
_Data_₂ = [5, 4, 3, 2, 1]

_Func_ = cov
_Span_ = 3

result = rolling(_Func_, _Data_₁, _Data_₂, _Span_; padding = zero(eltype(ℳ)))
#=
5 element Vector {Float64}:
  0.0
  0.0
 -1.0
 -1.0
 -1.0
=#
```

### Give me the real values first, pad to the end.
```
result = rolling(_Func_, _Data_₁, _Data_₂, _Span_; padding = missing, padlast=true)
#=
5 element Vector {Float64}:
 -1.0
 -1.0
 -1.0
  missing
  missing
=#
```
**technical aside:** this is not the same as reverse(rolling(_Func_, _Data_₁, _Data_₂, _Span_; padding = missing).


