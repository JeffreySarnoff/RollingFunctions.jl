#=
=#

abstract type Specific end
abstract type FocalBoundry <: Specific end

struct Start <: FocalBoundry
    at::Int
end
value(x::Start) = x.at
Start(x::Start) = x

struct Finish <: FocalBoundry
    at::Int
end
value(x::Finish) = x.at
Finish(x::Finish) = x

lead_through(x::Start) = value(x) - 1
trail_after::Finish) = (value(x) + 1)

pad_upto_start::Bool
    trim_upto_start::Bool
    taper_upto_start::Bool
    
 
# with any Boundry  there may be *at most one* Behavior
# with any Behavior there may be *at most one* Offset
# with any Offset   there may be *at most one* Padding

const Boundries  = ( :Start , :Finish )
const Behaviors  = ( :Skip, :Trim, :Taper )
const Affinities = ( :Offset, :Pad )

const Morphology = (:Offset, :Weight)
# what may be cogrediant
struct Cogrediant{A, B}

"""
    specify_window(..)

Specify a `sliding window`. 
- Identify the attributes best faciliate the purpose-laden window.
- Select the behaviors that do most for the window.
- Qualify behaviour, prefer some actions to others.
- Resolve the available as the possible.
"""
function specify_window (attributes, behaviors, houseplanting)
  
end

    
