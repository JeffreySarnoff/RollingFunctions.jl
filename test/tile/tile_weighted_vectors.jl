clean(x) = x
clean(x::Missing) = Missing

F = sum; W = 3; weights = ProbabilityWeights([0.2, 0.3, 0.5])
D = [1, 2, 3, 4, 5];
expected = [2.3];
@test tiling(F, W, D, weights) == expected

expected = [missing, 2.3];
@test map(clean, tiling(F, W, D, weights; padding=missing)) == map(clean, expected)
@test typeof(tiling(F, W, D, weights; padding=missing)) == typeof(expected)

expected = [2.3, missing];
@test map(clean, tiling(F, W, D, weights; padding=missing, atend=true)) == map(clean, expected)
@test typeof(tiling(F, W, D, weights; padding=missing, atend=true)) == typeof(expected)

