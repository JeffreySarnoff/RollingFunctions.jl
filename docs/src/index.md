## RollingFunctions.jl

This package gives you the ability to apply a summarizing function to successive equilength subsequences of some larger data sequence.

You select on a summarizing function ℱ, provide the data 𝒟, and specify a window span 𝒲.  

By default, `𝒩 = length(𝒟) - 𝒲 + 1` results are returned.

Here are ways to get as many result values as there are data values:

#### specify a padding value (e.g. `; padding = missing`)
  - this will fill the initial result values with the padding value

> specify padding to use at the end (e.g. `; padding = missing, padlast = true`)
  - this will fill the final result values with the padding value

> specify a vector of padding values (`; padding = [1.0, 2.0]`)
  - this will use the padding values in the order given as the first results
  - when the length of the padding vector is `𝒩`, the result is fully specified
  - when the length of the padding vector is `< 𝒩`
     -- `𝒲 - 1 - length(padding)` trimmed values fill in after the padding

> specify an empty, typed vector `eltype == eltype(𝒟)` (; padding = Float64[])
  - this uses the best trimmed values as padding values

