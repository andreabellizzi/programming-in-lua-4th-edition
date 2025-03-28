require("chapter_4.utils")


function insert(start, pos, insert)
    -- Exercise 4.3: Write a function to insert a string into a given position of another one:
    --     > insert("hello world", 1, "start: ")    --> start: hello world
    --     > insert("hello world", 7, "small ")     --> hello small world
    
    return pos==1 and insert..start or string.sub(start, 1, pos-1)..insert..string.sub(start, pos, #start)
end

function remove(s, i, j)
    -- Exercise 4.5: Write a function to remove a slice from a string; the slice should be given by its initial
    --     position and its length:
    --          > remove("hello world", 7, 4)     --> hello d
    return s:sub(1, i-1)..s:sub(i+j, #s)
end

function ispali(s)
--     Exercise 4.7: Write a function to check whether a given string is a palindrome:
--         > ispali("step on no pets")     --> true
--         > ispali("banana")              --> false
--    Exercise 4.8: Redo the previous exercise so that it ignores differences in spaces and punctuation.
    local sstrip = s
    local changes = 1
    local toremove = {'.', ',', ':', ';'}

    sstrip = sstrip:gsub("[%p]", " ")
    while changes ~= 0 do
        sstrip, changes = sstrip:gsub("  ", " ")
    end

    return sstrip:reverse() == sstrip
end

function exercise()
    print("START EX4.1")
    local s = [=[
<![CDATA[
    Hello world
]]>]=]
    print(s)
    local ss = "<![CDATA[\r\n   Hello world\r\n]]>"
    print(ss)
    print([=[
<![CDATA[
    Hello world
]]>]=] == "<![CDATA[\n    Hello world\n]]>")

    print("START EX4.3")
    print(insert("hello world", 1, "start: "))
    print(insert("hello world", 7, "small "))

    print("START EX4.5")
    print(remove("hello world", 7, 4))

    print("START EX4.7")
    print(ispali("step   on. no pets"))
    print(ispali("banana"))
end



exercise()