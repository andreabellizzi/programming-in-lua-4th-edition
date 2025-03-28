isplaceok_counter = 0
N = 8
stop = false

-- check whether a queen in position (n, c) could be attacked by any of n-1 placed queen
function isplaceok(a, n, c)
    isplaceok_counter = isplaceok_counter + 1
    for i = 1, n-1 do
        if (a[i] == c) or -- same column?
            (a[i] - i == c - n) or --column-row which is always constant if diagonal is same
            (a[i] + i == c + n) then
                return false
        end
    end
    return true -- no attack: place is OK
end

function print_solution(a)
    for i = 1, N do
        for j = 1, N do
            io.write(a[i] == j and "X" or "-", " ")
        end
        io.write("\n")
    end
    io.write("\n")
    stop = true
end
