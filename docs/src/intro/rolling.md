```
You have a data sequence _Data_, it is a Vector [1, 2, 3, 4, 5].
The span of each subsequence is 3.
The function to be applied over subsequences of _Data_ is `sum`.
```
```
using RollingFunctions

_Data_ = [1, 2, 3, 4, 5]
_Func_ = sum
_Span_ = 3

result = rolling(_Func_, _Data_, _Span_)
julia> result
3-element Vector{Int64}:
  6
  9
 12

#=
The first  windowed value is the _Func_ (`sum`) of the first  _Span_ (`3`) values in _Data_.
The second windowed value is the _Func_ (`sum`) of the second _Span_ (`3`) values in _Data_.
The third  windowed value is the _Func_ (`sum`) of the third  _Span_ (`3`) values in _Data_.

There can be no fourth value as the third value used the fins entries in _Data_.
=#

julia> sum(_Data_[1:3]), sum(_Data_[2:4]), sum(_Data_[3:5])
(6, 9, 12)
If the span of each subsequence increases to 4..

_Span_ = 4
result = rolling(_Func_, _Data_, _Span_);

result
2-element Vector{Int64}:
 10
 14
```
Data with `r` rows using a window_span of `w` results in `r - w + 1` values.
- to obtain `r` values, use padding or tapering

