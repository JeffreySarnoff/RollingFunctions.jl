This package supports distinct approaches to appling a 
moving window function over data sequences.
The core design develops each approach in the same way.
This simplifies development, mitigates unexpected corner cases,
and improves reliability.

At present, there are three approachs: 
[`running`](..\approach\running.md), 
[`tiling`](..\approach\tiling.md), and 
[`rolling`](..\approach\rolling.md).

We use two keyword arguments, both are optional:
[`padding`](..\approach\padding.md), and 
[`atend`](..\approach\atend.md).

This allows four call states for each approach
```
<approach>(windowed_fn, window_width, data_seq)
<approach>(windowed_fn, window_width, data_seq; padding=pad)
<approach>(windowed_fn, window_width, data_seq; atend=true)
<approach>(windowed_fn, window_width, data_seq; padding=pad, atend=true)
```

For every approach, there are four data configurations:

- one vector
- two vectors (of equal length)
- three vectors (of equal length)
- a matrix of 2 or more columns

For every approach, the data sequence may be weighted. 
There are three ways to introduce weights:

- _for any data configuration_
  - as a vector where isa(vector, StatsBase.AbstractWeights)
- _for multiple data sequences or a data matrix_
  - as a vector where isa(vector, Vector{<:StatsBase.AbstractWeights})
  - as a matrix where isa(matrix, <:Matrix{Number})

