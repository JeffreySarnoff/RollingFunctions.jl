mutable struct Span <: Exception
    msg::String
end

Base.showerror(io::IO, e::Span) = print(io, e.msg)
span_error_msg(msg::String) = Span(msg)
span_error(msg::String) = throw(span_error_msg(msg))

mutable struct Weighting <: Exception
    msg::String
end

Base.showerror(io::IO, e::Weighting) = print(io, e.msg)
weighting_error_msg(msg::String) = Weighting(msg)
weighting_error(msg::String) = throw(weights_error_msg(msg))

