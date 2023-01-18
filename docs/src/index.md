## RollingFunctions.jl

- You have a data sequence 𝒟, for our initial purposes it is a Vector `[1, 2, 3, 4, 5]`.
- The span of each subsequence is `3`.
- The function to be applied over subsequences of 𝒟 is `sum`.

```
using RollingFunctions

𝒟 = [1, 2, 3, 4, 5]
𝒮 = sum
𝒲 = 3

rolled = rolling(𝒟, 𝒲, 𝒮)
```
```
julia> rolled
3-element Vector{Int64}:
  6
  9
 12

#=
The first  windowed value is the 𝒮 (`sum`) of the first  𝒲 (`3`) values in 𝒟.
The second windowed value is the 𝒮 (`sum`) of the second 𝒲 (`3`) values in 𝒟.
The third  windowed value is the 𝒮 (`sum`) of the third  𝒲 (`3`) values in 𝒟.

There can be no fourth value as the third value used the fins entries in 𝒟.
=#

julia> sum(𝒟[1:3]), sum(𝒟[2:4]), sum(𝒟[3:5])
(6, 9, 12)
```

If the span of each subsequence increases to 4..
```
𝒲 = 4
rolled = rolling(𝒟, 𝒲, 𝒮);

rolled
2-element Vector{Int64}:
 10
 14
```
Generally, with data that has r rows using a window_span of w results in r - w + 1 rows of values.


### Would you prefer to get back a result with the same number of rows as your data?

#### Welcome to the wonderful world of padding

You may pad the result with the padding value of your choice
- `padding` is a keyword argument
- if you assign e.g. `padding = missing`, the result will be padded

`missing, 0.0` are commonly used, however all values save `Nothing` are permitted
   -- using `nothing` as the padding is allowed; using the type `Nothing` is not

```
rolled = rolling(𝒟, 𝒲, 𝒮; padding = missing);

julia> rolled
5-element Vector{Union{Missing, Int64}}:
   missing
   missing
   missing
 10
 14
 
rolled = rolling(𝒟, 𝒲, 𝒮; padding = zero(eltype(𝒟));
julia> rolled
5-element Vector{Int64}:
  0
  0
  0
 10
 14
 ```
