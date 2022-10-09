using Base: @kwdef

abstract type AbstractWindow end

@kwdef mutable struct BasicWindow <: AbstractWindow
    const length::Int              # span of contiguous elements
    const tilespan::Int=1          # span for tile (1 is untiled)
    
                                   # >> it is an error to select both <<
    const drop_first::Bool=true    # omit results at start¹, if needed²
    const drop_final::Bool=false   # omit results at finish¹, if needed²

    const direct::Bool=true        # process from low indices to high
end

@kwdef mutable struct TaperedWindow <: AbstractWindow
    const length::Int              # span of contiguous elements
    const tilespan::Int=1          # span for tile (1 is untiled)
    
                                   # >> it is an error to select both <<
    const trim_first::Bool=true    # use partial windowing over first elements, if needed
    const trim_final::Bool=false   # use partial windowing over final elements, if needed

    const direct::Bool=true        # process from low indices to high
end

@kwdef mutable struct PaddedWindow{T} <: AbstractWindow
    const length::Int              # span of contiguous elements
    const tilespan::Int=1          # span for tile (1 is untiled)
    
                                   # >> it is an error to select both <<
    const pad_first::Bool=true     # use partial windowing over first elements, if needed
    const pad_final::Bool=false    # use partial windowing over final elements, if needed
    const padding::T=missing       # the value with which to pad

    const direct::Bool=true        # process from low indices to high
end

@kwdef mutable struct OffsetWindow{W<:AbstractWindow} <: AbstractWindow
    window::W
                                   # >> setting both is supported <<
    offset_first::Int=0            # start  at index (offset_first + 1)
    offset_final::Int=0            # finish at index (length - offset_final)
end

@kwdef mutable struct WeightedWindow{W<:AbstractWindow,T} <: AbstractWindow
    window::W                      # struct annotated above
 
    weights::Vector{T}           # the weights collected
end

# >> weightings are checked to ensure they sum to 1

@kwdef mutable struct OffsetWeightedWindow{W<:AbstractWindow,T} <: AbstractWindow
    window::W
                                   # >> setting both is supported <<
    offset_first::Int=0            # start  at index (offset_first + 1)
    offset_final::Int=0            # finish at index (length - offset_final)
    
    weights::Vector{T}           # the weights collected
end

BasicWindow(length::Int) = BasicWindow(; length)
BasicWindow(length::Int, tilespan::Int) = BasicWindow(; length, tilespan)
function BasicWindow(length::Int, tilespan::Int=1; drop_first=true, drop_final=false, direct=true)
    if drop_first drop_final = false end
    if drop_final drop_first = false end
    BasicWindow(; length, tilespan, drop_first, drop_final, direct)
end

TaperedWindow(length::Int) = TaperedWindow(; length)
TaperedWindow(length::Int, tilespan::Int) = TaperedWindow(; length, tilespan)
function TaperedWindow(length::Int, tilespan::Int=1; trim_first=true, trim_final=false, direct=true)
    if trim_first trim_final = false end
    if trim_final trim_first = false end
    TaperedWindow(; length, tilespan, trim_first, trim_final, direct)
end

PaddedWindow(length::Int) = PaddedWindow(; length)
PaddeddWindow(length::Int, tilespan::Int) = PaddedWindow(; length, tilespan)
function PaddedWindow(length::Int, tilespan::Int=1; pad_first=true, pad_final=false, padding::T=missing, direct=true) where {T}
    if pad_first pad_final = false end
    if pad_final pad_first = false end
    PaddedWindow(; length, tilespan, pad_first, pad_final, padding, direct)
end

const FlatWindow = Union{BasicWindow, TaperedWindow, PaddedWindow}
const NestedWindow = Union{OffsetWindow, WeightedWindow, OffsetWeightedWindow}
const WeightsWindow = Union{WeightedWindow, OffsetWeightedWindow}
const OffsetsWindow = Union{OffsetWindow, OffsetWeightedWindow}

function WeightedWindow(@nospecialize(window::W), weights::Vector{T}) where {T, W<:FlatWindow}
    window.length == length(weights) || throw(ArgumentError("length of window ($(window.length)) must match length of weights ($(length(weights))"))
    WeightedWindow(; window, weights)
end

    

winlength(@nospecialize(w::FlatWindow)) = w.length
winlength(@nospecialize(w::NestedWindow)) = w.window.length

tilesize(@nospecialize(w::FlatWindow)) = w.tilesize
tilesize(@nospecialize(w::NestedWindow)) = w.window.tilesize

isdirect(@nospecialize(w::FlatWindow)) = w.direct
isdirect(@nospecialize(w::NestedWindow)) = w.window.direct

trims(@nospecialize(w::TaperedWindow)) = (w.trim_first, w.trim_final)
trims(@nospecialize(w::WeightedWindow{TaperedWindow})) = trims(w.window)
trims(@nospecialize(w::OffsetWindow{TaperedWindow})) = trims(w.window)
trims(@nospecialize(w::OffsetWeightedWindow{TaperedWindow})) = trims(w.window)

drops(@nospecialize(w::BasicWindow)) = (w.drop_first, w.drop_final)
drops(@nospecialize(w::WeightedWindow{BasicWindow})) = drops(w.window)
drops(@nospecialize(w::OffsetWindow{BasicWindow})) = drops(w.window)
drops(@nospecialize(w::OffsetWeightedWindow{BasicWindow})) = drops(w.window)

pads(@nospecialize(w::PaddedWindow)) = (w.pad_first, w.pad_final)
pads(@nospecialize(w::WeightedWindow{PaddedWindow})) = pads(w.window)
pads(@nospecialize(w::OffsetWindow{PaddedWindow})) = pads(w.window)
pads(@nospecialize(w::OffsetWeightedWindow{PaddedWindow})) = pads(w.window)

padding(@nospecialize(w::PaddedWindow)) = w.padding
padding(@nospecialize(w::WeightedWindow{PaddedWindow})) = padding(w.window)
padding(@nospecialize(w::OffsetWindow{PaddedWindow})) = padding(w.window)
padding(@nospecialize(w::OffsetWeightedWindow{PaddedWindow})) = padding(w.window)

weighting(@nospecialize(w::WeightsWindow)) = w.weighting
offsets(@nospecialize(w::OffsetsWindow)) = (w.offset_first, w.offset_final)

# the weight function is optional
# if you specify a weight function, the `weighting` will be autogenerated
# >> weightings are checked to ensure they sum to 1

#=
# is indexing to be offset
notoffset(w::OffsetWindow) = iszero(w.offset_first) && iszero(w.offset_final)
isoffset(w::OffsetWindow) = !notoffset(w)
# >> specifying both a leading offset and a trailing offset is supported

# is there to be padding
notpadded(w::PaddedWindow) = iszero(w.pad_first) && iszero(w.pad_final)
ispadded(w::PaddedWindow) = !notpadded(w)
# >> it is an error to specify both a leading padding and a trailing padding

# is the information processed in direct (lower index to higher index) order
isdirect(w::FlatWindow) = w.direct

# are only complete window spans to be allowed
# onlywhole(w::Window) = w.onlywhole
# allowpartial(w::Window) = !onlywhole(w)

# is dropping incomplete results expected
isdropping(w::Window) = (w.drop_first ⊻ w.drop_final)
notdropping(w::Window) = !isdropping(w)
# >> it is an error to select both `drop_first` and `drop_final`
  
# is trimmed windowing to be allowed
maytrim(w::Window) = allowspartials(w) && (w.trim_first ⊻ w.trim_last)
# >> it is an error to select both `trim_first` and `trim_final`
# >> it is an error to select either `trim` and select any `fill`

# is filled windowing to be allowed
mayfill(w::Window) = allowspartials(w) && (w.fill_first ⊻ w.fill_last)
# >> it is an error to select both `fill_first` and `fill_final`
# >> it is an error to select either `fill` and select any `trim`
=#

#=

    ¹ "at start"  is from the lowest  indices where `direct == true`
                  is from the highest indices where `direct == false`

      "at finish" is from the highest indices where `direct == true`
                  is from the lowest  indices where `direct == false`

    ² "if needed" is true if and only if `onlywhole == true` and
                  `!iszero(rem(data_length, window_length))`
=#

