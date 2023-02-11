
- You have a data sequence 𝐃𝐚𝐭𝐚, for now it is a Vector `[1, 2, 3, 4, 5]`.
- The window span 𝐒𝐩𝐚𝐧 of each subsequence is `3`.
- The function 𝐅𝐮𝐧𝐜 to be applied over subsequences of 𝐃𝐚𝐭𝐚 is `sum`.

```
using RollingFunctions

𝐃𝐚𝐭𝐚 = [1, 2, 3, 4, 5]
𝐅𝐮𝐧𝐜 = sum
𝐒𝐩𝐚𝐧 = 3

rolled = rolling(𝐅𝐮𝐧𝐜, 𝐃𝐚𝐭𝐚, 𝐒𝐩𝐚𝐧)
```
```
julia> rolled
3-element Vector{Int64}:
  6
  9
 12

#=
The first  windowed value is the 𝐅𝐮𝐧𝐜 (`sum`) of the first  𝐒𝐩𝐚𝐧 (`3`) values in 𝐃𝐚𝐭𝐚.
The second windowed value is the 𝐅𝐮𝐧𝐜 (`sum`) of the second 𝐒𝐩𝐚𝐧 (`3`) values in 𝐃𝐚𝐭𝐚.
The third  windowed value is the 𝐅𝐮𝐧𝐜 (`sum`) of the third  𝐒𝐩𝐚𝐧 (`3`) values in 𝐃𝐚𝐭𝐚.

There can be no fourth value as the third value used the fins entries in 𝐃𝐚𝐭𝐚.
=#

julia> sum(𝐃𝐚𝐭𝐚[1:3]), sum(𝐃𝐚𝐭𝐚[2:4]), sum(𝐃𝐚𝐭𝐚[3:5])
(6, 9, 12)
```

If the span of each subsequence increases to 4..
```
𝐒𝐩𝐚𝐧 = 4
rolled = rolling(𝐃𝐚𝐭𝐚, 𝐒𝐩𝐚𝐧, 𝒮);

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

𝐃𝐚𝐭𝐚 = [1, 2, 3, 4, 5]
𝐅𝐮𝐧𝐜 = sum
𝐒𝐩𝐚𝐧 = 3

rolled = rolling(𝐅𝐮𝐧𝐜, 𝐃𝐚𝐭𝐚, 𝐒𝐩𝐚𝐧; padding = missing);

julia> rolled
5-element Vector{Union{Missing, Int64}}:
   missing
   missing
   missing
 10
 14
 
rolled = rolling(𝐃𝐚𝐭𝐚, 𝐒𝐩𝐚𝐧, 𝒮; padding = zero(eltype(𝐃𝐚𝐭𝐚));
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
rolled = rolling(𝐅𝐮𝐧𝐜, 𝐃𝐚𝐭𝐚, 𝐒𝐩𝐚𝐧; padding = zero(eltype(𝐃𝐚𝐭𝐚), padlast=true);
julia> rolled
5-element Vector{Int64}:
 10
 14
  0
  0
  0
```

**technical note:** this is not the same as `reverse(rolling(𝐃𝐚𝐭𝐚, 𝐒𝐩𝐚𝐧, 𝒮; padding = zero(eltype(𝐃𝐚𝐭𝐚))`.

