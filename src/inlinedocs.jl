"""
    RollingFunctions.jl

Apply functions over windows that advance through data.

See: [`rolling`](@ref),
     [`tiling`](@ref),
     [`running`](@ref),
     [`padding`](@ref),
     [`atend`](@ref),
     [`weighted`](@ref),
     [`safeweights`](@ref),
     [`datastreams`](@ref)

""" RollingFunctions

"""


```
    rolling(rolling_fn, window_width, data_seq)

rolling(fn, width, data; padding=nopadding)
    rolling(fn, width, data; padding, atend=false)

`rolling` a function over windowed data repeatedly
applies that function to each data subsequence
that the moving window provides.  The length of
each subsequence is given by the width of the window.

The function is applied as if it gathers the data spanned
and consumes it all at once. 
The function is one that summarizes, condeneses,
abstracts, characterizes, or explores 
subsequences shown by the moving window.

While the window is fully contained within the data,
each step (one roll) increments the indices of the current window:
`(start:finish)  ↦  (start+1:finish+1)`.
When advancing the window would carry the end of the window
beyond the end of the data, `rolling` is complete.

With N data values and a window of width W (W<=N),
the result from rolling will have no more than
`N-(W-1) == N-W+1` values.  W-1 values are consumed
in preparing to cover the first window.  The result
may have fewer values, it depends on whether or not
W divides N exactly.  To get a result of length N,
use the keyword `padding`.

arguments
- fn <: Function:   summarizes, condenses windowed data
- width::Integer:   window breadth, counts covered elements.
- data::Vector:     the data over which the window moves.

keywords
- padding::Any=nopadding: the value place as filler.
- atend::Bool=false:     where to place the padding.

See also: [`weighted`](@ref),
          [`tiling`](@ref),
          [`running`](@ref),
          [`padding`](@ref), 
          [`atend`](@ref),
          [`datastreams`](@ref)

""" rolling

"""
    tiling(fn, window_width, data_seq)

tiling(fn, width, data; padding=nopadding)
    tiling(fn, width, data; padding, atend=false) 

`tiling` applies a summarizing or condensing function (fn)
to all elements within the current window (seen simulataneously);
then advances the window ([start:finish]) by the **window_width**
 ([start+width:finish+width]), skipping over the prior window, 
to apply fn over the elements covered by the new window ...

- tiling(fn, width, data)
- tiling(fn, width, data; padding)
- tiling(fn, width, data; atend)
- tiling(fn, width, data; padding, atend)

arguments
- fn <: Function:   summarizes, condenses windowed data
- width::Integer:   window breadth, counts covered elements.
- data_seq::Vector: the data over which the window moves.

keywords
- padding::Any=nopadding: the value place as filler.
- atend::Bool=false:     where to place the padding.

See also: [`weighted`](@ref),
          [`rolling`](@ref),
          [`running`](@ref),
          [`padding`](@ref), 
          [`atend`](@ref),
          [`datastreams`](@ref)

""" tiling

"""
    running(fn, window_width, data_seq)

running(fn, width, data; padding=nopadding)
    running(fn, width, data; padding, atend=false)

`running` applies a summarizing or condensing function (fn)
to all elements within the current window (seen simulataneously);
then advances the window ([start:finish]) by **one index** ([start+1:finish+1])
to apply fn over the elements covered by the new window ...

`running` differs from `rolling`. When rolling() one may pad
values that otherwise would be dropped to obtain a result
of length that matches expectation or convienience.

Running() provides replacements for those dropped values
by tapering the width of the window as it moves from the start
[as it moves to the end] of the data sequence (see atend).

- running(fn, width, data)
- running(fn, width, data; atend=false)
- running(fn, width, data; atend=false)

arguments
- fn <: Function:   summarizes, condenses windowed data
- width::Integer:   window breadth, counts covered elements.
- data_seq::Vector: the data over which the window moves.

keywords
- padding::Any=nopadding: the value place as filler.
- atend::Bool=false:     where to place the padding.

See also: [`weighted`](@ref),
          [`rolling`](@ref),
          [`tiling`](@ref),
          [`padding`](@ref),
          [`atend`](@ref),
          [`datastreams`](@ref)

""" running

"""
    padding

By definition, applying a windowed function over data
will result in fewer items than are in the original data.
To add the missing items, select a padding value using
the `padding` keyword argument e.g. `padding=missing`.

By default, padding is applied at the begining of the result.
- by default, the padding value is placed at the lowest indices
To apply padding at the end of the result, set `atend=true`.
- that way the padding value is placed at the highest indices
 
See also: [`rolling`](@ref),
          [`tiling`](@ref),
          [`running`](@ref),
          [`atend`](@ref)

""" padding

"""
    atend

`atend` is a keyword argument that defaults to `false`.
- additional value[s] are placed at the start of the results.
using `atend = true`
- additional value[s] are placed at the end (highest indices).

By default, padding is applied at the begining of the result.
- the padding value is placed at the lowest indices
To apply padding at the end of the result, set `atend=true`.
- the padding value is placed at the highest indices

See also: [`rolling`](@ref),
          [`tiling`](@ref),
          [`running`](@ref),
          [`padding`](@ref)

""" atend

"""
    apply functions over windows into weighted data

`rolling`, `tiling`, and `running` all provide data weighting.

The functions for weighted data follow the unweighted function signatures.
- the weighting is given after the data, as the last positional arg

Weighting for a data vector is given as one of the subtypes of StatsBase.AbstractWeights

To use `myweights::Vector{<:Real}` as weights

- scale the values so they sum to 1.0 (or a few eps less than 1.0)
    - `myweights1 = LinearAlgebra.normalize(myweights, 1)` (ok)
    - `myweights1 = safeweights(myweights1)` (better)
- convert the values to StatsBase.AnalyticWeights
    - `weighting = AnalyticWeights(myweights1)`

----

See also: [`rolling`](@ref),
          [`tiling`](@ref),
          [`running`](@ref),
          [`safeweights`](@ref),
          [`datastreams`](@ref),
          [`StatsBase.AnalyticWeights`](@ref),
          [`StatsBase.ProbabilityWeights`](@ref),
          [`StatsBase.Weights`](@ref)

""" weighted

"""
    safeweights(<:AbstractVector{T})::AbstractVector{T}

ensures that the sum of the weights
- does not exceed 1
- approaches or is equal to 1

`one(T) >=` __`safesum`__ `> prevfloat(one(T), k)`
- safesum = sum(safeweights(weights))
- k <= ceil(1 + log10(wlength) + wlength^(5/16))
- wlength = length(weights)

See also: [`weighted`](@ref)

""" safeweights

"""
    datastreams

There are four ways to provide data
for `rolling`, `tiling`, or `running`.

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

See also: [`rolling`](@ref),
          [`tiling`](@ref),
          [`running`](@ref),
          [`weighted`](@ref)

""" datastreams

#=
    online help:

    RollingFunctions
    rolling
    tiling
    running
    padding
    atend
    weighted
    safeweights
    datastreams

=#

# end of inline docs


