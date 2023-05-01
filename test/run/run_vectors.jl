clean(x) = x
clean(x::Missing) = Missing

F = sum;
W = 3;
D = [1, 2, 3, 4, 5];
expected = [1, 3, 6, 9, 12];
@test running(F, W, D) == expected

D = Float32[1, 2, 3, 4, 5];
expected = Float32[1, 3, 6, 9, 12];
@test running(F, W, D) == expected

F = sum;
W = 4;
D = [1, 2, 3, 4, 5];
expected = [1, 3, 6, 10, 14];
@test running(F, W, D) == expected

D₁ = [1, 2, 3, 4, 5];
D₂ = [5, 4, 3, 2, 1];
F = cor;
W = 3;
expected = [NaN, -1.0, -1.0, -1.0, -1.0];
@test running(F, W, D₁, D₂) == expected

D₁ = [1, 2, 3, 4, 5]
D₂ = [5, 4, 3, 2, 1]
F = cor
W = 3
expected = [NaN, cor([1,2],[5,4]), cor([1,2,3],[5,4,3]), cor([2,3,4],[4,3,2]), cor([3,4,5],[3,2,1])]
@test running(F, W, D₁, D₂, weights) == expected


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

@test running(F, M, W) == expected
@test typeof(running(F, M, W)) == typeof(expected)

expected = [
    missing missing
    missing missing
    6 12
    9 9
    12 6];

@test map(clean, running(F, M, W; padding=missing)) == map(clean, expected)
@test typeof(running(F, M, W; padding=missing)) == typeof(expected)

expected = [
    6 12
    9 9
    12 6
    missing missing
    missing missing];

@test map(clean, running(F, M, W; padding=missing, padlast=true)) == map(clean, expected)
@test typeof(running(F, M, W; padding=missing, padlast=true)) == typeof(expected)
=#
