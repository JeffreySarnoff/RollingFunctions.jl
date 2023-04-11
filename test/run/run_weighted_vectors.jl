clean(x) = x
clean(x::Missing) = Missing

F = sum; W = 3; weights = ProbabilityWeights([0.2, 0.3, 0.5])
D = [1, 2, 3, 4, 5];
expected = [2.3, 3.3, 4.3];
@test running(F, W, D, weights) == expected

expected = [missing, missing, 2.3, 3.3, 4.3];
@test map(clean, running(F, W, D, weights; padding=missing)) == map(clean, expected)
@test typeof(running(F, W, D, weights; padding=missing)) == typeof(expected)

expected = [2.3, 3.3, 4.3, missing, missing];
@test map(clean, running(F, W, D, weights; padding=missing, padlast=true)) == map(clean, expected)
@test typeof(running(F, W, D, weights; padding=missing, padlast=true)) == typeof(expected)

