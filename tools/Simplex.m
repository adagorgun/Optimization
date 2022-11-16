%% Ada Görgün  Simplex Algorithm
function [BFS, A] = Simplex(A, b, BV, Cost, print)

A = [A b];
Cost = [Cost 0];

zjcj = Cost(BV)*A - Cost;
RUN = true;

while RUN

    zc = zjcj(1,1:end-1); % not include solution

    if any(zc<0)

        [EnterCol, pivotCol] = min(zc);
        sol = A(:,end); Column = A(:,pivotCol);

        if print
            fprintf('Entering Col = %d \n', pivotCol);
        end

        if Column < 0
            fprintf('Unbounded Solution\n');
            break

        else

            for i = 1:size(A,1)

                if Column(i)>0
                    ratio(i) = sol(i)/Column(i);
                else
                    ratio(i) = Inf;
                end  

            end

            [MinRatio, pivotRow] = min(ratio);
            if print 
                fprintf('Leaving Row = %d \n', pivotRow); 
            end

        end

        BV(pivotRow) = pivotCol;
        pivot_key = A(pivotRow, pivotCol);

        A(pivotRow,:) = A(pivotRow,:)./pivot_key;
        for i = 1:size(A,1)
            if i~=pivotRow
                A(i,:) = A(i,:) - A(i,pivotCol).*A(pivotRow,:);
            end
        end

        zjcj = zjcj - zjcj(pivotCol).*A(pivotRow,:);

        if print
            InitialTable = array2table([zjcj;A]);
            disp(InitialTable);
        end
        BFS(BV) = A(:,end);


    else
        
        RUN = false;
        BFS = BV;

    end
    
end

end

