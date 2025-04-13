require("chapter_9.geometric_region")

function poly(atable)
    return function(x)
        -- a0+a1*x^1+a2*x^2...
        local acc = x
        local sum = atable[1]
        for i=2,#atable do
            sum = sum + atable[i]*acc
            acc = acc*acc
        end
        return sum
    end
end

function exercise_9_2()
    function F(x)
        return { get = function() return x end; set = function(y) x=y end}
    end
    o1 = F(10)
    o2 = F(20)
    print(o1.get())
    print(o2.get())
    o1.set(100)
    o2.set(200)
    print(o1.get())
    print(o2.get())
end

function derivative(f, dx)
    dx = dx or 1e-4
    return function(x)
        return (f(x+dx)-f(x))/dx
    end
end

function integral(f, n)
    n = n or 1000
    return function(a, b)
        local dx = (b-a)/n
        local sum = 0
        local x = a
        for i=1, n do
            sum = sum + (f(x)*dx)
            x = x + dx
        end
        return sum
    end
end


function exercise()
    print("START EX9.1")
    sin = integral(math.cos)
    print(sin(0,1), math.sin(0))
    print(math.sin(1)-math.sin(0))
    print("START EX9.2")
    exercise_9_2()
    print("START EX9.3")
    f = poly({3, 0, 1})
    print(f(0))    --> 3
    print(f(5))    --> 28
    print(f(10))   --> 103
    print("START EX9.4")
    c1 = disk(0, 0, 1)
    c2 = disk(1, 0, 1)
    moon = difference(c1, c2)
    file = io.open("chapter_9/moon.bpm", "w")
    io.output(file)
    plot(moon, 500, 500)
    io.close(file)
    print("START EX9.5")
    rectangle = rect(0, 1, 0, 0.2)
    file = io.open("chapter_9/rect.bpm", "w")
    io.output(file)
    plot(rectangle, 500, 500)
    io.close(file)
    rectangle = rotate(rectangle, math.pi/4)
    file = io.open("chapter_9/rect_rot.bpm", "w")
    io.output(file)
    plot(rectangle, 500, 500)
    io.close(file)


end


exercise()