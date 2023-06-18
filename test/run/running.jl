intvec = collect(1:10);
floatvec = collect(1.0:10.0);
intmat = hcat(intvec, reverse(intvec));
floatmat = hcat(floatvec, reverse(floatvec));

width = 7
fn = sum

result = running(fn, width, intvec)
expected = [1, 3, 6, 10, 15, 21, 28, 35, 42, 49]
@test result == expected
@test typeof(result) == typeof(expected)

result = running(fn, width, floatvec)
expected = Float64[1, 3, 6, 10, 15, 21, 28, 35, 42, 49]
@test result == expected
@test typeof(result) == typeof(expected)

result = running(fn, width, intmat)
expected = [
            1  10
            3  19
            6  27
            10  34
            15  40
            21  45
            28  49
            35  42
            42  35
            49  28]
@test result == expected
@test typeof(result) == typeof(expected)

result = running(fn, width, floatmat)
expected = map(Float64, expected)
@test result == expected
@test typeof(result) == typeof(expected)

# taper first

result = running(fn, width, intvec; atend = false)
expected = [1, 3, 6, 10, 15, 21, 28, 35, 42, 49]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = running(fn, width, floatvec; atend = false)
expected = map(Float64, expected)
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = running(fn, width, intmat; atend = false)
expected = [
             1  10
             3  19
             6  27
            10  34
            15  40
            21  45
            28  49
            35  42
            42  35
            49  28
        ]
@test result == expected

result = running(fn, width, floatmat; atend = false)
expected = map(Float64, expected)
@test result == expected

# taper last

result = running(fn, width, intvec; atend=true)
expected =  [ 28, 35, 42, 49, 45, 40, 34, 27, 19, 10]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = running(fn, width, floatvec; atend=true)
expected = map(Float64, expected)
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = running(fn, width, intmat; atend=true)
expected = [
            28  49
            35  42
            42  35
            49  28
            45  21
            40  15
            34  10
            27   6
            19   3
            10   1
        ]
@test result == expected

result = running(fn, width, floatmat; atend=true)
expected = map(Float64, expected)
@test result == expected


