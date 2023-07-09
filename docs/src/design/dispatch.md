#### __Simplifying Dispatch__

----
##### unweighted and weighted

```
<approach>(windowed_fn, window_width, data_seq;
                    padding=pad, atend=true)

<approach>(windowed_fn, window_width, data_seq, weighting;
                    padding=pad, atend=true)
```
----

#### unpadded, padded at start, padded at end
##### _unweighted_
```
<approach>(windowed_fn, window_width, data_seq)

<approach>(windowed_fn, window_width, data_seq,
                    padding)

<approach>(windowed_fn, window_width, data_seq,
                    padding, atend)
```

##### _weighted_

```
<approach>(windowed_fn, window_width, data_seq, weighting)

<approach>(windowed_fn, window_width, data_seq, weighting,
                    padding)

<approach>(windowed_fn, window_width, data_seq, weighting,
                    padding, atend)
```

