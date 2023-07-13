```
running(running_fn, window_width, data_seq)

running(fn, width, data; padding=nopadding)
running(fn, width, data; padding, atend=false)
```

`running` a function over windowed data repeatedly
applies that function to each overlapping data subsequence
that the moving window provides.  The length of
each subsequence is given by the width of the window.

The function is applied as if it gathers the data spanned
and consumes it all at once. 
The function is one that summarizes, condeneses,
abstracts, characterizes, or explores 
subsequences shown by the moving window.

While the window is fully contained within the data,
each step (one roll) increments the indices of the current window:
`(start:finish)  ↦  (start+1:finish+1)`.
When advancing the window would carry the end of the window
beyond the end of the data, `running` uses __tapering__.

To fill in the results where the window would be incomplete
(where there is less data remaining than the window width),
the function is applied to successively fewer data values.
For functions that are undefined over a single value
(e.g. skewness, covariance), the result of the final taper
will be NaN unless you specify a `padding` value.

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


