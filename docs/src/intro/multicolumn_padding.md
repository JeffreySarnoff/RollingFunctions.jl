You may pad the result with the padding value of your choice

padding is a keyword argument
- if you assign e.g. padding = missing, the result will be padded
- you may pad using any defined value and all types except Nothing
- example pads `(missing, 0, nothing, NaN, '∅', AbstractString)`

```
using RollingFunctions

 𝐷𝑎𝑡𝑎₁ = [1, 2, 3, 4, 5]
 𝐷𝑎𝑡𝑎₂ = [5, 4, 3, 2, 1]

𝐹𝑢𝑛𝑐 = cov
𝑆𝑝𝑎𝑛 = 3

result = rolling(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎₁, 𝐷𝑎𝑡𝑎₂, 𝑆𝑝𝑎𝑛; padding = zero(eltype(ℳ)))
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
result = rolling(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎₁, 𝐷𝑎𝑡𝑎₂, 𝑆𝑝𝑎𝑛; padding = missing, padlast=true)
#=
5 element Vector {Float64}:
 -1.0
 -1.0
 -1.0
  missing
  missing
=#
```
**technical aside:** this is not the same as reverse(rolling(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎₁, 𝐷𝑎𝑡𝑎₂, 𝑆𝑝𝑎𝑛; padding = missing).


