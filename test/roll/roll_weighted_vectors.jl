F = sum;
W = 3;
weights = ProbabilityWeights([0.2, 0.3, 0.5]);
D = [1, 2, 3, 4, 5];

expected = [2.3, 3.3, 4.3];
@test rolling(F, W, D, weights) == expected

expected = [missing, missing, 2.3, 3.3, 4.3];
@test map(clean, rolling(F, W, D, weights; padding=missing)) == map(clean, expected)
@test typeof(rolling(F, W, D, weights; padding=missing)) == typeof(expected)

expected = [2.3, 3.3, 4.3, missing, missing];
@test map(clean, rolling(F, W, D, weights; padding=missing, atend=true)) == map(clean, expected)
@test typeof(rolling(F, W, D, weights; padding=missing, atend=true)) == typeof(expected)



D₁ = [1, 2, 3, 4, 5]
D₂ = [5, 4, 3, 2, 1]
F = cor
W = 3
weights = ProbabilityWeights([0.2, 0.3, 0.5]);

expected = [0.9946433500242822, 0.9773555548504419, -0.9511012772444227]
@test rolling(F, W, D₁, D₂, weights) == expected

D₃ = (D₁ .- D₂) ./ (D₁ .+ D₂);
weights = AnalyticWeights([0.3, 0.6, 0.9]);
testfn(a,b,c) = cov(a,b) - cov(a,c)
expected = Float32[0.56, 0.11, -0.58]
@test Float32.(rolling(testfn, W, D₁, D₂, D₃, weights)) == expected
