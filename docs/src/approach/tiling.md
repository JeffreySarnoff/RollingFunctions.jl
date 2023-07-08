```
    tiling(fn, window_width, data_seq)

tiling(fn, width, data; padding=nopadding)
    tiling(fn, width, data; padding, atend=false) 
```

`tiling` applies a summarizing or condensing function (fn)
to all elements within the current window (seen simulataneously);
then advances the window ([start:finish]) by the **window_width**
 ([start+width:finish+width]), skipping over the prior window, 
to apply fn over the elements covered by the new window ...

|                                               |
|:----------------------------------------------|
|    tiling(fn, width, data)                    |
|    tiling(fn, width, data; padding)           |
|    tilling(fn, width, data; atend)            |
|    tiling(fn, width, data; padding, atend)    |
|                                               |

arguments
- fn <: Function:   summarizes, condenses windowed data
- width::Integer:   window breadth, counts covered elements.
- data_seq::Vector: the data over which the window moves.

keywords
- padding::Any=nopadding: the value place as filler.
- atend::Bool=false:     where to place the padding.

See also: [`padding`](@ref), 
          [`atend`](@ref),
          [`weighted`](weighted.md),
          [`rolling`](rolling.md),
          [`running`](running.md),
          [`datastreams`](datastreams.md)
