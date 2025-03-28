-- Problem, place 8 queen in a 8x8 board
-- each row has a queen
-- solution is a permutation of 8 number, each representing the column of the i-th row, like
-- 3, 2, 8, 1, 4, 6, 7, 5 represents the solutions (1, 3), (2, 2) , (3, 8) and so on
require("chapter_2.chap_2_utils")

function add_queen(a, n)
    if n > N and not stop then
        print_solution(a)
    else
        for c = 1, N do
            if isplaceok(a, n, c) then
                a[n] = c
                add_queen(a, n+1)
            end
        end
    end
end

add_queen({}, 1)
print(isplaceok_counter)