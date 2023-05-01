#=
    width_error
    tile_error
    trimwidth_error
    trimtile_error
    weights_error
    lengths_error

=#
struct EmptyError <: Exception
    msg::String
end

struct WidthError <: Exception
    msg::String
end

struct TileError <: Exception
    msg::String
end

struct WeightsError <: Exception
    msg::String
end

struct LengthsError <: Exception
    msg::String
end

check_empty(sequence) =
    isempty(sequence) && empty_error(sequence)

check_width(seqlength::Int, windowwidth::Width) =
    ((windowwidth > seqlength) || (iszero(seqlength))) && width_error(seqlength, windowwidth)

check_trimwidth(seqlength::Int, windowwidth::Width) =
    windowwidth > (seqlength - windowwidth + 1) && trimwidth_error(seqlength, windowwidth)

check_tile(seqlength::Int, tilewidth::Width) =
    ((tilewidth > seqlength) || (iszero(seqlength))) && tile_error(seqlength, tilewidth)

check_tilewidth(seqlength::Int, tilewidth::Width) =
    tilewidth > (seqlength - windowwidth + 1) && tilewidth_error(seqlength, tilewidth)

check_weights(nweights::Int, windowwidth::Width) =
    (nweights == windowwidth) || weights_error(nweights, windowwidth)

check_weights(nweights1::Int, nweights2::Int, windowwidth::Width) =
    (nweights1 === nweights2 == windowwidth) || weights_error(length(weights1), windowwidth)

check_weights(nweights1::Int, nweights2::Int, nweights3::Int, windowwidth::Width) =
    (nweights1 === nweights2 === nweights3 == windowwidth) || weights_error(length(weights1), windowwidth)

check_weights(nweights::NTuple{N,Int}, windowwidth::Width) where {N} =
    (all(windowwidth .== nweights)) || weights_error("all length.(weights) must equal windowwidth")

check_lengths(ndata, nweights) =
    (ndata === nweights) || lengths_error(ndata, nweights)

function empty_error(sequence)
    str = string("Sequence must be nonempty.")
    err = EmptyError(str)
    throw(err)
end

function width_error(seqlength::Int, windowwidth::Width)
    str = string("Bad window width (", windowwidth, ") for length (", seqlength, ").")
    err = WidthError(str)
    throw(err)
end

function trimwidth_error(seqlength::Int, windowwidth::Width)
    str = string("Bad window width (", windowwidth, ") for trimmed length (", seqlength, ").")
    err = WidthError(str)
    throw(err)
end

function tile_error(seqlength::Int, tilewidth::Width)
    str = string("Bad tile width (", tilewidth, ") for length (", seqlength, ").")
    err = TileError(str)
    throw(err)
end

function trimtile_error(seqlength::Int, tilewidth::Width)
    str = string("Bad tile width (", tilewidth, ") for trimmed length (", seqlength, ").")
    err = TileError(str)
    throw(err)
end

function weights_error(nweighting::Int, windowwidth::Width)
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
