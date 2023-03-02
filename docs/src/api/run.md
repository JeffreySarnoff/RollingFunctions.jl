
#### these are the three foundational forms that run

```
running(window_func, datavec, window_span)

running(window_func, datavec, window_span; padding)

running(window_func, datavec, window_span; padding, padlast)
```

#### enhanced forms allow 2, 3, or 4 distinct data vectors

- they support summarizing functions that take 2, 3, or 4 args

```
running(window_func, datavec1, datavec2, window_span)

running(window_func, datavec1, datavec2, datavec3, window_span; padding)

running(window_func, datavec1, datavec2, datavec3, datavec4, window_span; padding, padlast)
```

#### given a matrix, the function is applied to each column
- a corresponding matrix is returned

```
running(window_func, datamat, window_span)

running(window_func, datamat, window_span; padding)

running(window_func, datamat, window_span; padding, padlast)
```



