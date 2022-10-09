## Window Representations

Multiple structs are used internally to model the constructive details and applicative rules for a Window over client data.

```
@kwdef mutable struct BasicWindow
    const length::Int              # span of contiguous elements
    
    const onlywhole::Bool=true     # prohibit partial windows
    const drop_first::Bool=true    # omit results at start¹, if needed²
    const drop_final::Bool=false   # omit results at finish¹, if needed²

    direct::Bool=true              # process from low indices to high
end

#=
    ¹ "at start"  is from the lowest  indices where `direct == true`
                  is from the highest indices where `direct == false`
      "at finish" is from the highest indices where `direct == true`
                  is from the lowest  indices where `direct == false`
                  
    ² "if needed" is true if and only if `onlywhole == true` and
                  `!iszero(rem(data_length, window_length))`
=#
```
```
@kwdef struct Window{T}
    const length::Int              # span of contiguous elements
    
    offset_first::Int=0            # start  at index offset_first + 1
    offset_final::Int=0            # finish at index length - offset_final + 1

    pad_first::Int=0               # pad with this many paddings at start
    pad_final::Int=0               # pad with this many padding at end
    padding::T=nothing             # use this as the value with which to pad

    const direct::Bool=true        # process from low indices to high
    const onlywhole::Bool=true     # prohibit partial windows
 
    const drop_first::Bool=true    # omit results at start, if needed
    const drop_final::Bool=false   # omit results at finish, if needed

    const drop_first::Bool=true    # omit results at start, if needed
    const drop_final::Bool=false   # omit results at finish, if needed

    trim_first::Bool=false         # use partial windowing over first elements, if needed
    trim_final::Bool=false         # use partial windowing over final elements, if needed
end

# is indexing to be offset
notoffset(w::SimpleWindow) = iszero(w.offset_first) && iszero(w.offset_final)
isoffset(w::SimpleWindow) = !notoffset(w)

# is there to be padding
notpadded(w::SimpleWindow) = iszero(w.pad_first) && iszero(w.pad_final)
ispadded(w::SimpleWindow) = !notpadded(w)

# are only complete window spans to be allowed
onlywhole(w::SimpleWindow) = w.onlywhole
allowpartial(w::SimpleWindow) = !onlywhole(w)

# is trimmed windowing to be allowed
maytrim(w::SimpleWindow) = allowspartials(w) && (w.trim_first ⊻ w.trim_last)
  # _It is an error to select both `trim_first` and `trim_final`_

# is the information processed in direct (lower index to higher index) order
isdirect(w::SimpleWindow) = w.direct
```

