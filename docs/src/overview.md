
- You have a data sequence _Data_, for now it is a Vector `[1, 2, 3, 4, 5]`.
- The window span _Span_ of each subsequence is `3`.
- The function _Func_ to be applied over subsequences of _Data_ is `sum`.

```
using RollingFunctions

_Data_ = [1, 2, 3, 4, 5]
_Func_ = sum
_Span_ = 3

rolled = rolling(_Func_, _Data_, _Span_)
```
```
julia> rolled
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
```

If the span of each subsequence increases to 4..
```
_Span_ = 4
rolled = rolling(_Data_, _Span_, 𝒮);

rolled
2-element Vector{Int64}:
 10
 14
```
Generally, with data that has r rows using a window_span of w results in r - w + 1 rows of values.


### To get back a result with the same number of rows as your data

#### Welcome to the wonderful world of padding

You may pad the result with the padding value of your choice
- `padding` is a keyword argument
- if you assign e.g. `padding = missing`, the result will be padded

`missing, 0.0` are commonly used, however all values save `Nothing` are permitted
   -- using `nothing` as the padding is allowed; using the type `Nothing` is not

```
using RollingFunctions

_Data_ = [1, 2, 3, 4, 5]
_Func_ = sum
_Span_ = 3

rolled = rolling(_Func_, _Data_, _Span_; padding = missing);

julia> rolled
5-element Vector{Union{Missing, Int64}}:
   missing
   missing
   missing
 10
 14
 
rolled = rolling(_Data_, _Span_, 𝒮; padding = zero(eltype(_Data_));
julia> rolled
5-element Vector{Int64}:
  0
  0
  0
 10
 14
 ```

### Give me the real values first, pad to the end.

```
rolled = rolling(_Func_, _Data_, _Span_; padding = zero(eltype(_Data_), padlast=true);
julia> rolled
5-element Vector{Int64}:
 10
 14
  0
  0
  0
```

**technical note:** this is not the same as `reverse(rolling(_Data_, _Span_, 𝒮; padding = zero(eltype(_Data_))`.

