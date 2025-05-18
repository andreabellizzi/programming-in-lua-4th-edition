


count = 0
function serialize (o, indent)
    local indent = indent or ""
    local t = type(o)
    if t == "number" or t == "string" or t == "boolean" or t == "nil" then
        io.write(indent, string.format("%q", o))
    elseif t == "table" then
        io.write("{\n")
        for k,v in pairs(o) do
            io.write(indent, "  ", k, " = ")
            serialize(v, type(v) == "table" and "    " or nil)
            io.write(",\n")
        end
        io.write(indent,"}\n")
    else
        error("cannot serialize a " .. type(o))
    end
end
  
function serialize_ex_15_2 (o, indent)
    local indent = indent or ""
    local t = type(o)
    if t == "number" or t == "string" or t == "boolean" or t == "nil" then
        io.write(indent, string.format("%q", o))
    elseif t == "table" then
        io.write("{\n")
        local list = {}
        local counter = 1
        for i, v in ipairs(o) do
            counter = counter + 1
            io.write(indent, "    ")
            serialize_ex_15_2(v, type(v) == "table" and indent.."    " or nil)
            io.write(",\n")
        end

        for k,v in pairs(o) do
            if type(k) == "number" and k<counter then goto continue end
            io.write(indent, "    ", "[\"", k, "\"] = ")
            serialize_ex_15_2(v, type(v) == "table" and indent.."    " or nil)
            io.write(",\n")
            ::continue::
        end
        io.write(indent,"}\n")
    else
        error("cannot serialize a " .. type(o))
    end
end

function basicSerialize (o)
    -- assume 'o' is a number or a string
    return string.format("%q", o)
end

function save (name, value, saved)
    saved = saved or {}                 -- initial value
    io.write(name, " = ")
    if type(value) == "number" or type(value) == "string" then
      io.write(basicSerialize(value), "\n")
    elseif type(value) == "table" then
        if saved[value] then              -- value already saved?
            io.write(saved[value], "\n")    -- use its previous name
        else
            saved[value] = name             -- save name for next time
            io.write("{}\n")                -- create a new table
            for k,v in pairs(value) do      -- save its fields
                k = basicSerialize(k)
                local fname = string.format("%s[%s]", name, k)
                save(fname, v, saved)
            end
        end
    else
        error("cannot save a " .. type(value))
    end
end
  
function Entry(e)
    print(e[1], e[2])
    count = count + 1
end

function exercise()
    dofile("chapter_15/entry.lua")
    print(count)

    print("START EX15.1")
    -- Exercise 15.1: Modify the code in Figure 15.2, “Serializing tables without cycles” so that it indents nested  tables. 
    -- (Hint: add an extra parameter to serialize with the indentation string.)

    serialize({
        x=1,
        y=2,
        c = {1,2,3}
    })
    print("START EX15.2")
    serialize_ex_15_2({
        5,
        x=1,
        y=2,
        c = {1,2,3, {4,5,6}}
    })

    -- TODO: complete exercise
end


exercise()
