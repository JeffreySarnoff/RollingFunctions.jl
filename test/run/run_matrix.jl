
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

vpweights = vcat(repeat([pweight], 2))
vweights = map(Vector, vpweights)

expected = Float32[
 1.0      5.0
 1.66667  4.33333
 2.6      3.4
 3.6      2.4
 4.6      1.4
]

@test isapprox(map(Float32, running(F, S, M2, pweight)), expected)
@test isapprox(map(Float32, running(F, S, M2, vpweights)), expected)

expected = Float32[
 2.6      3.4
 3.6      2.4
 4.6      1.4
 4.33333  1.66667
 5.0      1.0
];

@test isapprox(map(Float32, running(F, S, M2, pweight; atend=true)), expected)
@test isapprox(map(Float32, running(F, S, M2, vpweights; atend=true)), expected)
