## RollingFunctions.jl

----

#### This package makes it easy to summarize windowed data.

#### A function is applied to successive data subsequences.

----

You give a summarizing function _Func_, the data _Data_, and a window span _Span_.  

The result `ℛ` is of length `ℛᴺ`, ℛᴺ = length(_Data_) - _Span_ + 1`.
- the result omits `ℛᴼ`, `ℛᴼ = `_Span_` - 1` indices into _Data_.

----

#### _there are ways for the results match the data in length_

----

#### Use a single, shared padding value

- `rolling(function, data, window_span; padding = missing)`
- this will fill the initial result values with the padding value
  - pads these values `(result[1], .., result[pad_nindices])`

- `rolling(function, data, window_span; padding = missing, padlast = true)`
- this will fill the final result values with the padding value
  - pads these values `(result[n-pad_nindices+1], .., result[n])`

#### Pad with a vector of values with length matching the extra indicies (`ℛᴼ`)

- this fills the extra indices with values obtained by `copying`

#### Use an empty vector

- this fills the extra indices with values obtained by `trimming`

- `trimming` evaluates the window function over available data
  - trimmed window spans are less than the specified window_span

#### Use a vector of `𝓃` padding values

- where `1 <= 𝓃 < ℛᴼ`.

- this first pads then trims to assign the extra indices
  - the first `𝓃` indices of the result will match this vector
  - the next `ℛᴼ - 𝓃` indices of the result will be trimmed
  - the remaining indices get the rolled results.

