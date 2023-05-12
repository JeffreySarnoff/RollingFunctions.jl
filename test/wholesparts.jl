

function testwholesparts(n, width, slide)
    nwindows = 0
    nextraindices = 0
    m = n
    while m > width
        nwindows += 1
        m -= slide
    end
    if m == width
        nwindows += 1
    else
        nextraindices = m
    end
    (; nwindows, nextraindices)
end

n, width, slide = 1000, 25, 1;
@test wholesparts(n, width, slide) == testwholesparts(n, width, slide)
n, width, slide = 1000, 25, 25;
@test wholesparts(n, width, slide) == testwholesparts(n, width, slide)
n, width, slide = 1000, 25, 17;
@test wholesparts(n, width, slide) == testwholesparts(n, width, slide)
n, width, slide = 1000, 25, 31;
@test wholesparts(n, width, slide) == testwholesparts(n, width, slide)
