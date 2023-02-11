## RollingFunctions.jl

----

#### This package makes it easy to summarize windowed data.

#### A function is applied to successive data subsequences.

----

You give a summarizing function ℱ, the data 𝒟, and a window span 𝒲.  

The result `ℛ` is of length `ℛᴺ`, ℛᴺ = length(𝒟) - 𝒲 + 1`.
- the result omits `ℛᴼ`, `ℛᴼ = 𝒲 - 1` indices into 𝒟.

Here are ways to get as many result values as there are data values:

### Use a single, shared padding value

#### specify a padding value (default position is at the start)

- `rolling(function, data, window_span; padding = missing)`
- this will fill the initial result values with the padding value
  - pads these values `(result[1], .., result[pad_nindices])`

#### specify padding to be at the end of the result

- `rolling(function, data, window_span; padding = missing, padlast = true)`
- this will fill the final result values with the padding value
  - pads these values `(result[n-pad_nindices+1], .., result[n])`

### Use a vector of padding values with length `ℛᴼ`

#### specify a padding vector (default is at the start)

#### specify the padding vector to be at the end

### Use an empty vector 

#### this fills the `ℛᴼ` indices by `trimming`

- _here is the way to do that_
  - `running(function, data, window_span; padding = eltype(data)[]`)

- `trimming` evaluates the window function over available data
  - trimmed window spans are less than the specified window_span

### Use a vector of `𝓃` padding values

- where `1 <= 𝓃 < ℛᴼ`.

#### this both pads and trims to assign the initial indices

- the first `𝓃` indices of the result will match this vector
- the next `ℛᴼ - 𝓃` indices of the result will be trimmed
- the remaining indices get the rolled results.

