----

#### This package makes it easy to summarize windowed data.

#### A function is applied to successive data subsequences.

----

You give a summarizing function ℱ, the data 𝒟, and a window span 𝒲.  

The result `ℛ` is of length `ℛᴺ`, ℛᴺ = length(𝒟) - 𝒲 + 1`.
- the result omits `ℛᴼ`, `ℛᴼ = 𝒲 - 1` indices into 𝒟.

- _here is the way to do that_
  - `rolling(ℱ, 𝒟, 𝒲)`
  - `rolling(function, data, window_span)`

----

### Here are ways to get as many results as there are data values:

----

#### Use a single, shared padding value

##### specify a padding value (default position is at the start)

- _here is the way to do that_
  - `rolling(ℱ, 𝒟, 𝒲; padding = <value>)`
  - `rolling(function, data, window_span; padding = missing)`
- this will fill the initial result values with the padding value
  - pads these values `(result[1], .., result[pad_nindices])`

##### specify padding to be at the end of the result

- _here is the way to do that_
  - `rolling(ℱ, 𝒟, 𝒲; padding = <value>, padlast = true)`
  - `rolling(function, data, window_span; padding = missing, padlast = true)`
- this will fill the final result values with the padding value
  - pads these values `(result[n-pad_nindices+1], .., result[n])`
