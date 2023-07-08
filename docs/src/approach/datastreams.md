```
    datastreams

There are four ways to provide data
for `rolling`, `tiling`, or `running`.
```

- data sources [usually] have a numeric eltype

(a) a unary function over windows into one vector

(b) a binary function over matching windows into two vectors

(c) a three arg function over windows into three vectors

(d) a unary function windowed over each column of a matrix

- each column of the matrix is treated as a simple vector
- there is no current provision for n-ary summary functions
- the same unary function is applied over each column
- the same windowing is applied to each column

create a window-ready function using constitutive applicands

`fn(v1,v2,v3,v4,v5,v6) = fnab(fna(v1, v2, v3), fnb(v3, v4, v5))`

See also: [`rolling`](rolling.md),
          [`tiling`](tiling.md),
          [`running`](running.md)
