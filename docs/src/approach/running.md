```
    running(running_fn, window_width, data_seq)

running(running_fn, window_width, data_seq; atend=false)
```

`running` applies a summarizing or condensing function (fn)
to all elements within the current window (seen simulataneously);
then advances the window ([start:finish]) by **one index** ([start+1:finish+1])
to apply fn over the elements covered by the new window ...

`running` differs from `rolling`. When rolling() one may pad
values that otherwise would be dropped to obtain a result
of length that matches expectation or convienience.

Running() provides replacements for those dropped values
by tapering the width of the window as it moves from the start
[as it moves to the end] of the data sequence (see atend).


|                                               |
|:----------------------------------------------|
|    running(fn, width, data)                   |
|    running(fn, width, data; atend)            |
||                                              |

arguments
- fn <: Function:     summarizes, condenses windowed data
- width::Integer:     window breadth, counts covered elements.
- data_seq::Vector:   the data over which the window moves.

keywords
- atend::Bool=false:  where to place the tapering.

See also: [`atend`](atend.md),
          [`weighted`](weighted.md),
          [`datastreams`](datastreams.md)
