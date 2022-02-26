#=
    While many of the functions one may apply over each window along data sequences
    produce summary values that are floats, there are functions that produce
    summary values that comport more tightly with the eltype of the given sequence.

    The following is provided to illustrate the situations we intend to handle.
    The actual implementation is much more performant and better behaved.

```
    datalength = 2^10
    windowsize = 2^8
    idxs = 2windowsize:3windowsize

    mean(windowed_data) = sum(windowed_data) / length(windowed_data)

    breadth(windowed_data) = maximum(windowed_data) - minimum(windowed_data)
    leveled_mean(windowed_data) =
      breadth(windowed_data) / mean(windowed_data)

    floatfunc(windowed_data)::AbstractFloat = leveled_mean(windowed_data)
    intfunc(windowed_data)::Integer = ceil(Int, floatfunc(windowed_data))

    intseq = rand(1:100, datalength)
    floatseq = float.(intseq)

    intsummaryfunc(xs::Vector{Int}, idxs::AbstractRange) =
        intfunc(xs[idxs])

    intsummaryfunc(xs::Vector{Float64}, idxs::AbstractRange) =
        intfunc(xs[idxs])

    floatsummaryfunc(xs::Vector{Int},  idxs::AbstractRange) =
        floatfunc(xs[idxs])

    floatsummaryfunc(xs::Vector{Float64}, idxs::AbstractRange) =
        floatfunc(xs[idxs])
```

```
julia> const return_type = Core.Compiler.return_type
return_type (generic function with 5 methods)
```
```
wrap_types(args::Vararg{<:Type, N}) where {N} = Tuple{ args... }
wrap_types(args::Vararg{<:Any, N})  where {N} = Tuple{ typeof.(args)... }

returntype(f, args...) = return_type(f, wrap_types(args))

```
julia> returntype(f, args...) = return_type(f, Tuple{typeof.(args)...})
julia> returntype(f, args::Vararg{N}) = return_type(f, Tuple{typeof.(args)...})
julia> typeof( intsummaryfunc(intseq, idxs) )
Int64


julia> return_type(intsummaryfunc, Tuple{Vector{Int}, StepRange}) <: Integer
true
julia> a = intsummaryfunc(floatseq, idxs); isa(a, Integer)
true
julia> a = floatsummaryfunc(intseq, idxs); isa(a, AbstractFloat)
true
julia> a = floatsummaryfunc(floatseq, idxs); isa(a, AbstractFloat)
true
```
=#
