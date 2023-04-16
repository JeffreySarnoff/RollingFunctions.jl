#=
    span_error
    tile_error
    trimspan_error
    trimtile_error
    weights_error

=#
struct EmptyError <: Exception
    msg::String
end

struct SpanError <: Exception
    msg::String
end

struct TileError <: Exception
    msg::String
end

struct WeightsError <: Exception
    msg::String
end

check_empty(sequence) = 
    isempty(sequence) && empty_error(sequence)

check_span(seqlength::Int, windowspan::Span) =
    ((windowspan > seqlength) || (iszero(seqlength))) && span_error(seqlength, windowspan)

check_trimspan(seqlength::Int, windowspan::Span) =
    windowspan > (seqlength - windowspan + 1) && trimspan_error(seqlength, windowspan)

check_tile(seqlength::Int, tilespan::Span) =
    ((tilespan > seqlength) || (iszero(seqlength))) && tile_error(seqlength, tilespan)

check_tilespan(seqlength::Int, tilespan::Span) =
    tilespan > (seqlength - windowspan + 1) && tilespan_error(seqlength, tilespan)

check_weights(nweights::Int, windowspan::Span) =
    (nweights == windowspan) || weights_error(nweights, windowspan)

check_weights(nweights1::Int, nweights2::Int, windowspan::Span) =
    (nweights1 === nweights2 == windowspan) || weights_error(length(weights1), windowspan)

check_weights(nweights1::Int, nweights2::Int, nweights3::Int, windowspan::Span) =
    (nweights1 === nweights2 === nweights3 == windowspan) || weights_error(length(weights1), windowspan)

check_weights(nweights::NTuple{N,Int}, windowspan::Span) where {N} =
    (all(windowspan .== nweights)) || weights_error("all length.(weights) must equal windowspan")


function empty_error(sequence)
    str = string("Sequence must be nonempty.")
    err = EmptyError(str)
    throw(err)
end

function span_error(seqlength::Int, windowspan::Span)
    str = string("Bad window span (", windowspan, ") for length (", seqlength, ").")
    err = SpanError(str)
    throw(err)
end

function trimspan_error(seqlength::Int, windowspan::Span)
    str = string("Bad window span (", windowspan, ") for trimmed length (", seqlength, ").")
    err = SpanError(str)
    throw(err)
end

function tile_error(seqlength::Int, tilespan::Span)
    str = string("Bad tile span (", tilespan, ") for length (", seqlength, ").")
    err = TileError(str)
    throw(err)
end

function trimtile_error(seqlength::Int, tilespan::Span)
    str = string("Bad tile span (", tilespan, ") for trimmed length (", seqlength, ").")
    err = TileError(str)
    throw(err)
end

function weights_error(nweighting::Int, windowspan::Span)
    str = string("Bad weights length (", nweighting, ") != for window length (", windowspan, ").")
    err = WeightsError(str)
    throw(err)
end

function weights_error(str::String)
    err = WeightsError(str)
    throw(err)
end

