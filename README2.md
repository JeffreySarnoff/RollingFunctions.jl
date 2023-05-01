
-----
This package supports two kinds of applicative windows sliding over sequential data.
- the sequential data (index ordered)  contains (**N**) values, here indexed 1:**N**.
- the operational window size (**W**) is given and **W** <= **N**. 

The familiar kind rolls over data and with each advance applies a function to the subsequence widthned by the window.  We call this approach a ***rolling** function*.
- a rolling max-of-n or mean-of-n taken over a data sequence. 
- a windowed volatility calculation applied over a time series.
> vanilla rolling functions take
> a sequence of **N** (length) values and a window width **W** (count of indicies).
> and return
> a sequence of **N - W + 1** elements (calculated summary values)

----
We offer a second kind of applicative window; one that preserves the length of the given data sequence in the length of the value sequence that results.  We call this approach a  ***running** function*.
- for most of the data, the corresponding rolling function applies
- to obtain the remaining values, a tapering version of the function is applied.
> vanilla running functions take
> a sequence of **N** (length) values and a window width **W** (count of indicies).
> and return
> a sequence of **N** elements (calculated summary values)

----
There is more :)  [see the README](https://github.com/JeffreySarnoff/RollingFunctions.jl#rollingfunctionsjl)
- arbitrary and normalized weights may be used within a window
- there are an assortment of predefined rolling and running functions
- you may define your own rolling / running functions easily
- covariance and correlation is available for paired data sequences
- you may define your own rolling / running functions of two data streams

