clc;
clear all;
a = [1 3 -1 0 1 0; 1 1 0 -1 0 1];
b = [3; 2];
org_c = [-3 -5 0 0 -1 -1 0];
var = {'x1','x2','s1','s2','a1','a2','sol'};
org_var = {'x1','x2','s1','s2','sol'};
A = [a b];
%phase 1
cost = [0 0 0 0 -1 -1 0];
art_var = [5 6];
bv = [5 6];
zjcj = cost(bv)*A - cost;
simplex_table = [zjcj; A];
array2table(simplex_table, "VariableNames",var)
run = true;
while run
    if any(zjcj(1:end-1) < 0)
        fprintf('Soln is not optimal.');
        zc = zjcj(1:end-1);
        [Enter_Value, pvt_col] = min(zc);
        if all(A(:, pvt_col) <= 0)
            error('LPP is unbounded');
        else
            sol = A(:, end);
            column = A(:, pvt_col);
            for i = 1:size(A, 1)
                if column(i) > 0
                    ratio(i) = sol(i)./column(i);  
                else 
                    ratio(i) = inf;
                end
            end
            [leaving_value, pvt_row] = min(ratio);
        end
        bv(pvt_row) = pvt_col;
        pvt_key = A(pvt_row, pvt_col);
        A(pvt_row, :) = A(pvt_row, :) ./ pvt_key;
        for i = 1:size(A, 1)
            if i ~= pvt_row
                A(i, :) = A(i, :) - A(i, pvt_col) * A(pvt_row, :);
            end
        end
        zjcj = cost(bv) * A - cost;
        next_table = [A; zjcj];
        array2table(next_table, "VariableNames",var)
    else
       run = false;
       fprintf('Phase 1 sol is %f\n', zjcj(end));
    end
end
%Phase 2
A(:, art_var) = [];
org_c(:, art_var) = [];
cost = org_c;
var = org_var;
zjcj = cost(bv)*A - cost;
simplex_table = [A; zjcj];
array2table(simplex_table, "VariableNames",var)
run = true;
while run
    if any(zjcj(1:end-1) < 0)
        fprintf('Soln is not optimal.');
        zc = zjcj(1:end-1);
        [Enter_Value, pvt_col] = min(zc);
        if all(A(:, pvt_col) <= 0)
            error('LPP is unbounded');
        else
            sol = A(:, end);
            column = A(:, pvt_col);
            for i = 1:size(A, 1)
                if column(i) > 0
                    ratio(i) = sol(i)./column(i);
                else 
                    ratio(i) = inf;
                end
            end
            [leaving_value, pvt_row] = min(ratio);
        end
        bv(pvt_row) = pvt_col;
        pvt_key = A(pvt_row, pvt_col);
        A(:, pvt_row) = A(:, pvt_row) ./ pvt_key;
        for i = 1:size(A, 1)
            if i ~= pvt_row
                A(i, :) = A(i, :) - A(i, pvt_col) * A(pvt_row, :);
            end
        end
        zjcj = cost(bv) * A - cost;
        next_table = [A; zjcj];
        array2table(next_table, "VariableNames",var)
    else
       run = false;
       fprintf('Optimal sol is %f\n', zjcj(end));
    end
end
