
counter = {}
words = {} --list of all the words
ignore = {}


function read_ignore()
    --exercise 11.2
    file = io.input("chapter_11/ignore.txt")
    for line in file:lines() do
        ignore[string.match(line, "%w+")] = true
    end
    file:close()
end

function read_txt(filename)
    file = io.input(filename)
    for line in file:lines() do
        for word in string.gmatch(line, "%w+") do
            -- if string.len(word) >= 5 then -- Exercise 11.1
            if not ignore[word] then
                counter[word] = (counter[word] or 0) + 1
            end
        end
    end
    file:close()
end

function sort_counter()
    for w, _ in pairs(counter) do
        words[#words + 1] = w
    end
    --sort the list of all words by the counter

    table.sort(words, function(w1, w2) 
        return counter[w1] > counter[w2] or ((counter[w1] == counter[w2]) and w1 < w2)
    end)

end


read_ignore()
read_txt("chapter_11/peterpan.txt")
sort_counter()
-- we've a table with { "word": counter} 
-- to sort it we need 
for i=1,10 do
    print(words[i], counter[words[i]])
end

