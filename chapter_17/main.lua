
package.path = package.path..";.\\chapter_17\\?.lua"
Queue = require("queue")
GeometricRegion = require("geometric_region")

q = Queue.new()

function ex17_3_searcher(modname)
    filename, errmsg = package.searchpath(modname, package.path)
    if filename then
        
    else
        filename, errmsg = package.searchpath(modname, package.cpath)
    end
end


function exercise() 
    print("START EX17.1")
    Queue.pushLast(q, 3); print("Pushing 3")
    Queue.pushLast(q, 5); print("Pushing 5")
    Queue.pushLast(q, 2); print("Pushing 2")
    print("Popping ", Queue.popFirst(q))
    print("Popping ", Queue.popFirst(q))
    print("Popping ", Queue.popFirst(q))
    ok, msg = pcall(Queue.popFirst, q)
    print("Popping ", ok, msg)
    print("START EX17.2")
    rectangle = GeometricRegion.rect(0, 1, 0, 0.2)
    GeometricRegion.plot(rectangle, 20, 20)

    --     Exercise 17.4: Write a searcher that searches for Lua files and C libraries at the same time. For instance,
    -- the path used for this searcher could be something like this:
    --     ./?.lua;./?.so;/usr/lib/lua5.2/?.so;/usr/share/lua5.2/?.lua
    -- (Hint: use package.searchpath to find a proper file and then try to load it, first with loadfile
    -- and next with package.loadlib.)
    -- honestly didn't understand how to proceed, and left to the future, if maybe there will be, reader of this repository, as the solution is trivial 
    table.insert(package.searchers, ex17_3_searcher)

end

exercise()