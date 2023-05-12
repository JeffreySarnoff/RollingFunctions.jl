clean(x) = x
clean(x::Missing) = Missing

F = sum; W = 3; theweights = ProbabilityWeights([0.2, 0.3, 0.5])
D = [1, 2, 3, 4, 5];
expected = [0.5, 1.3, 2.3, 3.3, 4.3];
@test running(F, W, D, theweights) == expected
