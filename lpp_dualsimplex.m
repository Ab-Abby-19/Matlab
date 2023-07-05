clc;
clear all; %#ok<CLALL> 
cost = [-2 -1 0 0 0 0];
a = [-3 -1 1 0 0;-4 -3 0 1 0;-1 -2 0 0 1];
b = [-3;-6;-3];
bv = [3 4 5];
var = {'x1', 'x2', 's1', 's2', 's3', 'sol'};
A = [a b];
zjcj = cost(bv)*A - cost;
simplex_table = [zjcj; A];
array2table(simplex_table, "VariableNames",var)
run = true;
while run
     sol = A(:, end);
     if(any(sol < 0))
         fprintf('Current BFS is not feasible.');
         [leaving_val, pvt_row] = min(sol);
         for i = 1:size(A, 2) - 1
             if A(pvt_row, i) < 0
                 ratio(i) = abs(zjcj(i)./A(pvt_row, i)); %#ok<*SAGROW> 
             else
                 ratio(i) = inf;
             end
         end
         [entering_val, pvt_col] = min(ratio);
         bv(pvt_row) = pvt_col;
         pvt_key = A(pvt_row, pvt_col);
         A(pvt_row, :) = A(pvt_row, :)./pvt_key;
         for i = 1:size(A, 1)
            if i ~= pvt_row
                A(i, :) = A(i, :) - A(i, pvt_col) * A(pvt_row, :);
            end
        end
        zjcj = cost(bv) * A - cost;
        nest_table = [zjcj; A];
        array2table(nest_table, "VariableNames",var)
     else
         run = false;
         fprintf('Current BFS is feasible.');
     end
end
