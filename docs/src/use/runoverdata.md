
----

#### This package makes it easy to summarize windowed data.

#### A function is applied to successive data subsequences.

----

You give a summarizing function 𝐹𝑢𝑛𝑐, the data 𝐷𝑎𝑡𝑎, and a window span 𝑆𝑝𝑎𝑛.  

The result ℛ is of length ℛᴺ,  ℛᴺ = length( 𝐷𝑎𝑡𝑎) - 𝑆𝑝𝑎𝑛 + 1.
- the result omits ℛᴼ, ℛᴼ = 𝑆𝑝𝑎𝑛 - 1 indices into 𝐷𝑎𝑡𝑎.

----

#### _ways to get as many results as there are data values_

----

#### Use a vector of padding values with length ℛᴼ

##### specify a padding vector (default is at the start)

- _here is the way to do that_
  - running(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = [<values>])
  - running(function, data, window_span; padding = [<values>])

##### specify the padding vector to be at the end

- _here is the way to do that_
  - running(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = [<values>], padlast = true)
  - running(function, data, window_span; padding = [<values>], padlast = true)

#### Use an empty vector 

##### this fills the ℛᴼ indices  by trimmingg

- _here is the way to do that_
  - running(𝐹𝑢𝑛𝑐, 𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = eltype( 𝐷𝑎𝑡𝑎)[])
  - running(function, data, window_span; padding = eltype( 𝐷𝑎𝑡𝑎)[])

-trimming evaluates the window function over available data
  - trimmed window spans are less than the specified window_span

#### Use a vector of𝓃 padding values

- where1 <= 𝓃 <  ℛᴼ.

##### this both pads and trims to assign the initial indices

- the first𝓃 indices of the result will match this vector
- the next ℛᴼ - 𝓃 indices of the result will be trimmed
- the remaining indices get the rolled results.


