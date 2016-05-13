X = sym('x',[1 2]);
A = [X; 1/2 -1/2];
b = [1; 2];
A*X.'==b
S=solve(A*X.'==b);
S.x1
S.x2
S(1)
X
