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

