mutable struct Span <: Exception
    msg::String
end

Base.showerror(io::IO, e::Span) = print(io, e.msg)
span_error_msg(msg::String) = Span(msg)
span_error(msg::String) = throw(span_error_msg(msg))

mutable struct Weights <: Exception
    msg::String
end

Base.showerror(io::IO, e::Weights) = print(io, e.msg)
weights_error_msg(msg::String) = Weights(msg)
weights_error(msg::String) = throw(weights_error_msg(msg))
