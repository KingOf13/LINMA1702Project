B    = 100; % le budget
ind = 1;
Rmin = B * ind;
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

o=ones(1,n);

Cmod = [C;o;rho'];
z=  zeros(n,1);
z = [z; B;Rmin];

omega = sym('omega',[1 n])