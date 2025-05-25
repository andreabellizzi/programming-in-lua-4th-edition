

function fromtostep(n, m, step)
    local currentState = n - step
    return function()
        currentState = currentState + step
        return (currentState <= m) and currentState or nil
    end
end

-- fromtostep stateless iterator version
local function _fromtostep(state, i)
    i = i + state.step
    if i <= state.m then
        return i, i
    else
        return nil
    end
end

function fromtostep_stateless(n, m, step)
    return _fromtostep, {m=m, step=step}, n-step
end

function fromto(n, m)
    local currentState = n - 1
    return function() 
        currentState = currentState + 1
        return (currentState <= m) and currentState or nil
    end
end

-- stateless iterator version
-- This version does not maintain any state between calls, making it stateless.
--  More precisely, a construction like
--       for var_1, ..., var_n in explist do block end
--  is equivalent to the following code:
--       do
--         local _f, _s, _var = --explist
--         while true do
--           local var_1, ... , var_n = _f(_s, _var)
--           _var = var_1
--           if _var == nil then break end
--              --block
--         end
--       end
-- in this case _f is the function _fromto, _s is the state m, and _var is the state n - 1.
-- The function _fromto is called with the state m and the current value of n - 1.

local function _fromto(m, i)
    i = i + 1
    if i <= m then
        return i, i
    else
        return nil
    end
end

function fromto_stateless(n, m)
    return _fromto, m, n - 1
end


function uniquewords(filename)
    local words = {}
    local line = io.read()
    local pos = 1
    return function()
        while line do
            local word, e = string.match(line, "(%w+)()", pos)
            if word then
                pos = e
                if not words[word] then
                    words[word] = true
                    return word
                end
                -- word was present in words, so continue
            else
                line = io.read()
                pos = 1
            end
        end
        return nil
    end
end

-- return all non-empty substrings of a given string s, assuming only one word, not a phrase
---@param s string 
function substrings(s)
    local _s = string.match(s, "(%w+)") -- take only the first non-empty words
    local _len = string.len(s)
    local i = 1
    local j = i-1
    return function ()
        j = j + 1
        if j > _len then
            i = i + 1
            j = i
            if i > _len then return nil end
        end
        return string.sub(_s, i, j)
    end
end



--- traverse all subsets of given set apply function fn
---@param set any
---@param fn any
function subsets(set, fn)
    local subs = {}
    local n = #set
    local subs_idx = 0
    -- an element will be present or not in the subset
    -- using bit 0 to indicates if not present, and bit 1 to indicates if present
    -- we can iterate over all the 2^n combination, where n is the length of the set

    for i = 1, 2^(#set) do
        for j = 0, #set-1 do
            if (i & (1<<j) ~= 0) then --if the jth bit is set
                subs_idx = subs_idx + 1
                subs[subs_idx] = set[j+1]
            end
        end
        subs[subs_idx+1] = nil
        subs_idx = 0
        fn(subs)
    end
end

function exercise()
    print("START EX18.1")
    --  Exercise 18.1: Write an iterator fromto such that the next loop becomes equivalent to a numeric for:
    --       for i in fromto(n, m) do
    --  body
    --       end
    --  Can you implement it as a stateless iterator? yes
    for i in fromto(1, 5) do
        print(i)
    end

    print("stateless version")
    for i in fromto_stateless(1, 5) do
        print(i)
    end

    print("START EX18.2")
    --     Exercise 18.2: Add a step parameter to the iterator from the previous exercise. Can you still implement
    -- it as a stateless iterator? yes
    for i in fromtostep(1, 10, 2) do
        print(i)
    end
    print("stateless version")

    for i in fromtostep_stateless(1, 10, 2) do
        print(i)
    end

    print("START EX18.3")
    -- Exercise 18.3: Write an iterator uniquewords that returns all words from a given file without repetitions.
    --  (Hint: start with the allwords code in Figure 18.1, “Iterator to traverse all words from the standard
    --  input”; use a table to keep all words already reported.)
    local check = {}
    io.input("chapter_18/temp.txt")
    for word in uniquewords("chapter_18/temp.txt") do
        check[word] = check[word] and check[word] + 1 or 1
    end
    for k, v in pairs(check) do
        if v > 1 then error("Words "..k.." printed more than 1, printed "..v.." times") end
        print(k, v)
    end
    io.close()

    print("START EX18.4")
    --  Exercise 18.4: Write an iterator that returns all non-empty substrings of a given string.
    s = "apple"
    for subs in substrings(s) do
        print(subs)
    end

    print("START EX18.5")
    --     Exercise 18.5: Write a true iterator that traverses all subsets of a given set. (Instead of creating a new table
    --  for each subset, it can use the same table for all its results, only changing its contents between iterations.)
    local set = {1, 2, 3}
    subsets(set, function(_set) print("\nStart set"); for _,v in ipairs(_set) do print(v) end print("End set") end)
end




exercise()