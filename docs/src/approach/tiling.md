```
tiling(tiling_fn, window_width, data_seq)

tiling(fn, width, data; padding=nopadding)
tiling(fn, width, data; padding, atend=false)
```

`tiling` a function over windowed data repeatedly
applies that function to each adjacent data subsequence
that the moving window provides.  The length of
each subsequence is given by the width of the window.

The function is applied as if it gathers the data spanned
and consumes it all at once. 
The function is one that summarizes, condeneses,
abstracts, characterizes, or explores contiguous
subsequences shown by the moving window.

While the window is fully contained within the data,
each step (one tile) increments the indices of the current window:
`(start:finish)  ↦  (start+width:finish+width) == (finish+1:finish+width)`.
When advancing the window would carry the end of the window
beyond the end of the data, `tiling` is complete.

With N data values and a window of width W (W<=N),
the result from tiling will have no more than
`div(N, W)` values. There will be `rem(N, W)` left over (untiled)
values. Using the keyword `padding`, will pad the first or final (atend=true)
return value when `rem(N, W) != 0`.

arguments
- fn::Function:     summarizes, condenses windowed data
- width::Integer:   window breadth, counts covered elements.
- data::Vector:     the data over which the window moves.

keywords
- padding::Any=nopadding: the value place as filler.
- atend::Bool=false:      where to place the padding.

See also: [`padding`](padding.md), 
          [`atend`](atend.md),
          [`weighted`](weighted.md),
          [`datastreams`](datastreams.md)

