#=
    These methods are specific to the work being applied over windowed data.

    The intent is to provide more performance while keeping capability.
=#

const ViewOf(::Type{T}) where T =
    SubArray{T, 1, Vector{T}, Tuple{Base.Slice{Base.OneTo{Int64}}}, true}

mutable struct UpdateWindow{T}
    prior::T
    current::T
    evaluand::T
    updater::T
end

struct WindowApplicable{T}
    update_window::UpdateWindow{T}
    initialization::Function
    update::Function
    window_span::Int
    data_length::Int
    data_view::ViewOf(T)
end

function updating_sum(prior_sum::T, oldest_value::T, current_value::T) where T
    prior_sum -= oldest_value
    prior_sum += current_value
    prior_sum
end

function updating_mean(inv_window_span::T, prior_mean::T, oldest_value::T, current_value::T) where T
    new_sum = updating_sum(prior_sum, oldest_value, current_value)
    new_sum * inv_window_span
end
