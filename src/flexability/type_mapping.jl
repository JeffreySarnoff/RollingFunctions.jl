#=
    While many of the functions one may apply over each window along data sequences
    produce summary values that are floats, there are functions that produce
    summary values that comport more tightly with the eltype of the given sequence.

    The following is provided to illustrate the situations we intend to handle.
    The actual implementation is much more performant and better behaved.

```
    datalength = 2^10
    windowsize = 2^8

    intseq = rand(1:100, datalength)
    floatseq = float.(ints)

    intsummaryfunc(xs::Vector{Int}, idxbgn, idxend) =
        ceil(Int, minimum(xs[idxbgn:idxend]))

    intsummaryfunc(xs::Vector{Float64}, idxbgn, idxend) =
        ceil(Int, minimum(xs[idxbgn:idxend]))

    floatsummaryfunc(xs::Vector{Int}, idxbgn, idxend) =
        mean(xs[idxbgn:idxdend])

    floatsummaryfunc(xs::Vector{Float64}, idxbgn, idxend) =
        mean(xs[idxbgn:idxdend])

```

=#
