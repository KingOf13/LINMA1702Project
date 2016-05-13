function main()
B    = 1e3; % le budget
%Cmax = B * 0.1;
%Rmin = B * 0.1;
%mu   = 1;
H = csvread('BEL20.csv', 1, 2);
p = 1e-1;

delta = (H(2:end, :) - H(1:end-1, :)) ./ H(2:end, :);
T = size(delta,1);
n = size(delta,2);

% vecteur rho (du rendement espere)
rho = zeros(n, 1);
for i = 1:n
    rho(i) = sum(H(:,i)) ./ size(delta,1);
end
display(rho);

% matrice C (de la covariance)
C = zeros(n);
for a = 1:n
    for b = 1:n
        C(a,b) = 1/T .* sum((H(:,a)-rho(a)) .* (H(:,b)-rho(b)));
    end
end
display(C);



% Opti du rendement avec controle du risque :
Cmax = B * 0:p:1;
value1 = zeros(size(Cmax));
omega1 = zeros(n, length(Cmax));
for i = 1:length(Cmax)
    [omega1(:, i), value1(i)] = opti_rend_control (n, B, rho, C, Cmax(i));
end

% Opti du risque avec controle du rendement :
Rmin =  B * 0:p:1;
value2 = zeros(size(Rmin));
omega2 = zeros(n, length(Rmin));
for i = 1:length(Cmax)
    [omega2(:, i), value2(i)] = opti_risq_control (n, B, rho, C, Rmin(i));
end

% Opti du risque avec controle du rendement :
mu = exp(0:p:1);
value3 = zeros(size(mu));
omega3 = zeros(n, length(mu));
for i = 1:length(mu)
    [omega3(:, i), value3(i)] = opti_rend_and_risq (n, B, rho, C, mu(i));
end 

display(C);
display(rho);
gain1 =  omega1'*rho;
gain2 = omega2'*rho;
gain3 = omega3'*rho;

var1 = (omega1' * C) * omega1;
var2 = (omega2' * C) * omega2;
var3 = (omega3' * C) * omega3;


figure('Name','Opti du rendement avec controle du risque','NumberTitle','off')
plot(Cmax,gain1);
hold on;
plot(Cmax, gain1+var1');
plot(Cmax, gain1-var1');
title('Opti du rendement avec controle du risque');
display(omega1);

figure('Name','Opti du risque avec controle du rendement','NumberTitle','off')
plot(Rmin,gain2 );
hold on;
plot(Cmax, gain2+var2');
plot(Cmax, gain2-var2');
title('Opti du risque avec controle du rendement');
display(omega2);

figure('Name','Opti du risque avec controle du rendement et du risque','NumberTitle','off')
plot(mu, gain3);
hold on;
plot(Cmax, gain3+var3');
plot(Cmax, gain3-var3');
title('Opti du risque et du rendement');
display(omega3);

var1 = (omega1' * C) * omega1;

end