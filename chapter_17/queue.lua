local Queue = {}

local function new()
    return {first=0, last=-1}
end

Queue.new = new

function Queue.pushFirst(queue, value)
    local first = queue.first - 1
    queue.first = first
    queue[first] = value
end

function Queue.pushLast(queue, value)
    local last = queue.last + 1
    queue.last = last
    queue[last] = value
end

function Queue.popFirst(queue)
    local first = queue.first
    if first > queue.last then error("queue empty") end
    local val = queue[first]
    queue[first] = nil --for garbage collection
    queue.first = first + 1
    if queue.first > queue.last then
        -- now queue is empty, resetting index
        queue.first = 0
        queue.last = -1
    end
    return val
end

function Queue.popLast(queue)
    local last = queue.last
    if queue.first > last then error("queue empty") end
    local val = queue[last]
    queue[last] = nil
    queue.last = last - 1
    if queue.first > queue.last then
        queue.first = 0
        queue.last = -1
    end
    return val
end

return Queue