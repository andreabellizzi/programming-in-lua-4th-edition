function printtab(tab)
    for i = 1, #tab do
        print(tab[i])
    end
end

function fact(n)
    if n > 0 then
        return n*fact(n-1)
    else
        return 1
    end    
end


function swap(t, a, b)
    local _tmp  = t[a]
    t[a] = t[b]
    t[b] = _tmp
end

function iseven(num)
    return ((num % 2)== 0)
end

function table.copy(orig)
    return {unpack(orig)}
end

function permute(solutions, perm, n)
    -- c is an encoding of the stack state.
    -- c[k] encodes the for-loop counter for when permutations(k - 1, A) is called
    local c = {}

    for i = 1, n do
        c[i] = 1
    end
    table.insert(solutions, table.copy(perm))
    -- i acts similarly to a stack pointer
    i = 2
    while i <= n do
        if c[i] < i then
            if iseven(i) then swap(perm, 1, i) else swap(perm, c[i], i) end
            table.insert(solutions, table.copy(perm))
            -- Swap has occurred ending the while-loop. Simulate the increment of the while-loop counter
            c[i] = c[i] + 1
            -- Simulate recursive call reaching the base case by bringing the pointer to the base case analog in the array
            i = 1
        else
            c[i] = 1
            i = i + 1
        end
    end
end