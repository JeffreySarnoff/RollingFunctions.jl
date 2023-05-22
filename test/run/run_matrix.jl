D₁ = [1, 2, 3, 4, 5];
D₂ = [5, 4, 3, 2, 1];
M = hcat(D₁, D₂);
M2 = Float64.(M)
F = sum;
S = 3;

expected = [
     1  5
     3  9
     6 12
     9  9
    12  6
];

@test running(F, S, M) == expected

expected = [
     6  12
     9   9
    12   6
     9   3
     5   1
];

@test running(F, S, M; atend=true) == expected

pweight = ProbabilityWeights([0.1,0.2,0.7])
vweight = Vector(pweight)

pweights = vcat(repeat([pweight], 2))
vweights = map(Vector, pweights)

expected = [
     1.0  5.0
     3.0  9.0
     6.0 12.0
     9.0  9.0
    12.0  6.0
];

@test running(F, S, M2, pweight)  == expected
@test running(F, S, M2, pweights) == expected

expected = [
     1.0  5.0
     3.0  9.0
     6.0 12.0
     9.0  9.0
    12.0  6.0
];

@test running(F, S, M2, pweight; atend=true)  == expected
@test running(F, S, M2, pweights; atend=true) == expected
