
local GeometricRegion = {}
function GeometricRegion.disk(cx, cy, r)
    return function(x, y)
        return (x-cx)^2 + (y-cy)^2 <= r^2
    end
end

function GeometricRegion.rect(x1, x2, y1, y2)
    assert(x1 <= x2 and y1 <= y2)
    return function(x,y)
        return x1 <= x and x <= x2 and y1 <= y and y <= y2
    end
end

function GeometricRegion.complement(region)
    return function(x, y)
        return not region(x, y)
    end
end

function GeometricRegion.union(r1, r2)
    return function(x, y)
        return r1(x, y) or r2(x, y)
    end
end

function GeometricRegion.intersection(r1, r2)
    return function(x, y)
        return r1(x, y) and r2(x, y)
    end
end

function GeometricRegion.difference(r1, r2)
    return function(x, y)
        return r1(x, y) and not r2(x, y)
    end
end

function GeometricRegion.translate(r, dx, dy)
    return function(x, y)
        return r(x - dx, y - dy)
    end
end

function GeometricRegion.rotate(r, angle)
    return function(x, y)
        --apply rotation matrix in 2d
        return r(x*math.cos(angle) - y*math.sin(angle), x*math.sin(angle) + y*math.cos(angle))
    end
end

function GeometricRegion.plot(r, M, N)
    io.write("P1\n", M, " ", N, "\n") --header
    for i=1,N do
        local y = (N-i*2)/N -- for each line (mapping function to map value in [1, N] in [-1, 1])
        for j=1,N do
            local x = (j*2-M)/M --for each column
            io.write(r(x, y) and "1" or "0")
        end
        io.write("\n")
    end
end

return GeometricRegion