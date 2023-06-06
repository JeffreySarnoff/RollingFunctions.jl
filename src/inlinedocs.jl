"""
    rolling(fn, width, data; padding=nopadding, atend=false)

`rolling` repeatedly moves the window one index forward.

- rolling(fn, width, data)
- rolling(fn, width, data; padding)
- rolling(fn, width, data; padding, atend=false)

```
rolling(      (a)->fn(a),       width, adata)
rolling(    (a,b)->fn(a,b),     width, adata, bdata)
rolling(  (a,b,c)->fn(a,b,c),   width, adata, bdata, cdata)
rolling((a,b,c,d)->fn(a,b,c,d), width, adata, bdata, cdata, ddata)

rolling(row->fn(row), width, datamatrix)
rolling(row->fn(row), width, datamatrix; padding, atend=false)
```
The data is given as 1, 2, 3, or 4 vectors or as a matrix.

With padding, there will be width-1 padded values.

See also: [`weighted`](@ref), 
          [`windows_with_vectors`](@ref), [`windows_with_matrices`](@ref),
          [`padding`](@ref), [`atend`](@ref),
          [`running`](@ref), [`tiling`](@ref)

"""
rolling

"""
    windows_with_matrices

Rolling (running, tiling) a windowed function over a matrix
rolls (runs, tiles) that function over windows on each column
independently.

""" windows_with_matrices

"""
    windows_with_vectors

Rolling (running, tiling) a windowed function over 2,3,[4] vectors
rolls (runs, tiles) that n-ary function over windows on the n vectors
as if they were zipped together (simultaneously).

""" windows_with_vectors

"""
    running(fn, width, data)

`running` repeatedly moves the window one index forward.

`running` tapers the width as it nears the end of the data.
- there is no padding, tapered results are used instead.

```
running(    (a)->fn(a),     width, adata)
running(  (a,b)->fn(a,b),   width, adata, bdata)
running((a,b,c)->fn(a,b,c), width, adata, bdata, cdata)

running(row->fn(row), width, datamatrix)
```
The data is given as 1, 2, or 3 vectors or as a matrix.

See also: [`weighted`](@ref), [`weighted_running`](@ref),
          [`tapering`](@ref), [`rolling`](@ref), [`tiling`](@ref)

"""
running

"""
    tiling(fn, width, data; padding=nopadding, atend=false)

`tiling` repeatedly moves the window just beyond its current end.

- tiling(fn, width, data)
- tiling(fn, width, data; padding)
- tiling(fn, width, data; padding, atend=false)

```
tiling(    (a)->fn(a),     width, adata)
tiling(  (a,b)->fn(a,b),   width, adata, bdata)
tiling((a,b,c)->fn(a,b,c), width, adata, bdata, cdata)

tiling(row->fn(row), width, datamatrix)
tiling(row->fn(row), width, datamatrix; padding, atend=false)
```
The data is given as 1, 2, or 3 vectors or as a matrix.

With padding, there will be 0 (if an exact fit) or 1 padded value.

See also: [`weighted`](@ref), [`weighted_tiling`](@ref),
          [`padding`](@ref), [`atend`](@ref),
          [`rolling`](@ref), [`running`](@ref)

"""
tiling

"""
    weighted

Windowed data may be weighted before the window function is applied.

Weights may be used with `running`, `rolling`, or `tiling`.
The function signatures' positional arguments are extended
     by giving the weights as the last positional argument[s].

`rolling(fn, width, data, weights; padding=nopadding, atend=false)`

Where two data sources are used, two weights must be used.
`rolling(fn, width, data1, data2, weights1, weights2)`

The weights are `StatsBase.Weights`; generally one wants normalized weights.

Use `fast_normalize_weights(weights)` or `normalize_weights(weights)`. 

`length(weights) == width` is a requirement

"""
weighted

"""
    padding
 
 By definition, applying a windowed function over data
 will result in fewer items than are in the original data.
 To add the missing items, select a padding value using
 the `padding` keyword argument e.g. `padding=missing`.
 
 By default, padding is applied at the begining of the result.
 - padding value is placed at the lowest indices
 To apply padding at the end of the result, set `atend=true`.
 - padding value is placed at the highest indices
 
 See also: [`rolling`](@ref), [`atend`](@ref)
 
"""
padding

"""
    tapering
  
  By definition, applying a windowed function over data
  will result in fewer items than are in the original data.
  
  `tapering` is a way to add the dropped items using the data itself.
  
  By default, tapered values are placed at the start of the result.
  - the tapered values are placed at the lowest indices
  To place tapered values at the start of the result, set `atend=true`.
  - the tapered values are placed at the highest indices
  
  See also: [`rolling`](@ref), [`atend`](@ref)
  
"""
tapering

"""
    atend
  
  `atend` is a keyword argument that defaults to `false`.
  - additional value[s] are placed at the start of the results.
  using `atend = true`
  - additional value[s] are placed at the end (highest indices).
  
  By default, padding is applied at the begining of the result.
  - the padding value is placed at the lowest indices
  To apply padding at the end of the result, set `atend=true`.
  - the padding value is placed at the highest indices
  
"""
atend

"""
    __RollingFunctions__
 
 see: [`rolling`](@ref), [`running`](@ref), [`tiling`](@ref)
"""
RollingFunctions

# end of inline docs

