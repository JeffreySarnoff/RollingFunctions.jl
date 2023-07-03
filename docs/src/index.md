## RollingFunctions.jl

----

#### This package makes it easy for you

- to summarize data
- to abstract from meaningful context
- to reify subsumed information

##### A function is applied to successive data subsequences.

----

You give a summarizing function 𝐹𝑢𝑛𝑐, the data𝐷𝑎𝑡𝑎, and a window width 𝑆𝑝𝑎𝑛.  

The result  𝑅 is of length   𝑅ᴺ,   𝑅ᴺ = length(𝐷𝑎𝑡𝑎) - 𝑆𝑝𝑎𝑛 + 1.
- the result omits 𝑅ᴼ = 𝑆𝑝𝑎𝑛 - 1 indices into 𝐷𝑎𝑡𝑎.

----

#### _there are ways for the results match the data in length_

----

#### Use a single, shared padding value

- rolling(function, data, width; padding = missing)
- this will fill the initial result values with the padding value
  - pads these values(result[1], .., result[pad_nindices])

- rolling(function, data, width; padding = missing, atend = true)
- this will fill the final result values with the padding value
  - pads these values(result[n-pad_nindices+1], .., result[n])

#### Pad with a vector of values with length matching the extra indicies (  𝑅ᴼ)

- this fills the extra indices with values obtained bycopying

#### Use an empty vector

- this fills the extra indices with values obtained bytrimming

- trimming evaluates the window function over available data
  - trimmed window widths are less than the specified width

#### Use a vector of𝓃 padding values

- where1 <= 𝓃 <   𝑅ᴼ.

- this first pads then trims to assign the extra indices
  - the first𝓃 indices of the result will match this vector
  - the next  𝑅ᴼ - 𝓃 indices of the result will be trimmed
  - the remaining indices get the rolled results.

