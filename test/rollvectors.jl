clean(x) = x
clean(x::Missing) = Missing

F = sum;
W = 3;
D = [1, 2, 3, 4, 5];
expected = [6, 9, 12];
@test rolling(F, W, D) == expected

expected = [missing, missing, 6, 9, 12];
@test map(clean, rolling(F, W, D; padding=missing)) == map(clean, expected)
@test typeof(rolling(F, W, D; padding=missing)) == typeof(expected)

expected = [6, 9, 12, missing, missing];
@test map(clean, rolling(F, W, D; padding=missing, padlast=true)) == map(clean, expected)
@test typeof(rolling(F, W, D; padding=missing, padlast=true)) == typeof(expected)

D = Float32[1, 2, 3, 4, 5];
expected = Float32[6, 9, 12];
@test rolling(F, W, D) == expected

F = sum;
W = 4;
D = [1, 2, 3, 4, 5];
expected = [10, 14];
@test rolling(F, W, D) == expected

D₁ = [1, 2, 3, 4, 5];
D₂ = [5, 4, 3, 2, 1];
F = cor;
W = 3;
expected = [-1.0, -1.0, -1.0];
@test rolling(F, W, D₁, D₂) == expected

expected = [missing, missing, -1.0, -1.0, -1.0];
@test map(clean, rolling(F, W, D₁, D₂; padding=missing)) == map(clean, expected)
@test typeof(rolling(F, W, D₁, D₂; padding=missing)) == typeof(expected)


expected = [-1.0, -1.0, -1.0, missing, missing];
@test map(clean, rolling(F, W, D₁, D₂; padding=missing, padlast=true)) == map(clean, expected)
@test typeof(rolling(F, W, D₁, D₂; padding=missing, padlast=true)) == typeof(expected)


D₁ = [1, 2, 3, 4, 5]
D₂ = [5, 4, 3, 2, 1]
F = cor
W = 3
expected = [0.9946433500242822, 0.9773555548504419, -0.9511012772444227]
@test rolling(F, W, D₁, D₂, weights) == expected


#=
D₁ = [1, 2, 3, 4, 5];
D₂ = [5, 4, 3, 2, 1];
M = hcat(D₁, D₂);
F = sum;
W = 3;

expected = [
    6 12
    9 9
    12 6];

@test rolling(F, M, W) == expected
@test typeof(rolling(F, M, W)) == typeof(expected)

expected = [
    missing missing
    missing missing
    6 12
    9 9
    12 6];

@test map(clean, rolling(F, M, W; padding=missing)) == map(clean, expected)
@test typeof(rolling(F, M, W; padding=missing)) == typeof(expected)

expected = [
    6 12
    9 9
    12 6
    missing missing
    missing missing];

@test map(clean, rolling(F, M, W; padding=missing, padlast=true)) == map(clean, expected)
@test typeof(rolling(F, M, W; padding=missing, padlast=true)) == typeof(expected)
=#
