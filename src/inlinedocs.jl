"""
    RollingFunctions.jl

Apply functions through windows that advance over data.

See: [`rolling`](@ref),
     [`tiling`](@ref),
     [`running`](@ref)

""" RollingFunctions

"""
    rolling(fn, window_width, data_seq)

rolling(fn, width, data; padding=nopadding)
    rolling(fn, width, data; padding, atend=false) 

`rolling` applies a summarizing or condensing function (fn)
to all elements within the current window (seen simulataneously);
then advances the window ([start:finish]) by **one index** ([start+1:finish+1])
to apply fn over the elements covered by the new window ...

- rolling(fn, width, data)
- rolling(fn, width, data; padding)
- rolling(fn, width, data; atend)
- rolling(fn, width, data; padding, atend)

arguments
- fn <: Function:   summarizes, condenses windowed data
- width::Integer:   window breadth, counts covered elements.
- data_seq::Vector: the data over which the window moves.

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
          [`atend`](@ref)
     
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
          [`atend`](@ref)
     
""" running

"""
    padding
 
 By definition, applying a windowed function over data
 will result in fewer items than are in the original data.
 To add the missing items, select a padding value using
 the `padding` keyword argument e.g. `padding=missing`.
 
 By default, padding is applied at the begining of the result.
 - padding value is placed at the lowest indices
 To apply padding at the end of the result, set `atend=true`.
 - padding value is placed at the highest indices
 
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

@doc"""
    windows over weighted data

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

# end of inline docs

