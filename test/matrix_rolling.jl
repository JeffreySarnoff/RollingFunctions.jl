clean(x) = x
clean(x::Missing) = Missing

D₁ = [1, 2, 3, 4, 5];
D₂ = [5, 4, 3, 2, 1];
M = hcat(D₁, D₂);
F = sum;
W = 3;

wweights = ProbabilityWeights([0.1,0.2,0.7])
mweights = hcat(wweights, wweights)

expected = [
    6 12
    9 9
    12 6];

@test rolling(F, W, M) == expected
@test typeof(rolling(F, W, M)) == typeof(expected)

expected = [
    missing missing
    missing missing
    6 12
    9 9
    12 6];

@test map(clean, rolling(F, W, M; padding=missing)) == map(clean, expected)
@test typeof(rolling(F, W, M; padding=missing)) == typeof(expected)

expected = [
    6 12
    9 9
    12 6
    missing missing
    missing missing];

@test map(clean, rolling(F, W, M; padding=missing, padlast=true)) == map(clean, expected)
@test typeof(rolling(F, W, M; padding=missing, padlast=true)) == typeof(expected)


D₁ = [1, 2, 3, 4, 5]
D₂ = [5, 4, 3, 2, 1]
M = hcat(D₁, D₂)
M2 = Float64.(M)
F = sum
W = 3
expected = [  2.6 3.4
              3.6 2.4
              4.6 1.4 ]
@test isapprox(rolling(F, W, M2, wweights), expected)

@test isapprox(rolling(F, W, M, wweights), expected

