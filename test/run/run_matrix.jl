clean(x) = x
clean(x::Missing) = Missing

D₁ = [1, 2, 3, 4, 5];
D₂ = [5, 4, 3, 2, 1];
M = hcat(D₁, D₂);
F = sum;
S = 3;

wweights = ProbabilityWeights([0.1,0.2,0.7])
mweights = hcat(wweights, wweights)

expected = [
    6 12
    9 9
    12 6];

@test running(F, S, M) == expected
@test typeof(running(F, S, M)) == typeof(expected)


D₁ = [1, 2, 3, 4, 5]
D₂ = [5, 4, 3, 2, 1]
M = hcat(D₁, D₂)
M2 = Float64.(M)
F = sum
S = 3

wweights = ProbabilityWeights([0.1,0.2,0.7])
mweights = hcat(wweights, wweights)

expected = [  2.6 3.4
              3.6 2.4
              4.6 1.4 ]
@test isapprox(running(F, S, M2, wweights), expected)

@test isapprox(running(F, S, M, wweights), expected)
