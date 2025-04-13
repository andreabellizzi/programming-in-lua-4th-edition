-- goto room1      -- initial room
-- ::room1:: do
--   local move = io.read()
--   if move == "south" then goto room3
--   elseif move == "east" then goto room2
--   else
--     print("invalid move")
--     goto room1     -- stay in the same room
--   end
-- end
-- ::room2:: do
--   local move = io.read()
--   if move == "south" then goto room4
--   elseif move == "west" then goto room1
--   else
--     print("invalid move")
--     goto room2
--   end
-- end
-- ::room3:: do
--   local move = io.read()
--   if move == "north" then goto room1
--   elseif move == "east" then goto room4
--   else
--     print("invalid move")
--     goto room3
--   end
-- end
-- ::room4:: do
--   print("Congratulations, you won!")
-- end

local map = {
    ['n'] = 'n',
    ['north'] = 'n',
    ['s'] = 's',
    ['south'] = 's',
    ['e'] = 'e',
    ['est'] = 'e',
    ['w'] = 'w',
    ['west'] = 'w'
}

function read_input()
    local move = nil
    repeat
        print('[n]orth, [s]outh, [e]st, [w]est')
        move = io.read()
        move = move:lower()
        move = map[move]
    until move
    return move
end

function room1()
    print_room('s', 'e')
    move = read_input()
    if move == 's' then return room2()
    elseif move == 'e' then return room3()
    else return room1() end
end

function room2()
    print_room('s', 'w')
    move = read_input()
    if move == 's' then return room4()
    elseif move == 'w' then return room1()
    else return room2() end
end

function room3()
    print_room('n', 'e')
    move = read_input()
    if move == 'n' then return room1()
    elseif move == 'e' then return room4()
    else return room3() end
end

function room4()
    print('Congratulation! you won!')
end

function maze()
    room1()
end


function print_room(...)
    local d1, d2, d3, d4 = table.unpack({...}, 1, 4)
    local n = (d1 == 'n' or d2 == 'n' or d3 == 'n' or d4 == 'n') and 'n' or '*'
    local s = (d1 == 's' or d2 == 's' or d3 == 's' or d4 == 's') and 's' or '*'
    local e = (d1 == 'e' or d2 == 'e' or d3 == 'e' or d4 == 'e') and 'e' or '*'
    local w = (d1 == 'w' or d2 == 'w' or d3 == 'w' or d4 == 'w') and 'w' or '*'

    local north = '****'.. n .. '****' 
    local south = '****'.. s .. '****' 
    local estwest   = [[*       *
]]..e..'       '..w..[[

*       *]]
    print(north)
    print(estwest)
    print(south)
end