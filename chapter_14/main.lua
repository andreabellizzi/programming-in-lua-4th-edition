
require("chapter_14.utils")

sparse1 = {
    [1] = {nil, nil,   3, nil, nil, nil},
    [2] = {nil,   4, nil, nil, nil, nil},
    [3] = {nil, nil, nil, nil,   5, nil}
}

sparse2 = {
    [1] = {nil, nil,   6, nil, nil, nil},
    [2] = {nil, nil, nil,  10, nil, nil},
    [3] = {  2, nil, nil, nil,   5, nil}
}

-- to check
sparseRes = {
    [1] = {nil, nil,   9, nil, nil, nil},
    [2] = {nil,   4, nil,  10, nil, nil},
    [3] = {  2, nil, nil, nil,   10, nil}
}

function add(a, b)
    local c = {} --result
    for i = 1, #a do
        local resrow = {} --resultrow
        for k, va in pairs(a[i]) do
            if b[i][k] then
                resrow[k] = va + b[i][k]
            else
                resrow[k] = va
            end
        end
        for j, vb in pairs(b[i]) do
            if a[i][j] then
                resrow[j] = a[i][j] + vb
            else
                resrow[j] = vb
            end
        end
        c[i] = resrow
    end
    return c
end

function print_mat(m)
    for i = 1, #m do
        for k, v in pairs(m[i]) do
            print(i, k, ":", v)
        end
    end
end

function print_path(graph, dist, prev, source, target)
    local sequence = {}
    local u = target
    print("Dist "..source.name.."->"..target.name..": "..dist[target.name])
    while u do
        table.insert(sequence, {dest=u, from=prev[u] or {name=""}, w=dist[u.name]})
        u = prev[u]
    end
    for i=1, #sequence do
        print(sequence[#sequence-i+1].from.name, sequence[#sequence-i+1].dest.name, sequence[#sequence-i+1].w)
    end
end

function exercise()
    print("START EX14.1")
    local c = add(sparse1, sparse2)
    print("SPARSE_RES REFERENCE:")
    print_mat(sparseRes)
    print("RESULT:")
    print_mat(c)

    print("START EX14.2")
    io.input("chapter_14/graph.txt")
    g = readgraph()
    io.close()
    a = name2node(g, "a")
    f = name2node(g, "f")
    d = name2node(g, "d")
    p = findpath(a, f)
    if p then printpath(p) end
    print("START EX14.4")
    dist, prev = dijkstra(g, a)
    print_path(g, dist, prev, a, f)
    print_path(g, dist, prev, a, d)
end

exercise()