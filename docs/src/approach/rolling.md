```
rolling(rolling_fn, window_width, data_seq)

rolling(fn, width, data; padding=nopadding)
rolling(fn, width, data; padding, atend=false)
```

`rolling` a function over windowed data repeatedly
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
beyond the end of the data, `rolling` is complete.

With N data values and a window of width W (W<=N),
the result from rolling will have no more than
`N-(W-1) == N-W+1` values.  W-1 values are consumed
in preparing to cover the first window.  The result
may have fewer values, it depends on whether or not
W divides N exactly.  To get a result of length N,
use the keyword `padding`.

arguments
- fn::Function:   summarizes, condenses windowed data
- width::Integer:   window breadth, counts covered elements.
- data::Vector:     the data over which the window moves.

keywords
- padding::Any=nopadding: the value place as filler.
- atend::Bool=false:     where to place the padding.

See also: [`padding`](padding.md), 
          [`atend`](atend.md),
          [`weighted`](weighted.md),
          [`datastreams`](datastreams.md)

