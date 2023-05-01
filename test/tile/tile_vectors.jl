clean(x) = x
clean(x::Missing) = Missing

F = sum;
W = 3;
D = [1, 2, 3, 4, 5, 6, 7];
expected = [6, 15];
@test tiling(F, W, D) == expected

expected = [missing, 6, 15];
@test map(clean, tiling(F, W, D; padding=missing)) == map(clean, expected)
@test typeof(tiling(F, W, D; padding=missing)) == typeof(expected)

expected = [6, 15, missing];
@test map(clean, tiling(F, W, D; padding=missing, padlast=true)) == map(clean, expected)
@test typeof(tiling(F, W, D; padding=missing, padlast=true)) == typeof(expected)


D₁ = [1, 2, 3, 4, 5];
D₂ = [5, 4, 3, 2, 1];
F = cor;
W = 3;
expected = [-1.0];
@test tiling(F, W, D₁, D₂) == expected

expected = [missing, -1.0];
@test map(clean, tiling(F, W, D₁, D₂; padding=missing)) == map(clean, expected)
@test typeof(tiling(F, W, D₁, D₂; padding=missing)) == typeof(expected)


expected = [-1.0, missing];
@test map(clean, tiling(F, W, D₁, D₂; padding=missing, padlast=true)) == map(clean, expected)
@test typeof(tiling(F, W, D₁, D₂; padding=missing, padlast=true)) == typeof(expected)

