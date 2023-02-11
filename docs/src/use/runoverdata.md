
----

#### This package makes it easy to summarize windowed data.

#### A function is applied to successive data subsequences.

----

You give a summarizing function 𝐅𝐮𝐧𝐜, the data 𝐃𝐚𝐭𝐚, and a window span 𝐒𝐩𝐚𝐧.  

The result `ℛ` is of length `ℛᴺ`, ℛᴺ = length(𝐃𝐚𝐭𝐚) - 𝐒𝐩𝐚𝐧 + 1`.
- the result omits `ℛᴼ`, `ℛᴼ = 𝐒𝐩𝐚𝐧 - 1` indices into 𝐃𝐚𝐭𝐚.

----

#### _ways to get as many results as there are data values_

----

#### Use a vector of padding values with length `ℛᴼ`

##### specify a padding vector (default is at the start)

- _here is the way to do that_
  - `running(𝐅𝐮𝐧𝐜, 𝐃𝐚𝐭𝐚, 𝐒𝐩𝐚𝐧; padding = [<values>]`)
  - `running(function, data, window_span; padding = [<values>]`)

##### specify the padding vector to be at the end

- _here is the way to do that_
  - `running(𝐅𝐮𝐧𝐜, 𝐃𝐚𝐭𝐚, 𝐒𝐩𝐚𝐧; padding = [<values>], padlast = true`)
  - `running(function, data, window_span; padding = [<values>], padlast = true`)

#### Use an empty vector 

##### this fills the `ℛᴼ` indices by `trimming`

- _here is the way to do that_
  - `running(𝐅𝐮𝐧𝐜, 𝐃𝐚𝐭𝐚, 𝐒𝐩𝐚𝐧; padding = eltype(𝐃𝐚𝐭𝐚)[]`)
  - `running(function, data, window_span; padding = eltype(𝐃𝐚𝐭𝐚)[]`)

- `trimming` evaluates the window function over available data
  - trimmed window spans are less than the specified window_span

#### Use a vector of `𝓃` padding values

- where `1 <= 𝓃 < ℛᴼ`.

##### this both pads and trims to assign the initial indices

- the first `𝓃` indices of the result will match this vector
- the next `ℛᴼ - 𝓃` indices of the result will be trimmed
- the remaining indices get the rolled results.


