
#### these are the three foundational forms that run

```
running(window_func, datavec, width)

running(window_func, datavec, width; padding)

running(window_func, datavec, width; padding, padlast)
```

#### enhanced forms allow 2, 3, or 4 distinct data vectors

- they support summarizing functions that take 2, 3, or 4 args

```
running(window_func, datavec1, datavec2, width)

running(window_func, datavec1, datavec2, datavec3, width; padding)

running(window_func, datavec1, datavec2, datavec3, datavec4, width; padding, padlast)
```

#### given a matrix, the function is applied to each column
- a corresponding matrix is returned

```
running(window_func, datamat, width)

running(window_func, datamat, width; padding)

running(window_func, datamat, width; padding, padlast)
```



