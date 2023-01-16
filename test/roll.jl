intvec = collect(1:10);
floatvec = collect(1.0:10.0);
window_span = 7
window_fn = sum

result = RollingFunctions.basic_rolling(intvec, window_span, window_fn)
expected = [28, 35, 42, 49]
@test result == expected
@test typeof(result) == typeof(expected)

result = RollingFunctions.basic_rolling(floatvec, window_span, window_fn)
expected = [28.0, 35.0, 42.0, 49.0]
@test result == expected
@test typeof(result) == typeof(expected)
