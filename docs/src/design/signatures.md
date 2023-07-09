##### __Positional Signatures__

###### _each approach subsumes 64 signatures_

- With 2 keyword args, there are 4 positional signatures (one for each state shown in [approach](approach.md)).
- With the 4 data configurations that becomes 4x4 = 16 signatures.
- With the 3 ways to weight + unweighted this gives 16x4 = 64 signatures.

###### _enfolding dispatch_

_unweighted_
```
function <approach>(windowed_fn, window_width, data_seq;
                    padding=pad, atend=true)
  if !atend # the common case
    if padding === nopadding # the default case
      <approach>(windowed_fn, window_width, data_seq)
    else
      <approach>(windowed_fn, window_width, data_seq, padding)
    end
  else
    if padding === nopadding # the default case
      <approach>(windowed_fn, window_width, data_seq, atend)
    else
      <approach>(windowed_fn, window_width, data_seq, padding, atend)
    end
  end
end
```

_weighted_
```
function <approach>(windowed_fn, window_width, data_seq, weighting;
                    padding=pad, atend=true)
  if !atend # the common case
    if padding === nopadding # the default case
      <approach>(windowed_fn, window_width, data_seq, weighting)
    else
      <approach>(windowed_fn, window_width, data_seq, weighting, padding)
    end
  else
    if padding === nopadding # the default case
      <approach>(windowed_fn, window_width, data_seq, weighting, atend)
    else
      <approach>(windowed_fn, window_width, data_seq, weighting, padding, atend)
    end
  end
end
```

