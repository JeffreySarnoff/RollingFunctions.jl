#### for brevity

- fn1(x)        is a function of 1 argument,  returns a scalar
- fn2(x, y)     is a function of 2 arguments, returns a scalar
- fn3(x, y, z)  is a function of 3 arguments, returns a scalar

```
const AV  = AbstractVector
const PVD = nopadding # padding[value]_default
const PLD = false # atend_default
```

#### these are the three foundational forms that roll

```
rolling(fn1, width, data1::V) where {V<:AV}

rolling(fn1, width, data1::V;
        padding=PVD) where {V<:AV}

rolling(fn1, width, data1::V;
        padding=PVD, atend=PLD) where {V<:AV}
```

#### enhanced forms allow two or three distinct data vectors

- they support summarizing functions that take 2 or 3  args

```
rolling(fn2, width, data1::V, data2::V) where {V<:AV}

rolling(fn2, width, data1::V, data2::V;
        padding=PVD) where {V<:AV}

rolling(fn2, width, data1::V, data2::V;
        padding=PVD, atend=PLD) where {V<:AV}
```

```
rolling(fn3, width, data1::V, data2::V, data3::V) where {V<:AV}

rolling(fn3, width, data1::V, data2::V, data3::V;
        padding=PVD) where {V<:AV}

rolling(fn3, width, data1::V, data2::V, data3::V;
        padding=PVD, atend=PLD) where {V<:AV}
```


#### given a matrix, the function is applied to each column
- a corresponding matrix is returned

```
rolling(fn1, datamat, width)

rolling(fn1, datamat, width; padding)

rolling(fn1, datamat, width; padding, atend)
```


