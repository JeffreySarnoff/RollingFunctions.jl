### Rolling over Windowed Data - with padding

You may pad the result with the padding value of your choice

padding is a keyword argument
- if you assign e.g. padding = missing, the result will be padded
- you may pad using any defined value and all types except Nothing
- `(missing, 0, nothing, NaN, '∅', AbstractString)` all work

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

### Give me the real values first, pad to the end.
```
rolled = rolling(𝒟, 𝒲, 𝒮; padding = zero(eltype(𝒟), padlast=true);

julia> rolled
5-element Vector{Int64}:
 10
 14
  0
  0
  0
```

**technical aside:** this is not the same as reverse(rolling(𝒟, 𝒲, 𝒮; padding = zero(eltype(𝒟)).
