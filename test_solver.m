syms x
eqn = sin(x) == 1;
[solx, params, conds] = solve(eqn, x, 'ReturnConditions', true)