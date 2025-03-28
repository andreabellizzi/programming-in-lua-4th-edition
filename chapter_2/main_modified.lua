-- Problem, place 8 queen in a 8x8 board
-- each row has a queen
-- solution is a permutation of 8 number, each representing the column of the i-th row, like
-- 3, 2, 8, 1, 4, 6, 7, 5 represents the solutions (1, 3), (2, 2) , (3, 8) and so on
package.path = "../libraries;" .. package.path
require("libraries.utils")
require("chapter_2.chap_2_utils")
Solutions = {}

permute(Solutions, {1, 2, 3, 4, 5, 6, 7, 8}, 8)

for i = 1, #Solutions do
    local isok = true
    for r = 1, N do
        if not isplaceok(Solutions[i], r, Solutions[i][r]) then isok = false; break end
    end
    if isok and not stop then print_solution(Solutions[i]) end
end
print(isplaceok_counter)

