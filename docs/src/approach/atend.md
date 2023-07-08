```
    atend -- optional keyword argument
```

`atend` is a keyword argument that defaults to `false`.
- additional value[s] are placed at the start of the results.
using `atend = true`
- additional value[s] are placed at the end (highest indices).

By default, padding is applied at the begining of the result.
- the padding value is placed at the lowest indices
To apply padding at the end of the result, set `atend=true`.
- the padding value is placed at the highest indices

See also: [`padding`](padding.md),
          [`rolling`](rolling.md),
          [`tiling`](tiling.md),
          [`running`](running.md)
