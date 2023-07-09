
#### these are the three foundational forms that run

```
running(window_fn, datavec, width)

running(window_fn, datavec, width; padding)

running(window_fn, datavec, width; padding, atend)
```

#### enhanced forms allow 2, 3, or 4 distinct data vectors

- they support summarizing functions that take 2, 3, or 4 args

```
running(window_fn, datavec1, datavec2, width)

running(window_fn, datavec1, datavec2, datavec3, width; padding)

running(window_fn, datavec1, datavec2, datavec3, datavec4, width; padding, atend)
```

#### given a matrix, the function is applied to each column
- a corresponding matrix is returned

```
running(window_fn, datamat, width)

running(window_fn, datamat, width; padding)

running(window_fn, datamat, width; padding, atend)
```


When __running__ with a weighted window, 
special considerations apply. 
The initial (first, second ..) values are determined 
using a tapering of the weighted window's span.
This requires that the weights themselves
be tapered along with the determinative function that is rolled.
In this case, the weight subsequence is normalized
(sums to one(T)), and that reweighting is used with the
foreshortened window to taper that which rolls.
_see the docs_
