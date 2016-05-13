function omega_sol = opti_full()

B   = 1; % le budget
ind =100;
Rmin = B / ind;
H = csvread('BEL20.csv', 1, 2);

delta = (H(2:end, :) - H(1:end-1, :)) ./ H(2:end, :);
T = size(delta,1);
n = size(delta,2);

% vecteur rho (du rendement espere)
rho = zeros(n, 1);
for i = 1:n
    rho(i) = sum(H(:,i)) ./ size(delta,1);
end
%display(rho);

% matrice C (de la covariance)
C = zeros(n);
for a = 1:n
    for b = 1:n
        C(a,b) = 1/T .* sum((H(:,a)-rho(a)) .* (H(:,b)-rho(b)));
    end
end
%display(C);
C=C/100;
rho = rho/100;

omega = sym('omega',[n 1]);

obj = omega.' * C * omega;
obj_grad = 2 * C * omega;

c1 = B - sum(omega);
c1_grad = (-1) * ones(size(omega));

c2 = (1/B) * (omega.'*rho) - Rmin;
c2_grad = (1/B) * rho;

z = zeros(size(c2_grad));


lambda = [1 1];
S= solve(obj_grad - lambda(1)*c1_grad - lambda(2)*c2_grad == 0)

min = inf;
min_ind = 0;omega_sol' * C * omega_sol

omega_sol = [eval(S.omega1) ; eval(S.omega2) ; eval(S.omega3) ; eval(S.omega4) ; eval(S.omega5) ; eval(S.omega9) ...
            ; eval(S.omega10) ; eval(S.omega11) ; eval(S.omega12) ; eval(S.omega13) ; eval(S.omega14) ...
            ; eval(S.omega15) ; eval(S.omega16) ; eval(S.omega17) ; eval(S.omega18) ; eval(S.omega19) ...
            ; eval(S.omega20)]

for i=1:size(S.omega1,1)
    omega_sol(:,i)
    if (sum(omega_sol(:,i)) - B <= 0)
        if (1/B * omega_sol(:,i)' * rho - Rmin >= 0)
            if (omega_sol(:,i)' * C * omega_sol(:,i) < min)
                min = omega_sol(:,i)' * C * omega_sol(:,i);
                min_ind = i;
            end
        end
    end
end


    


if (0)
display(S);
display(S.omega1);
display(S.omega2);
display(S.omega3);
display(S.omega4);
display(S.omega5);
display(S.omega6);
display(S.omega7);
display(S.omega8);
display(S.omega9);
display(S.omega10);
display(S.omega11);
display(S.omega12);
display(S.omega13);
display(S.omega14);
display(S.omega15);
display(S.omega16);
display(S.omega17);
display(S.omega18);
display(S.omega19);
display(S.omega20);
end
