require("libraries.utils")
require("chapter_8.maze_game")


function exercise()
--     Exercise 8.1: Most languages with a C-like syntax do not offer an elseif construct. Why does Lua need
--  this construct more than those languages? 
-- because it has no switch case? to improve readbility in that case? I hate this fking questions

-- Exercise 8.2: Describe four different ways to write an unconditional loop in Lua. Which one do you prefer?
    -- way 1
    -- while true do
    --     code
    -- end

    -- way 2
    -- repeat
    --     code
    -- until false

    --way 3
    -- local i = 0
    -- do
    -- ::start::
    --     code
    --     if condition then goto finish else goto start end
    -- ::finish::
    -- end
    
    --way 4 (boh)
    print("START EX8.3")
    maze()
end



exercise()