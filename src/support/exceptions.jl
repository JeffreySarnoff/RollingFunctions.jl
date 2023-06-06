#=
    empty_error
    width_error
    size_error
    weights_error
    lengths_error
    maxlength_error
=#
struct EmptyError <: Exception
    msg::String
end

struct WidthError <: Exception
    msg::String
end

struct SizeError <: Exception
    msg::String
end

struct WeightsError <: Exception
    msg::String
end

struct LengthsError <: Exception
    msg::String
end

struct MaxLengthError <: Exception
    msg::String
end

check_empty(sequence) =
    isempty(sequence) && empty_error(sequence)

check_width(seqlength::Int, windowwidth::Integer) =
    ((windowwidth > seqlength) || (iszero(seqlength))) && width_error(seqlength, windowwidth)

check_size(size1::NTuple{2,Int}, size2::NTuple{2,Int}) =
    (size1 == size2) || size_error(size1, size2)

check_weights(nweights::Int, windowwidth::Integer) =
    (nweights == windowwidth) || weights_error(nweights, windowwidth)

check_weights(nweights1::Int, nweights2::Int, windowwidth::Integer) =
    (nweights1 === nweights2 == windowwidth) || weights_error(length(weights1), windowwidth)

check_weights(nweights1::Int, nweights2::Int, nweights3::Int, windowwidth::Integer) =
    (nweights1 === nweights2 === nweights3 == windowwidth) || weights_error(length(weights1), windowwidth)

check_weights(nweights::NTuple{N,Int}, windowwidth::Integer) where {N} =
    (all(windowwidth .== nweights)) || weights_error("all length.(weights) must equal windowwidth")

check_lengths(ndata, nweights) =
    (ndata === nweights) || lengths_error(ndata, nweights)

check_maxlength(some, many) =
    (some <= many) || maxlength_error(some, many)


function empty_error(sequence)
    str = string("Sequence must be nonempty.")
    err = EmptyError(str)
    throw(err)
end

function width_error(seqlength::Int, windowwidth::Integer)
    str = string("Bad window width (", windowwidth, ") for length (", seqlength, ").")
    err = WidthError(str)
    throw(err)
end

function size_error(size1, size2)
    str = string("sizes must be equal: $(size1) != $(size2)")
    err = SizeError(str)
    throw(err)
end

function weights_error(nweighting::Int, windowwidth::Integer)
    str = string("Bad weights length (", nweighting, ") != for window length (", windowwidth, ").")
    err = WeightsError(str)
    throw(err)
end

function weights_error(str::String)
    err = WeightsError(str)
    throw(err)
end

function lengths_error(ndata, nweights)
    str = string("tupled data and tupled wieghts must be the same length ($ndata != $nweights).")
    err = LengthsError(str)
    throw(err)
end

function maxlength_error(some, many)
    str = "result (length=$(many)) must be at least as long as the data (length=$(many))."
    err = MaxLengthError(str)
    throw(err)
end
