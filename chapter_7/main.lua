require("libraries.utils")
KB = 2^10



function exercise_7_1(file_in, file_out)
--  Exercise 7.1: Write a program that reads a text file and rewrites it with its lines sorted in alphabetical order.
--  When called with no arguments, it should read from standard input and write to standard output. When
--  called with one file-name argument, it should read from that file and write to standard output. When called
--  with two file-name arguments, it should read from the first file and write to the second.
    local stream_in = io.input()
    local stream_out = io.output()
    if file_in then stream_in = io.input(file_in) end
    if file_out then stream_out = io.output(file_out) end
    -- io.input(stream_in)
    local string_list = {}
    local read = stream_in:read("L")
    while read and read ~= '\n' do
        table.insert(string_list, read)
        read = stream_in:read("L")
    end

    table.sort(string_list)

    print("START sorted list:")
    for _,v in ipairs(string_list) do
        stream_out:write(v)
    end
    print("END sorted list:\n")

    stream_in:close()
    stream_out:close()

end

function exercise_7_3_byte()
    local fout = io.output("chapter_7/ex_7_3_out.txt", "w")
    local fin =  io.input("chapter_7/ex7_3_in.txt")
    local towrite = fin:read(1)
    while towrite do
        fout:write(towrite)
        towrite = fin:read(1)
    end
    fin:close()
    fout:close()
end

function exercise_7_3_line()
    local fout = io.output("chapter_7/ex_7_3_out.txt", "w")
    local fin =  io.input("chapter_7/ex7_3_in.txt")
    local towrite = fin:read("L")
    while towrite do
        fout:write(towrite)
        towrite = fin:read("L")
    end
    fin:close()
    fout:close()
end

function exercise_7_3_chunk()
    local fout = io.output("chapter_7/ex_7_3_out.txt", "w")
    local fin =  io.input("chapter_7/ex7_3_in.txt")
    local towrite = fin:read(8*KB)
    while towrite do
        fout:write(towrite)
        towrite = fin:read(8*KB)
    end
    fin:close()
    fout:close()
end

function exercise_7_3_whole()
    local fout = io.output("chapter_7/ex_7_3_out.txt", "w")
    local fin =  io.input("chapter_7/ex7_3_in.txt")
    local towrite = fin:read("a")
    fout:write(towrite)
    fin:close()
    fout:close()
end

function exercise_7_clean()
    local fout = io.output("chapter_7/ex_7_3_out.txt", "w")
    fout:close()
end

function exercise_7_4(n)
    local f = io.input("chapter_7/temp.txt")
    local char_read = ''
    local offset = -1
    local n_line = n or 0
    local new_line_found = 0
    -- n_line + 1 because otherwise it stops at the newline at the end of the line we want to print, so we must
    -- read the entire line until the next new line
    while char_read and new_line_found < n_line+1 do
        --searching the last newline
        f:seek("end", offset)
        char_read = f:read(1)
        if char_read == '\n' then new_line_found = new_line_found + 1 end
        offset = offset-1
    end
    print(f:read("a"))
    f:close()
end

function mkdir(path)
end

function rmdir(path)
end

function list_dir(path)
end


function exercise()
    print("START EX7.1")
    -- exercise_7_1() --removed to run in batch
    exercise_7_1("chapter_7/temp.txt")
    exercise_7_1("chapter_7/temp.txt", "chapter_7/ex7_2.txt")
    print("START EX7.3")
    -- Exercise 7.3: Compare the performance of Lua programs that copy the standard input stream to the standard
    -- output stream in the following ways:
    -- • byte by byte;
    -- • line by line;
    -- • in chunks of 8 kB;
    -- • the whole file at once.
    -- For the last option, how large can the input file be?
    -- local f = io.open("chapter_7/ex7_3_in.txt", "w")
    -- f:write(string.rep("A", 32*KB, '\n')) -- it should be 2 byte * 32kb = 64kb (idk why in windows it is 98302 length)
    -- f:close()
    exercise_7_clean()
    print("Byte:")
    benchmark(exercise_7_3_byte, 1)
    exercise_7_clean()
    print("Line:")
    benchmark(exercise_7_3_line, 1)
    exercise_7_clean()
    print("Chunk:")
    benchmark(exercise_7_3_chunk, 1)
    exercise_7_clean()
    print("Whole:")
    benchmark(exercise_7_3_whole, 1)
    exercise_7_clean()

    print("START EX7.4")
--  Exercise 7.4: Write a program that prints the last line of a text file. Try to avoid reading the entire file
--  when the file is large and seekable.
    exercise_7_4()

    print("START EX7.5")
--  Exercise 7.5: Generalize the previous program so that it prints the last n lines of a text file. Again, try to
--  avoid reading the entire file when the file is large and seekable.
    exercise_7_4(2)

    print("START EX7.6")
--  Exercise 7.6: Using os.execute and io.popen, write functions to create a directory, to remove a
--  directory, and to collect the entries in a directory.
    
    print("START EX7.7")
--  Exercise 7.7: Can you use os.execute to change the current directory of your Lua script? Why?
end



exercise()
