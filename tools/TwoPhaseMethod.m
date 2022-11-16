%% Ada Görgün  Two Phase Method
function Xopt = TwoPhaseMethod(c,A,b)

% initializations
[m,n] = size(A);

%% Phase I
% introduce artificial variables and solve corresponding LP
c_p1 = [zeros(n,1);ones(m,1)];
A_p1 = [A,eye(m)];
X0_p1 = [zeros(n,1);b];

StartBV = find(-c_p1<0);

[BFS, A_n] = Simplex(A_p1, b, StartBV, -c_p1', 0);

A_n(:, StartBV) = [];
b_n = A_n(:,end);
A_n(:,end) = [];

%% Phase II
% apply simplex with initial feasible solution X0

[OptBFS, OptA] = Simplex(A_n, b_n, BFS, -c', 0);

Xopt = zeros(1, size(A,2));
Xopt(OptBFS) = OptA(:,end);
Xopt = Xopt';

end

