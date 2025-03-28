require("chapter_3.utils")

function exercise_3_1()
    print("START EX3.1")
    print(.0e12)
    --print(.e12)
    --print(0.0e)
    print(0x12)
    --print(0xABFG)
    print(0xA)
    print(FFFF)
    print(0xFFFFFFFF)
    --print(0x)
    print(0x1P10)
    print(0.1e1)
    print(0x0.1p1)
    print("END EX3.1\n")
end

function exercise_3_2()
    print("START EX3.2")
    print(math.maxinteger)
    print(math.mininteger)
    print(math.maxinteger * 2)
    print(math.mininteger * 2)
    print(math.maxinteger * math.mininteger)
    print(math.mininteger * math.mininteger)
end

function exercise_3_3()
    print("START EX3.3")
    for i = -10, 10 do
        -- remember that a % b = a - (a//b) * b
        -- where a//b is the floor division (rounded to lowest nearest number) (10//3) = 3.33 = 3, -10//3 = -3.33 = -4
        -- so -10 % 3 = -10 - (-10//3) * 3
        --            = -10 - (-4) * 3
        --            = -10 - (-12) = 2
        print(i, i%3)
    end
end

function exercise_3_4()
    print("START EX3.4")
    print(2^3^4) --is equal to 2^(3^4)
    print(2^-3^4) -- is equal to 2^(-3^4)
end

function exercise_3_5()
    print("START EX3.5")
    print(string.format("%a", 12.7))
    print(string.format("%a", 5.5))
end

function exercise_3_6(h, a)
    print("START EX3.6")
    -- h height
    -- a angle between (0, h) and x-axis
    -- the r of cone circle base is h*cos(angle)
    -- area is pi^2*r + pi*r*s where s is the hypotenuses of r and h triangle
    local r = h*math.cos(a)
    local s = math.sqrt(h^2+r^2)
    print(math.pi^2*r + math.pi*r*s)
end

function exercise_3_7()
    print("START EX3.7")
    math.randomseed(os.time())
    print(math.random(100))
end


exercise_3_1()
exercise_3_2()
exercise_3_3()
exercise_3_4()
exercise_3_5()
exercise_3_6(10, math.pi/4)
exercise_3_7()
