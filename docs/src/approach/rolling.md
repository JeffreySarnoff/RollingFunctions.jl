

```
rolling(rolling_fn, window_width, data_seq)

rolling(rolling_fn, window_width, data_seq;
        padding=nopadding, atend=false)
```

One step in `rolling` applies a summarizing, condensing, or
exploring function to the data the current window covers.

While the window is fully contained within the data_seq,
each step increments the indices of the current window:
`(start:finish)  ↦  (start+1:finish+1)`.

When advancing the window would carry the end of the window
beyond the end of the data_seq, basic `rolling` is complete.

- `rolling` allows two keyword args (`padding` and `atend`).
   - `padding` (defaults to `nopadding`)
   - `atend` (defaults to `false`)

|                                               |
|:----------------------------------------------|
|    rolling(fn, width, data)                   |
|    rolling(fn, width, data; padding)          |
|    rolling(fn, width, data; atend)            |
|    rolling(fn, width, data; padding, atend)   |
|                                               |

See also: [`padding`](padding.md), 
          [`atend`](atend.md),
          [`weighted`](weighted.md),
          [`datastreams`](datastreams.md)

