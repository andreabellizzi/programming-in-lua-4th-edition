require("libraries.utils")

function transliterate(astring, t)
    return (string.gsub(astring, ".", function (capture)
        if t[capture] == false then
            return ''
        else
            return t[capture]
        end
    end))
end


function exercise()
    print("START EX10.1")
    -- Exercise 10.1: Write a function split that receives a string and a delimiter pattern and returns a sequence
    --     with the chunks in the original string separated by the delimiter:
    --          t = split("a whole new world", " ")
    --          -- t = {"a", "whole", "new", "world"}
    for w in split("a whole new world", " ") do
        print(w)
    end

    print("START EX10.2")
    -- Exercise 10.2: The patterns '%D' and '[^%d]' are equivalent. What about the patterns '[^%d%u]' and '[%D
    -- %U]'
    -- [^%d%u] negative match of digit and uppercase letters, so match lowercase char
    -- [%D%U] match all not digit and all not uppercase letters, this won't work because
    -- a digit is a non uppercase letter so will match and invalidate the previous %D
    -- seems that lua with ^ will negate ALL the patterns that follows,
    -- while with simple %D%U will consider the OR of each pattern, so we're matching
    -- all that is not a digit, and not an uppercase letter, so a digit is not an uppercase letter so will match
    print(string.match('12A34a', "[^%d%u]"))
    print(string.match('12A34a', "[%D%U]"))

    -- Exercise 10.3: Write a function transliterate. This function receives a string and replaces each character
    --     in that string with another character, according to a table given as a second argument. If the table maps
    --     a to b, the function should replace any occurrence of a with b. If the table maps a to false, the function
    --     should remove occurrences of a from the resulting string.
    print("START EX10.3")
    print(transliterate("a fox in the forest", {
        a="b",
        c='d',
        e='f',
        x=false,
    }))
    -- I hate string and exercise on string, also I want make games, and honestly at the moment I don't want
    -- learn all this stuff about string, so, this chapter is left to the reader as it is trivial... :D


end


exercise()


