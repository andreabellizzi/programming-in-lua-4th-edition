
function poly(a, x)
    local ret = a[0]
    local acc = x
    -- Exercise 5.5: Can you write the function from the previous item so that it uses at most n additions and n
    --     multiplications (and no exponentiations)?
    -- for i = 1, #a do
    --     ret = ret + a[i]*x^i
    -- end
    for i = 1, #a do
        ret = ret + a[i]*acc
        acc = acc*acc
    end
    return ret
end

function isvalidseq(tab)
    local counter = 0
    for i, v in pairs(tab) do
        counter = counter + 1
    end

    return counter == #tab and true or false
end

function move(orig, pos, target)
    if not isvalidseq(orig) or not isvalidseq(target) then return end
    local s = {}
    -- move the elements from #pos to end, to create space
    table.move(target, pos, #target, 1, s)
    table.move(orig, 1, #orig, pos, target)
    -- add again the elements
    table.move(s, 1, #s, #target+1, target)
end

function print_list(t)
    for i, v in ipairs(t) do
        print(i,v)
    end
end

function myconcat(list_of_strings)
    local s = ""
    for i,v in ipairs(list_of_strings) do
        s = s .. v
    end
    return s
end

function benchmark(func, iter, ...)
    local start_time = os.clock()
    for i = 1, iter do
        func(...)
    end
    local end_time = os.clock()
    print("Elapsed avg time="..(end_time-start_time)/iter.." seconds")
end

function exercise()
    print("START EX5.1")
    sunday = "monday"; monday = "sunday"
    t = {sunday = "monday", [sunday] = monday}
    print(t.sunday, t[sunday], t[t.sunday])

    print("START EX5.2")
    a = {}
    -- creating a field 'a' which point to itself, like creating a pointer that point to itself
    a.a = a
    print(a)
    print(a['a'])
    print(a.a)
    print(a.a.a)
    -- now we are assigning the number 3 to the field a of the table, the field a now becomes a number, but the table still remain
    a.a.a.a = 3
    -- so after this line line like this raise error "attempt to index a number value (field 'a') "
    --print(a.a.a)
    -- but this is ok (a is still a table, we changed only the field a)
    print(a.a)

    print("START EX5.3")
    -- Exercise 5.3: Suppose that you want to create a table that maps each escape sequence for strings (the
    -- section called “Literal strings”) to its meaning. How could you write a constructor for that table?
    t = {['\n'] = 'newline', ['\r'] = '\r'}
    print(t['\n'])

    print("START EX5.4")
    -- Exercise 5.4: We can represent a polynomial anxn + an-1xn-1 + ... + a1x1 + a0 in Lua as a list of its coef
    -- ficients, such as {a0, a1, ..., an}.
    -- Write a function that takes a polynomial (represented as a table) and a value for x and returns the poly
    -- nomial value.
    print(poly({[0] = 1, [1] = 3, [2] = 5}, 2))

    print("START EX5.6")
    -- Exercise 5.6: Write a function to test whether a given table is a valid sequence.
    print(isvalidseq({'1', '2', '3'}))
    print(isvalidseq({'1', nil, '3'}))

    print("START EX5.7")
    local orig = {1, 3, 4, 5}
    local target = {1, 4, 3}
    move(orig, 2, target)
    print_list(target)
    print("START EX5.8")
    local long_list_of_string = {}
    for i=1,1000 do
        long_list_of_string[i] = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    end
    benchmark(myconcat, 100, long_list_of_string)
    benchmark(table.concat, 100, long_list_of_string)

end


exercise()