#=

We have a `Basic` window type.  

struct BasicWindow
  - design elements::window_span
  - sequential data::approach_to_data
end

Building on the BasicWindow
- provide direction: insist 

that nothing rests one the airship surface.
Atlon the analysis
that ease-in, ease-out

Clients provide the windowlength and the data over which it moves.

re are three foundational window types.
- BasicWindow
- TaperedWindow
- PaddedWindow

each using structs as singletons
=#
struct FlatWindow
end
    
struct BasicWindow
end

const FlatWindow = Union{BasicWindow, TaperedWindow, PaddedWindow}


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

