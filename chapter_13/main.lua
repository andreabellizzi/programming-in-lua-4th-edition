
function newBitArray(n)
    -- creates an array of n bit
    local array = {}
    -- each integer is 64 bit
    local nInteger = math.ceil(n/64)
    for i = 1, nInteger do
        array[i] = 0
    end
    return array
end

function setBit(a, v, n)
    -- assigns the Boolean value v to bit n of array a
    local intIdx = math.ceil(n/64)
    local offset = n%64
    if intIdx <= #a then
        if v then
            a[intIdx] = a[intIdx] | (1<<offset)
        else
            a[intIdx] = a[intIdx] & ~(1<<offset)
        end
    end
end

function testBit(a, n)
    -- testBit(a, n) (returns a Boolean with the value of bit n)
    local intIdx = math.ceil(n/64)
    local offset = n%64
    if intIdx <= #a then
        return (a[intIdx] & (1<<offset)) ~= 0
    end
    return nil
end

function umod(n, d)
    --unsigned modulo, considering negative value as unsigned value on 64bit
    if (d < 0) then
        -- means d is greater of 2^63, because bit 64 is 1 and indicates the sign
        if math.ult(n, d) then return n -- math.ult is unsigned less than, so not considering bit 64 as sign bit, if n < d the rest is n, 9%10 = 9
        else return n-d -- if n>d than the quotient can be only 1 because the numbers are both in range of 2^63 to 2^64-1 so the rest is n-d
        end 
    end
    -- computing the division
    local q = ((n >> 1) // d) << 1
    local r = n - q * d
    if not math.ult(r, d) then q = q + 1 end
    return n - q*d
end

function ispowtwo(n)
    local i = 0
    local mask = 1
    -- find the first one
    while(n&(1<<i) == 0) do
        i = i + 1
    end
    return n == (1<<i)
end

function hamming(n)
    local h = 0
    -- find the first one
    for i = 0, 63 do
        if ((1<<i)&n ~= 0) then h = h + 1 end
    end
    return h
end

function palindrome(n)
    local j = 63
    local i = 0
    for k = 1, 32 do
        if ((n&(1<<j))>>63) ~= n&(1<<i) then return false end
        i = i + 1
        j = j - 1
    end
    return true
end

function encode_file(filename, records)
    local out = io.open(filename, "wb")
    for k, record in ipairs(records) do
        out:write(string.pack("i8", record[1]))
        out:write(string.pack("c3", record[2]))
        out:write(string.pack("f", record[3]))
    end
    out:close()
end

function decode_file(filename)
    local inp = io.open(filename, "rb")
    local records = {}
    local line
    repeat
        local record = {}
        line = inp:read(8)
        if line then record[1] = string.unpack("i8", line) else break end
        line = inp:read(3)
        if line then record[2] = string.unpack("c3", line) else break end
        line = inp:read(4)
        if line then record[3] = string.unpack("f", line) else break end
        table.insert(records, record)
    until line == nil
    inp:close()
    return records
end

function exercise()
    --  Exercise 13.1: Write a function to compute the modulo operation for unsigned integers.
    print("START EX13.1")
    print(string.format("%u", -1152921504606846976))
    print(string.format("%u", umod(-1152921504606846976, 50000))) --4640
    -- Exercise 13.2: Implement different ways to compute the number of bits in the representation of a Lua integer.
    -- not understood what I have to do so skip
    print("START EX13.3") 
    -- Exercise 13.3: How can you test whether a given integer is a power of two?
    -- need to have only 1 bit set
    print(ispowtwo(2^14))
    print(ispowtwo(2^14+1))
    print("START EX13.4") 
    --Exercise 13.4: Write a function to compute the Hamming weight of a given integer. (The Hamming weight of a number is the number of ones in its binary representation.)
    print(hamming(2^14)) -- 1
    print(hamming(2^14+2^15+2^16)) -- 3
    print("START EX13.5") 
    --Exercise 13.5: Write a function to test whether the binary representation of a given integer is a palindrome.
    print(palindrome(0x8000000000000001))
    print(palindrome(0x8000000001000001))
    print("START EX13.6")
    local bitArr = newBitArray(70)
    print(testBit(bitArr, 60))
    setBit(bitArr, true, 60)
    print(testBit(bitArr, 60))
    setBit(bitArr, true, 65)
    print(testBit(bitArr, 65))
    setBit(bitArr, false, 65)
    print(testBit(bitArr, 65))

    print("START EX13.7")
    local records = {
        [1] = {
            1,
            "abc",
            1.5
        },
        [2] = {
            2,
            "def",
            2.5
        },
        [3] = {
            3,
            "ghi",
            1.0
        }
    }
    local records_read
    encode_file("chapter_13/records.out", records)
    --     Exercise 13.7: Suppose we have a binary file with a sequence of records, each one with the following
    --  format:
    --       struct Record {
    --         int x;
    --         char[3] code;
    --         float value;
    --       };
    --  Write a program that reads that file and prints the sum of the value fields.
    records_read = decode_file("chapter_13/records.out")
    local sum = 0.0
    for k, record in ipairs(records_read) do
        sum = sum + record[3]
        print(record[1])
        print(record[2])
        print(record[3])
    end
    print("sum is: "..sum)
end

exercise()