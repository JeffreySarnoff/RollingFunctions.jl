## rolling functions over windowed data

- basic rolling
   - given a data sequence of N elements
   - using a data window that widths S indices
   - one obtains N - S + 1 result values

- padded rolling
   - given a data sequence of N elements
   - using a data window that widths S indices
   - one obtains  N - S + 1 result values
   - and provides S - 1 elements that pad

### `rolling` is built from three internal functions

- basic_rolling
   - the result has fewer elements than the data has

- padfirst_rolling
   - the padding elements occupy the lowest indices of the result

- padfinal_rolling
   - the padding elements occupy the highest indices of the result

#### unweighted rolling

```
function rolling(fn1, width, data; padding, atend)

    if padding === nopadding
       basic_rolling(fn1, width, data)
    elseif !atend
       padfirst_rolling(fn1, width, data, padding)
    else
       padfinal_rolling(fn1, width, data, padding)
    end

end
```

#### weighted rolling

```
function rolling(fn1, width, data, weights; padding, atend)

    if padding === nopadding
       basic_rolling(fn1, width, data, weights)
    elseif !atend
       padfirst_rolling(fn1, width, data, weights, padding)
    else
       padfinal_rolling(fn1, width, data, weights, padding)
    end

end
```


### processing

| unweighted |            |
|------------|:----------:|
| the current window on the data is obtained | `current_data` |
| the function is applied to the `current_data`  |  `rolling_value` |



| with weights |            |
|--------------|:----------:|
| the current window on the data is obtained | `current_data` |
| the `current_data` is scaled by the weights |  `weighted_data` |
| the function is applied to the `weighted_data`  |  `rolling_value` |

#### additional coverage

- There are similar implementations for functions of 2, 3 arguments.

```
function rolling(fn2, width, data1, data2; 
                padding, atend)

    if padding === nopadding
       basic_rolling(fn2, width, data1, data2)
    elseif !atend
       padfirst_rolling(fn2, width, data1, data2, padding)
    else
       padfinal_rolling(fn2, width, data1, data2, padding)
    end

end
```

```
function rolling(fn2, width, data1, data2, weights1, weights2;
                 padding, atend)

    if padding === nopadding
       basic_rolling(fn2, width, data1, data2,
                                weights1, weights2)
    elseif !atend
       padfirst_rolling(fn2, width, data1, data2, 
                                   weights1, weights2, padding)
    else
       padfinal_rolling(fn2, width, data1, data2,
                                   weights1, weights2, padding)
    end

end
```

----

----


| signatures |  returns   |
|------------|------------|
| fn1(x)     |  scalar    |
| fn2(x,y)   |  scalar    |
| fn3(x,y,z) |  scalar    |

