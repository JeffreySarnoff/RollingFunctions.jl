#=
- nrows
- ncols

- rts (returned types)
- nrts (length(rts))

- isview
- asview
- viewall

- commontype
=#

"""
    nrows(x)
count the rows of x
""" nrows

"""
    ncols(x)
count the columns of x
""" ncols

nrows(x::AbstractVector) = length(x)
nrows(x::AbstractArray) = size(x)[1]
nrows(x) = isempty(size(x)) ? 1 : size(x)[1]

ncols(x::AbstractVector) = 1
ncols(x::AbstractArray) = size(x)[2]
ncols(x) = isempty(size(x)) ? 1 : size(x)[2]

# returned types (rough) and tally(returned types)
# more specific when `typs` are provided

@inline rts(fn) = Base.return_types(fn)[max(1, end-1)]
@inline rts(fn, typs) = Base.return_types(fn, typs)[max(1, end-1)]

@inline nrts(fn) = max(1, length(rts(fn).parameters))
@inline nrts(fn, typs) = max(1, length(rts(fn,typs).parameters))

# views

@inline isview(data) = isa(data, SubArray) 
@inline asview(data) = isview(data) ? data : viewall(data)

@inline viewall(data::A) where {T, A<:AbstractArray{T,1}} = view(data, :)
@inline viewall(data::A) where {T, A<:AbstractArray{T,2}} = view(data, :, :)
@inline viewall(data::A) where {T, A<:AbstractArray{T,3}} = view(data, :, :, :)
@inline viewall(data::A) where {T, A<:AbstractArray{T,4}} = view(data, :, :, :, :)

@inline viewall(data::Tuple{Vararg{T,N}}) where {T,N} = viewall(convert(Vector{T}, data))
Base.convert(::Type{Vector{T}}, tup::Tuple{Vararg{T,N}}) where {T,N} = [ tup... ]

# from within a Union
union_types(x::Union) = (x.a, union_types(x.b)...)
union_types(x::Type) = (x,)
union_common(x::Union) = setdiff(union_types(T),(Missing,Nothing))
commontype(x::Union) = union_common(x)[1]
commontype(::Type{T}) = T

# filling

function fills(filler::T, data::AbstractVector{T}) where {T}
    nvals  = axes(data)[1].stop
    return fill(filler, nvals)
end

function fills(filler::T1, data::AbstractVector{T2}) where {T1, T2}
    elemtype = Union{T1,T2}
    nvals  = axes(data)[1].stop
    result = Array{elemtype,1}(undef, nvals)
    result[:] = filler
    return result
end

# number of values to be obtained

function nrolled(seqlength::T, windowspan::T) where {T<:Signed}
    (0 < windowspan <= seqlength) || throw(SpanError(seqlength,windowspan))

    return seqlength - windowspan + 1
end

# number of values to be imputed

function nfilled(windowspan::T) where {T<:Signed}
    windowspan < 1 && throw(SpanError(seqlength,windowspan))

    return windowspan - 1
end

# local exceptions

SpanError(seqlength, windowspan) =
    ErrorException("\n\tBad window span ($windowspan) for length $seqlength.\n" )

WeightsError(nweighting, windowspan) =
    ErrorException("\n\twindowspan ($windowspan) != length(weighting) ($nweighting))).\n" )
