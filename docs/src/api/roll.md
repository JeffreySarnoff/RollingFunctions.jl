
#### these are the three foundational forms that roll

```
rolling(window_func, datavec, span)

rolling(window_func, datavec, span; padding)

rolling(window_func, datavec, span; padding, padlast)
```

#### enhanced forms allow 2, 3, or 4 distinct data vectors

- they support summarizing functions that take 2, 3, or 4 args

```
rolling(window_func, datavec1, datavec2, span)

rolling(window_func, datavec1, datavec2, datavec3, span; padding)

rolling(window_func, datavec1, datavec2, datavec3, datavec4, span; padding, padlast)
```

#### given a matrix, the function is applied to each column
- a corresponding matrix is returned

```
rolling(window_func, datamat, span)

rolling(window_func, datamat, span; padding)

rolling(window_func, datamat, span; padding, padlast)
```


