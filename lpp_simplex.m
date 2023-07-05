clc;
clear all
a=[3,-1,2,1,0,0;-2,4,0,0,1,0;-4,3,8,0,0,1]
cost = [-1 3 -2 0 0 0 0]
b=[7;12;10]
A = [a, b]
bv = [4 5 6]
var = {'x1', 'x2','x3', 's1', 's2', 's3', 'sol'}
zjcj = cost(bv)*A - cost
simplex_table = [A; zjcj]
array2table(simplex_table, "VariableNames",var)
run = true
while run
    if any(zjcj(1:end-1) < 0)
        fprintf('Soln is not optimal.')
        zc = zjcj(1:end-1)
        [Enter_Value, pvt_col] = min(zc)
        if all(A(:, pvt_col) <= 0)
            error('LPP is unbounded')
        else
            sol = A(:, end)
            column = A(:, pvt_col)
            for i = 1:size(A, 1)
                if column(i) > 0
                    ratio(i) = sol(i)./column(i) 
                else 
                    ratio(i) = inf
                end
            end
            [leaving_value, pvt_row] = min(ratio)
        end
        bv(pvt_row) = pvt_col
        pvt_key = A(pvt_row, pvt_col)
        A(pvt_row, :) = A(pvt_row, :) ./ pvt_key
        for i = 1:size(A, 1)
            if i ~= pvt_row
                A(i, :) = A(i, :) - A(i, pvt_col) * A(pvt_row, :)
            end
        end
        zjcj = cost(bv) * A - cost
        nest_table = [A; zjcj]
        array2table(nest_table, "VariableNames",var)
    else
       run = false
   fprintf('Optimal sol is %f\n', zjcj(end))
    end
end
