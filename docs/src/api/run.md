
#### these are the three foundational forms that run

```
running(window_func, datavec, span)

running(window_func, datavec, span; padding)

running(window_func, datavec, span; padding, padlast)
```

#### enhanced forms allow 2, 3, or 4 distinct data vectors

- they support summarizing functions that take 2, 3, or 4 args

```
running(window_func, datavec1, datavec2, span)

running(window_func, datavec1, datavec2, datavec3, span; padding)

running(window_func, datavec1, datavec2, datavec3, datavec4, span; padding, padlast)
```

#### given a matrix, the function is applied to each column
- a corresponding matrix is returned

```
running(window_func, datamat, span)

running(window_func, datamat, span; padding)

running(window_func, datamat, span; padding, padlast)
```



