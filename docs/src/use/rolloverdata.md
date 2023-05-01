----

#### This package makes it easy to summarize windowed data.

#### A function is applied to successive data subsequences.

----

You give a summarizing function 𝐹𝑢𝑛𝑐, the data𝐷𝑎𝑡𝑎, and a window width 𝑆𝑝𝑎𝑛.  

The result    𝑅 is of length   𝑅ᴺ
-  𝑅ᴺ = length(𝐷𝑎𝑡𝑎) - 𝑆𝑝𝑎𝑛 + 1.
- the result omits 𝑅ᴼ = 𝑆𝑝𝑎𝑛 - 1 indices that𝐷𝑎𝑡𝑎 uses.

- _here is the way to do that_
   - rolling(𝐹𝑢𝑛𝑐,𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛)
   - rolling(function, data, width)

----
----

#### _ways to get as many results as there are data values_

----

#### Use a single, shared padding value

##### specify a padding value (default position is at the start)


- _here is the way to do that_
  - rolling(𝐹𝑢𝑛𝑐,𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = \<value\>)
  - rolling(function, data, width; padding = missing)
- this will fill the initial result values with the padding value
  - pads these values(result[1], .., result[pad_nindices])

##### specify padding to be at the end of the result

- _here is the way to do that_
   - rolling(𝐹𝑢𝑛𝑐,𝐷𝑎𝑡𝑎, 𝑆𝑝𝑎𝑛; padding = <value>, padlast = true)
   - rolling(function, data, width; padding = missing, padlast = true)
- this will fill the final result values with the padding value
  - pads these values(result[n-pad_nindices+1], .., result[n])
