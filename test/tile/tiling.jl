data1 = collect(1.0f0:16.0f0)
data2 = reverse(data1)

fn = sum
width = 8
tile = 8

intvec = collect(1:10);
floatvec = collect(1.0:10.0);
intmat = hcat(intvec, reverse(intvec));
floatmat = hcat(floatvec, reverse(floatvec));

width = 3
fn = sum

result = tiling(fn, width, intvec)
expected = [6, 15, 24]
@test result == expected
@test typeof(result) == typeof(expected)

result = tiling(fn, width, floatvec)
expected = map(Float64, expected)
@test result == expected
@test typeof(result) == typeof(expected)

result = tiling(fn, width, intmat)
expected = [
             6 27
            15 18
            24  9
           ]
@test result == expected
@test typeof(result) == typeof(expected)

result = tiling(fn, width, floatmat)
expected = map(Float64, expected)
@test result == expected
@test typeof(result) == typeof(expected)

# pad first

result = tiling(fn, width, intvec; padding = missing)
expected = [missing, 6, 15, 24]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(fn, width, floatvec; padding = missing)
expected = map(x->ismissing(x) ? x : Float64(x), expected)
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(fn, width, intmat; padding = missing)
expected = [
            missing    missing
             6         27
            15         18
            24          9
        ]

@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(fn, width, floatmat; padding = missing)
expected = map(x -> ismissing(x) ? x : Float64(x), expected)
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)


# pad last

result = tiling(fn, width, intvec; padding = 0, atend=true)
expected = [6, 15, 24, 0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(fn, width, floatvec; padding = 0.0, atend=true)
expected = map(x -> ismissing(x) ? x : Float64(x), expected)
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(fn, width, intmat; padding = 0, atend=true)
expected = [
            6 27
            15 18
            24  9
            0  0
        ]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = tiling(fn, width, floatmat; padding = 0.0, atend=true)
expected = map(x -> ismissing(x) ? x : Float64(x), expected)
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)


