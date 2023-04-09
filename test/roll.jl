clean(x) = x
clean(x::Missing) = Missing

intvec = collect(1:10);
floatvec = collect(1.0:10.0);
intmat = hcat(intvec, reverse(intvec));
floatmat = hcat(floatvec, reverse(floatvec));

span = 7
func = sum

result = rolling(intvec, span, func)
expected = [28, 35, 42, 49]
@test result == expected
@test typeof(result) == typeof(expected)

result = rolling(floatvec, span, func)
expected = [28.0, 35.0, 42.0, 49.0]
@test result == expected
@test typeof(result) == typeof(expected)

result = rolling(intmat, span, func)
expected = [28 49; 35 42; 42 35; 49 28]
@test result == expected
@test typeof(result) == typeof(expected)

result = rolling(floatmat, span, func)
expected = [28.0 49.0; 35.0 42.0; 42.0 35.0; 49.0 28.0]
@test result == expected
@test typeof(result) == typeof(expected)

# pad first

result = rolling(intvec, span, func; padding = missing)
expected = [missing, missing, missing, missing, missing, missing, 28, 35, 42, 49]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = rolling(floatvec, span, func; padding = missing)
expected = [missing, missing, missing, missing, missing, missing, 28.0, 35.0, 42.0, 49.0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = rolling(intmat, span, func; padding = missing)
expected = [missing missing; missing missing; missing missing; missing missing; missing missing; missing missing; 28 49; 35 42; 42 35; 49 28]
  
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = rolling(floatmat, span, func; padding = missing)
expected = [missing missing; missing missing; missing missing; missing missing; missing missing; missing missing; 28.0 49.0; 35.0 42.0; 42.0 35.0; 49.0 28.0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)


# pad last

result = rolling(intvec, span, func; padding = 0, padlast=true)
expected = [28, 35, 42, 49, 0, 0, 0, 0, 0, 0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = rolling(floatvec, span, func; padding = 0.0, padlast=true)
expected = [28.0, 35.0, 42.0, 49.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = rolling(intmat, span, func; padding = 0, padlast=true)
expected = [28 49; 35 42; 42 35; 49 28; 0 0; 0 0; 0 0; 0 0; 0 0; 0 0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)

result = rolling(floatmat, span, func; padding = 0.0, padlast=true)
expected = [28.0 49.0; 35.0 42.0; 42.0 35.0; 49.0 28.0; 0.0 0.0; 0.0 0.0; 0.0 0.0; 0.0 0.0; 0.0 0.0; 0.0 0.0]
@test map(clean, result) == map(clean, expected)
@test typeof(result) == typeof(expected)


