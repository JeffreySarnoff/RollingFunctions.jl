"""
    rolling(func, winwidth, data; padding=nopadding, atend=false)

`rolling` repeatedly moves the window one index forward.

- rolling(func, win\\_width, data)
- rolling(func, win\\_width, data; padding)
- rolling(func, win\\_width, data; padding, atend=false)

```
rolling(    (a)->fn(a),     width, adata)
rolling(  (a,b)->fn(a,b),   width, adata, bdata)
rolling((a,b,c)->fn(a,b,c), width, adata, bdata, cdata)

rolling(row->fn(row), width, datamatrix)
rolling(row->fn(row), width, datamatrix; padding, atend=false)
```
The data is given as 1, 2, or 3 vectors or as a matrix.

With padding, there will be width-1 padded values.

See also: [`padding`](@ref), [`atend`](@ref), [`running`](@ref), [`tiling`](@ref)

""" rolling

"""
    running(func, winwidth, data)

`running` repeatedly moves the window one index forward.

`running` tapers the winwidth as it nears the end of the data.
- there is no padding, tapered results are used instead.

```
running(    (a)->fn(a),     width, adata)
running(  (a,b)->fn(a,b),   width, adata, bdata)
running((a,b,c)->fn(a,b,c), width, adata, bdata, cdata)

running(row->fn(row), width, datamatrix)
```
The data is given as 1, 2, or 3 vectors or as a matrix.

See also: [`taper`](@ref), [`rolling`](@ref), [`tiling`](@ref)

""" running

"""
    tiling(func, winwidth, data; padding=nopadding, atend=false)

`tiling` repeatedly moves the window just beyond its current end.

- tiling(func, win\\_width, data)
- tiling(func, win\\_width, data; padding)
- tiling(func, win\\_width, data; padding, atend=false)

```
tiling(    (a)->fn(a),     width, adata)
tiling(  (a,b)->fn(a,b),   width, adata, bdata)
tiling((a,b,c)->fn(a,b,c), width, adata, bdata, cdata)

tiling(row->fn(row), width, datamatrix)
tiling(row->fn(row), width, datamatrix; padding, atend=false)
```
The data is given as 1, 2, or 3 vectors or as a matrix.

With padding, there will be 0 (if an exact fit) or 1 padded value.

See also: [`padding`](@ref), [`atend`](@ref), [`rolling`](@ref), [`running`](@ref)

""" tiling

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
    taper
  
  By definition, applying a windowed function over data
  will result in fewer items than are in the original data.
  
  `tapering` is a way to add the dropped items using the data itself.
  
  By default, tapered values are placed at the start of the result.
  - the tapered values are placed at the lowest indices
  To place tapered values at the start of the result, set `atend=true`.
  - the tapered values are placed at the highest indices
  
  See also: [`rolling`](@ref), [`atend`](@ref)
  
"""
taper

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
""" RollingFunctions

# end of inline docs

