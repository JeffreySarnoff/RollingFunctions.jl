
----

#### This package makes it easy to summarize windowed data.

#### A function is applied to successive data subsequences.

----

You give a summarizing function 𝐹𝑢𝑛𝑐, the data𝐷𝑎𝑡𝑎, and a window width 𝑆𝑝𝑎𝑛.  

The result  𝑅 is of length  𝑅ᴺ,   𝑅ᴺ = length(𝐷𝑎𝑡𝑎) - 𝑆𝑝𝑎𝑛 + 1.
- the result omits  𝑅ᴼ = 𝑆𝑝𝑎𝑛 - 1 indices that𝐷𝑎𝑡𝑎 uses.

----
----

#### _ways to get as many results as there are data values_

----

#### Use a vector of padding values with length  𝑅ᴼ

##### specify a padding vector (default is at the start)

- _here is the way to do that_
  - running(𝐹𝑢𝑛𝑐,𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = [<values>])
  - running(function, data, width; padding = [<values>])

##### specify the padding vector to be at the end

- _here is the way to do that_
  - running(𝐹𝑢𝑛𝑐,𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = [<values>], padlast = true)
  - running(function, data, width; padding = [<values>], padlast = true)

#### Use an empty vector 

##### this fills the  𝑅ᴼ indices by trimming

- _here is the way to do that_
  - running(𝐹𝑢𝑛𝑐,𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = eltype(𝐷𝑎𝑡𝑎)[])
  - running(function, data, width; padding = eltype(𝐷𝑎𝑡𝑎)[])

-trimming evaluates the window function over available data
  - trimmed window widths are less than the specified width

#### Use a vector of𝓃 padding values

- where1 <= 𝓃 <   𝑅ᴼ.

##### this both pads and trims to assign the initial indices

- the first𝓃 indices of the result will match this vector
- the next  𝑅ᴼ - 𝓃 indices of the result will be trimmed
- the remaining indices get the rolled results.


