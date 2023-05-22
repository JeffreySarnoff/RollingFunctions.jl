

function testwholesparts(n, width, slide)
    nwindows = 0
    nextraindices = 0
    m = n
    while m >= width
        nwindows += 1
        m -= slide
    end
    nextraindices = m
    (; nwindows, nextraindices)
end

n, width, slide = 1000, 25, 1;
@test all(Tuple(wholesparts(n, width, slide)) .== Tuple(testwholesparts(n, width, slide)))
n, width, slide = 1000, 25, 25;
@test all(Tuple(wholesparts(n, width, slide)) .== Tuple(testwholesparts(n, width, slide)))
n, width, slide = 1000, 25, 17;
@test all(Tuple(wholesparts(n, width, slide)) .== Tuple(testwholesparts(n, width, slide)))
n, width, slide = 1000, 25, 31;
@test all(Tuple(wholesparts(n, width, slide)) .== Tuple(testwholesparts(n, width, slide)))
