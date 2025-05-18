require("libraries.utils")

function stringrep(s, n)
    local r = ""
    if n > 0 then
        while n > 1 do
        if n % 2 ~= 0 then  r = r .. s  end
        s = s .. s
        n = math.floor(n / 2)
        end
        r = r .. s
    end
    return r
end

function stringrep_builder(n)
    local ret = "function stringrep_"..n.."(s)\n"
    ret = ret.."    local r=\"\"\n"
    if n > 0 then
        while n > 1 do
        if n % 2 ~= 0 then  ret = ret.."    r = r .. s\n"  end
        ret = ret.."    s = s .. s\n"
        n = math.floor(n / 2)
        end
        ret = ret.."    r = r .. s\n"
    end
    ret = ret.."    return r\n"
    ret = ret.."end\n"
    -- print(ret)
    return ret
end


function ex16_1_reader_fn()
    ex16_first_time = ex16_first_time or 0
    if ex16_first_time == 0 then
        ex16_first_time = 1
        return "x^2"
    elseif ex16_first_time == 1 then
        ex16_first_time = 2
        return "+x"
    else
        return nil
    end
end


function loadwithprefix(prefix, chunk, chunkname, mode, env)
    -- same input as load plus prefix
    assert(type(chunk) == "string" or type(chunk) == "function")
    local prefix_returned = false
    local reader --the reader function
    if type(chunk) == "string" then
        local chunk_returned = false
        reader = function() 
            if not prefix_returned then prefix_returned = true; return prefix;
            elseif not chunk_returned then chunk_returned = true; return chunk;
            else return nil end
        end
    elseif type(chunk) == "function" then
        reader = function()
            if not prefix_returned then prefix_returned = true; return prefix;
            else return chunk() end
        end
    else
        error("chunk must be a string or a function", 2)
    end
    return load(reader, chunkname, mode, env)
end

function multiload(...)
    local reader_index = 0
    local readers = {...}
    local reader = function()
        reader_index = reader_index + 1
        if reader_index <= #readers then assert(type(readers[reader_index]) == "string" or type(readers[reader_index]) == "function") end
        if type(readers[reader_index]) == "string" then 
            return readers[reader_index]
        elseif type(readers[reader_index]) == "function" then
            return readers[reader_index]()
        else
            return nil
        end
    end
    return load(reader)
end



function exercise()
    print("START EX16.1")
    local f = assert(loadwithprefix("return ","x^2+x", nil, "t", _ENV))
    for i = 1, 10 do
        x = i   -- global 'x' (to be visible from the chunk)
        print(string.rep("*", f()))
    end

    print("START EX16.2")
    f, msg = multiload("local x = 10;",
                    io.lines("chapter_16/temp", "*L"),
                    " print(x)")
    f()
    
    print("START EX16.3")
    f = load(stringrep_builder(100000)); f() --define the function stringrep_3
    benchmark(stringrep_100000, 1000, "*")
    benchmark(stringrep, 1000, "*", 100000) --it's better, the code is smaller instead of unrolling 10000 of rep, so better caching
    print("START EX16.4")
    local ok, msg = pcall(pcall, "p") --pcall never raise error, so pcall(pcall, f) can never raise error, is important because otherwise it means pcall can fail, and we need to handle a potential error
    -- but this means it is not a protected call
    print(ok, msg)
end




exercise()