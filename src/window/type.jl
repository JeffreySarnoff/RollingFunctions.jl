
abstract type AbstractWindow end

abstract type AbstractOrientation end
abstract type AbstractParity    <: AbstractOrientation end
abstract type AbstractChirality <: AbstractOrientation end

abstract type AbstractCharge end

struct Charge{ORIENTATION, MAGNITUDE} <: AbstractCharge
    orientation::ORIENTATION
    magnitude::MAGNITUDE
end


struct Positive{T} <: AbstractParity 
    ideation::T
end

struct Negative{T} <: AbstractParity 
    ideation::T
end

struct Parity{T} <: AbstractParity
    chirality::T
    
#=


These fields exist for every type of Window.

    window_span     no default value
                    applying this Window would examine this many adjacent element at each summarization;
                    each aggregative application is taken over a segment of window_span data elements.

    direction_within_window

    direction_outside_window
    direction_inside_window
    direction_outside_window

    window_outside_direction

    tiles_scope     1 by default (one tile per indexable position, step with no skip)
                    2 (1/2 tile per indexable position, 1 step also has a 1 skip [over 1 indexible position])
                    3 (1/3 tile per indexable position, 1 step also has a 2 skip [over 2 indexible positions])
                    4 (1/4 tile per indexable position, 1 step also has a 3 skip [over 3 indexible positions])

    direction       +1 is foward, by default (from low indices to high indices)
                    -1 is backward (from high indices to low indices)
=#

@kwdef mutable struct BasicWindow <: AbstractWindow
    const window_span::Int         # span of contiguous elements
    const tile_length::Int=1       # span for tile (1 is untiled)

    const direct::Bool=true        # process from low indices to high
end


@kwdef mutable struct BasicWindow <: AbstractWindow
    const window_span::Int         # span of contiguous elements
    const tile_length::Int=1       # span for tile (1 is untiled)

    const direct::Bool=true        # process from low indices to high
end

@kwdef mutable struct TrimmedWindow <: AbstractWindow
    const window_span::Int         # span of contiguous elements
    const tile_length::Int=1       # span for tile (1 is untiled)

    const direct::Bool=true        # process from low indices to high
    
    const drop_first::Bool=true    # omit results at start¹, if needed²
    const drop_final::Bool=false   # omit results at finish¹, if needed²
                                   # >> it is an error to select both <<
end

@kwdef mutable struct TaperedWindow <: AbstractWindow
    const window_span::Int         # span of contiguous elements
    const tile_length::Int=1       # span for tile (1 is untiled)

    const direct::Bool=true        # process from low indices to high
    
    const taper_first::Bool=true   # use partial windowing over first elements, if needed
    const taper_final::Bool=false  # use partial windowing over final elements, if needed
                                   # >> it is an error to select both <<
end

@kwdef mutable struct PaddedWindow{T} <: AbstractWindow
    const window_span::Int         # span of contiguous elements
    const tile_length::Int=1       # span for tile (1 is untiled)

    const direct::Bool=true        # process from low indices to high
    
    const padding::T=missing       # the value with which to pad
    const pad_first::Bool=true     # use partial windowing over first elements, if needed
    const pad_final::Bool=false    # use partial windowing over final elements, if needed
                                   # >> it is an error to select both <<
end

const FlatWindow = Union{BasicWindow, DirectWindow, TaperedWindow, PaddedWindow}

#=
      footnotes used within some struct field comments

    ¹ "at start"  is from the lowest  indices where `direct == true`
                  is from the highest indices where `direct == false`

      "at finish" is from the highest indices where `direct == true`
                  is from the lowest  indices where `direct == false`

    ² "if needed" is true if and only if `onlywhole == true` and
                  `!iszero(rem(data_length, window_length))`
=#


@kwdef mutable struct OffsetWindow{W<:FlatWindow} <: AbstractWindow
    window::W
                                   # >> setting both is supported <<
    offset_first::Int=0            # start  at index (offset_first + 1)
    offset_final::Int=0            # finish at index (length - offset_final)
end

@kwdef mutable struct WeightedWindow{T, W<:FlatWindow} <: AbstractWindow
    window::W                      # struct annotated above
 
    weights::Vector{T}             # the weights collected
end

@kwdef mutable struct OffsetWeightedWindow{W<:FlatWindow,T} <: AbstractWindow
    window::W
                                   # >> setting both is supported <<
    offset_first::Int=0            # start  at index (offset_first + 1)
    offset_final::Int=0            # finish at index (length - offset_final)
    
    weights::Vector{T}             # the weights collected
end

#=
     The weights are to be normalized. 
     When weights are not known to be normalized,
     that they sum to 1 very nearly if not exactly 
     will be ensured internally.

     prevfloat(1.0, k) <= sum_of_weights <= 1.0 
     where k is expected to be in 0:8.
     (Float64: 0.9999999999999991 <= sum_of_weights <= 1.0)
     (Float32: 0.9999995f0 <= sum_of_weights <= 1.0f0)
=#

const NestedWindow = Union{OffsetWindow, WeightedWindow, OffsetWeightedWindow}
const WeightsWindow = Union{WeightedWindow, OffsetWeightedWindow}
const OffsetsWindow = Union{OffsetWindow, OffsetWeightedWindow}

#=
     Constructors
=#

BasicWindow(length::Int) = BasicWindow(; length)
BasicWindow(length::Int, tilespan::Int) = BasicWindow(; length, tilespan)
function BasicWindow(length::Int, tilespan::Int=1; drop_first=true, drop_final=false, direct=true)
    if drop_first drop_final = false end
    if drop_final drop_first = false end
    BasicWindow(; length, tilespan, drop_first, drop_final, direct)
end

TaperedWindow(length::Int) = TaperedWindow(; length)
TaperedWindow(length::Int, tilespan::Int) = TaperedWindow(; length, tilespan)
function TaperedWindow(length::Int, tilespan::Int=1; taper_first=true, taper_final=false, direct=true)
    if taper_first taper_final = false end
    if taper_final taper_first = false end
    TaperedWindow(; length, tilespan, taper_first, taper_final, direct)
end

PaddedWindow(length::Int) = PaddedWindow(; length)
PaddedWindow(length::Int, tilespan::Int) = PaddedWindow(; length, tilespan)
function PaddedWindow(length::Int, tilespan::Int=1; pad_first=true, pad_final=false, padding::T=missing, direct=true) where {T}
    if pad_first pad_final = false end
    if pad_final pad_first = false end
    PaddedWindow(; length, tilespan, pad_first, pad_final, padding, direct)
end

        #    (→ DO NOT provide explicit constructors for any of the NestedWindow types. ←)
        #    (  otherwise, the stack may overflow ... no other information at this time  )

#=
export AbstractWindow, 
    FlatWindow, 
        PlainWindow,
        ForgetfulWindow,
        TaperingWindow,
        PaddingWindow,
    NestWindow,                  # shared local root, applicable supertype
        OffsetWindow,
        WeightWindow,
    WrapWindow,
        WeightedOffsetWindow,

       FlatWindow,
       BasicWindow,
    ForgetfulWindow,
    TaperingWindow,
    PaddingWindow,

    PadWindow,

    WindowType = Union{BasicWindow, ForgetfulWindow, TaperingWindnow, PaddingWindow, OffsetWindow}
    WeightedWindowType = Union{BasicWindow, ForgetfulWindow, TaperingWindnow, PaddingWindow, OffsetWindow}

    TruncateWindow, 
    PadWindow,
    TaperWindow, 
    
    PosWindow, OffsetWindow,
    WeightedWindow
    WeightedOffsetWindow,

       BasicWindow, TrimmedWindow, TaperedWindow, PaddedWindow,   # these are FlatWindows, all fields at the surface
       OffsetWindow, WeightedWindow, WeightedWindow,        # these are NestWindows, one field is a FlatWindow
                                                                  #     others hold attributes, specifications
=#



#=
     obtaining attributes
=#

winlength(@nospecialize(w::FlatWindow)) = w.length
winlength(@nospecialize(w::NestedWindow)) = w.window.length

tilesize(@nospecialize(w::FlatWindow)) = w.tilesize
tilesize(@nospecialize(w::NestedWindow)) = w.window.tilesize

direct(@nospecialize(w::FlatWindow)) = w.direct
direct(@nospecialize(w::NestedWindow)) = w.window.direct

tapers(@nospecialize(w::TaperedWindow)) = (w.taper_first, w.taper_final)
tapers(@nospecialize(w::WeightedWindow{TaperedWindow})) = tapers(w.window)
tapers(@nospecialize(w::OffsetWindow{TaperedWindow})) = tapers(w.window)
tapers(@nospecialize(w::OffsetWeightedWindow{TaperedWindow})) = tapers(w.window)

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

weights(@nospecialize(w::WeightsWindow)) = w.weights
weights(@nospecialize(w::OffsetWeightedWindow)) = w.weights

offsets(@nospecialize(w::OffsetsWindow)) = (w.offset_first, w.offset_final)

#=
     predicates over attributes
=#

# does the data present in order of increasing indices
isdirect(@nospecialize(w::FlatWindow)) = w.direct
isdirect(@nospecialize(w::NestedWindow)) = w.window.direct

# is dropping incomplete results expected
isdropping(w::BasicWindow) = (w.drop_first ⊻ w.drop_final)
notdropping(w::BasicWindow) = !isdropping(w)
# >> it is an error to select both `drop_first` and `drop_final`
isdropping(w::NestedWindow) = isdropping(w.window)
notdropping(w::NestedWindow) = !isdropping(w)

# is indexing to be offset
notoffset(w::OffsetWindow) = iszero(w.offset_first) && iszero(w.offset_final)
isoffset(w::OffsetWindow) = !notoffset(w)
# >> specifying both a leading offset and a trailing offset is supported
notoffset(w::NestedWindow) = notoffset(w.window)
isoffset(w::NestedWindow) = !notoffset(w)

# is there to be padding
notpadded(w::PaddedWindow) = iszero(w.pad_first) && iszero(w.pad_final)
ispadded(w::PaddedWindow) = !notpadded(w)
# >> it is an error to specify both a leading padding and a trailing padding
notpadded(w::NestedWindow) = notpadded(w.window)
ispadded(w::NestedWindow) = !notpadded(w)
  
# is tapermed windowing to be allowed
maytaper(w::TaperedWindow) = allowspartials(w) && (w.taper_first ⊻ w.taper_last)
# >> it is an error to select both `taper_first` and `taper_final`
maytaper(w::NestedWindow) = maytaper(w)

# do not use partial windows
expectswholes(w::FlatWindow) = tapered(x) || padded(w)
admitsparts(w::FlatWindow) = !expectswholes(w)
expectswholes(w::NestedWindow) = expectswholes(w.window)
admitsparts(w::NestedWindow) = !expectswholes(w)
