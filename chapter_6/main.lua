
require('libraries.utils')
function exercise_6_1(array)
    print(table.unpack(array))
    -- for i=1, #array do
    --     print(array[i])
    -- end
end

function exercise_6_2(...)
    return select(2, ...)    
end

function exercise_6_3(...)
    local s = table.pack(...)
    return table.unpack(s, 1, s.n-1)
end

function exercise_6_4(list)
    math.randomseed(os.time())
    for i=1, #list do
        -- make n swap with random changes
        swap(list, math.random(1, #list), math.random(1, #list))
    end
end


-- Function to generate all combinations of m elements from a list of n elements
function generate_combinations(arr, m)
    local result = {}

    -- Base case: if m == 0, return a single empty combination
    if m == 0 then
        table.insert(result, {})
        return result
    end

    -- Base case: if m is greater than the number of elements, return empty result
    if m > #arr then
        return result
    end

    -- Recursively generate combinations by adding each element to the result
    for i = 1, #arr - m + 1 do
        local rest_combinations = generate_combinations({table.unpack(arr, i + 1)}, m - 1)
        for _, comb in ipairs(rest_combinations) do
            table.insert(result, {arr[i], table.unpack(comb)})
        end
    end

    return result
end

function exercise_6_5(list, m)
    -- return all combination of m from a list of n without repetition (order doesn't matter, it is not a permutation)
    -- e.g. (1,2,3,4) n=4, m=2
    -- 1,2; 1,3; 1,4; 2,3; 2,4; 3,4;
    -- (Hint: you can use the recursive formula for combination: C(n,m) = C(n -1, m -1) + C(n - 1, m). To generate
    -- all C(n,m) combinations of n elements in groups of size m, you first add the first element to the result and
    -- then generate all C(n - 1, m - 1) combinations of the remaining elements in the remaining slots; then you
    -- remove the first element from the result and then generate all C(n - 1, m) combinations of the remaining
    -- elements in the free slots. When n is smaller than m, there are no combinations. When m is zero, there is
    -- only one combination, which uses no elements.)
    combinations = generate_combinations(list, m)

    -- Print the combinations
    for _, comb in ipairs(combinations) do
        print(table.concat(comb, ", "))
    end
    
end

function exercise_6_6()
    
end

function exercise()
    print("START EX6.1")
    -- Exercise 6.1: Write a function that takes an array and prints all its elements.
    exercise_6_1({'a','b','c','d','e','f'})
    print("START EX6.2")
    -- Exercise 6.2: Write a function that takes an arbitrary number of values and returns all of them, except
    --     the first one.
    print(exercise_6_2(1, 2, 3, 4))
    print("START EX6.3")
    -- Exercise 6.3: Write a function that takes an arbitrary number of values and returns all of them, except
    --     the last one.
    print(exercise_6_3(1,2,3,4))
    print("START EX6.4")
    -- Exercise 6.4: Write a function to shuffle a given list. Make sure that all permutations are equally probable.
    local s = {1,2,3,4,5,6,7,8,9}
    exercise_6_4(s)
    print(table.unpack(s))

    print("START EX6.5")
    -- Exercise 6.5: Write a function that takes an array and prints all combinations of the elements in the array.
    -- (Hint: you can use the recursive formula for combination: C(n,m) = C(n -1, m -1) + C(n - 1, m). To generate
    -- all C(n,m) combinations of n elements in groups of size m, you first add the first element to the result and
    -- then generate all C(n - 1, m - 1) combinations of the remaining elements in the remaining slots; then you
    -- remove the first element from the result and then generate all C(n - 1, m) combinations of the remaining
    -- elements in the free slots. When n is smaller than m, there are no combinations. When m is zero, there is
    -- only one combination, which uses no elements.)
    exercise_6_5({1,2,3,4}, 2)
    
    print("START EX6.6")
    --     Exercise 6.6: Sometimes, a language with proper-tail calls is called properly tail recursive, with the argu
    -- ment that this property is relevant only when we have recursive calls. (Without recursive calls, the maxi
    -- mum call depth of a program would be statically fixed.)
    --  Show that this argument does not hold in a dynamic language like Lua: write a program that performs an
    --  unbounded call chain without recursion. (Hint: see the section called “Compilation”.)
    exercise_6_6()
    
end

exercise()