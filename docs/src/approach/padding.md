```
   padding -- optional keyword argument
```

By definition, applying a windowed function over data
will result in fewer items than are in the original data.
To add the missing items, select a padding value using
the `padding` keyword argument e.g. `padding=missing`.

By default, padding is applied at the begining of the result.
- by default, the padding value is placed at the lowest indices
To apply padding at the end of the result, set `atend=true`.
- that way the padding value is placed at the highest indices
 
See also: [`atend`](atend.md),
          [`rolling`](rolling.md),
          [`tiling`](tiling.md),
          [`running`](running.md)
