function listNew ()
    return {first = 0, last = -1}
end

function pushFirst (list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
end

function pushLast (list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end

function popFirst (list)
    local first = list.first
    if list.first > list.last then error("list is empty") end
    local value = list[first]
    list[first] = nil        -- to allow garbage collection
    list.first = first + 1
    if first > list.last then 
        list.first = 0
        list.last = -1
    end
    return value
end

function popLast (list)
    local last = list.last
    if list.first > last then error("list is empty") end
    local value = list[last]
    list[last] = nil         -- to allow garbage collection
    list.last = last - 1
    if first > list.last then 
        list.first = 0
        list.last = -1
    end
    return value
end


----- graph

function printpath (path)
    for i = 1, #path do
        print(path[i].node.name, path[i].weight)
    end
end


function findpath (curr, to, path, visited, weight)
    weight = weight or 0
    path = path or {}
    visited = visited or {}
    if visited[curr] then     -- node already visited?
        return nil              -- no path here
    end
    visited[curr] = true      -- mark node as visited
    path[#path + 1] = {node=curr, weight=weight}    -- add it to path
    if curr == to then        -- final node?
        return path
    end
    -- try all adjacent nodes
    for node, w in pairs(curr.arcs) do
        local p = findpath(node, to, path, visited, w)
        if p then return p end
    end
    table.remove(path)        -- remove node from path
end

function name2node (graph, name)
    local node = graph[name]
    if not node then
        -- node does not exist; create a new one
        node = {name = name, arcs = {}}
        graph[name] = node
    end
    return node
end

function readgraph ()
    local graph = {}
    for line in io.lines() do
        -- split line in two names
        local namefrom, nameto, label  = string.match(line, "(%S+)%s+(%S+)%s+(%S+)")
        -- find corresponding nodes
        local from = name2node(graph, namefrom)
        local to = name2node(graph, nameto)
        local weight = tonumber(label)
        -- adds 'to' to the adjacent set of 'from'
        from.arcs[to] = weight
    end
    return graph
end



function dijkstra(graph, source, target)
    -- implementation from https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
    -- dijkstra algorithm calculate and find the shortest path
    -- from node source to all nodes in graph
    -- if target is used, this implementation search the shortest path from source to target

    local min_dist_in_q = function(_q, dist)
        local _min = math.maxinteger
        local _nodename = nil
        for k, v in pairs(_q) do
            if k and k ~= "size" and v and dist[k] <= _min then
                _min = dist[k]
                _nodename = k
            end
        end
        return _nodename, _min
    end

    local neighbor_of_u_still_in_q = function(_q, arcs)
        -- this function returns a list of nodename that are adjent to u and are in Q
        local neighbor = {}
        for v in pairs(_q) do
            if arcs[graph[v]] then
                table.insert(neighbor, v)
            end
        end
        return neighbor
    end

    -- source is a node object
    -- target is a node object
    local dist = {}
    local prev = {}
    local q = {size = 0}
    -- firstly we need to initialize all distance to each node to infinity
    -- except for source wich is 0
    for nodename in pairs(graph) do
        dist[nodename] = math.maxinteger
        prev[nodename] = nil
        q[nodename] = true
        q.size = q.size + 1
    end
    dist[source.name] = 0
    q[source.name] = true
    while q.size > 0 do
        -- u is the vertex with minimum distance current in Q
        local u, weight = min_dist_in_q(q, dist)
        if target and u == target.name then
            break
        end
        q[u] = nil -- remove u from Q
        q.size = q.size - 1
        local neighbor = neighbor_of_u_still_in_q(q, graph[u].arcs)
        for i=1, #neighbor do
            local v = graph[neighbor[i]]
            local alt = dist[u] + graph[u].arcs[v]
            if alt < dist[v.name] then
                dist[v.name] = alt
                prev[v] = graph[u]
            end
        end
    end

    return dist, prev
end