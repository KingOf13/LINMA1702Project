function main()
%Cmax = B * 0.1;
%Rmin = B * 0.1;
%mu   = 1;
H = csvread('BEL20.csv', 1, 2);
p = 10; %nombre de pas

delta = (H(2:end, :) - H(1:end-1, :)) ./ H(2:end, :);
T = size(delta,1);
n = size(delta,2);

% vecteur rho (du rendement espere)
rho = zeros(n, 1);
for i = 1:n
    rho(i) = (sum(delta(:,i)) ./ size(delta,1)) ./ 100;
end

% matrice C (de la covariance)
C = zeros(n);
for a = 1:n
    for b = 1:n
        C(a,b) = 1/(100 .* T) .* sum((H(:,a)-rho(a)) .* (H(:,b)-rho(b)));
    end
end

% Opti du rendement avec controle du risque :
Cmax = linspace(0, 1, p); % *B^2;
value1 = zeros(size(Cmax));
omega1 = zeros(n, length(Cmax));
for i = 1:length(Cmax)
    omega1(:, i) = opti_rend_control (n, rho, C, Cmax(i));
end

% Opti du risque avec controle du rendement :
Rmin =  linspace(0,1,p); %*B;
value2 = zeros(size(Rmin));
omega2 = zeros(n, length(Rmin));
for i = 1:length(Cmax)
    omega2(:, i) = opti_risq_control (n, rho, C, Rmin(i));
end

% Opti du risque avec controle du rendement :
mu = exp(linspace(-2, 0.5, p));
value3 = zeros(size(mu));
omega3 = zeros(n, length(mu));
for i = 1:length(mu)
    omega3(:, i) = opti_rend_and_risq (n, rho, C, mu(i));
end 


gain1 =  omega1'*rho;
gain2 = omega2'*rho;
gain3 = omega3'*rho;

var1 = gain1;
var2 = gain2;
var3 = gain3;
for i = 1:p
    var1(i) = (omega1(:,i)' * C) * omega1(:,i);
    var2(i) = (omega2(:,i)' * C) * omega2(:,i);
    var3(i) = (omega3(:,i)' * C) * omega3(:,i);
end
var1 = sqrt(var1);
var2 = sqrt(var2);
var3 = sqrt(var3);

% Impression
figure('Name','Opti du rendement avec controle du risque','NumberTitle','off');
plot(Cmax,gain1);
hold on;
grid on;
plot(Cmax, gain1+var1);
plot(Cmax, gain1-var1);
plot(Cmax, sum(omega1));

title('Opti du rendement avec controle du risque');
xlabel('Valeur de Variance maximale imposée par rapport au budget total (en %)');
ylabel('Rapport au budget investi (en %)');
legend('Rendement moyen', 'Rendement max', 'Rendement min', 'Partie du Budget investie');

figure('Name','Opti du risque avec controle du rendement','NumberTitle','off');
plot(Rmin,gain2 );
hold on;
grid on;
plot(Rmin, gain2+var2);
plot(Rmin, gain2-var2);
plot(Rmin, sum(omega2));
title('Opti du risque avec controle du rendement');
xlabel('Valeur de Variance maximale imposée par rapport au budget total (en %)');
ylabel('Rapport au budget investi (en %)');
legend('Rendement moyen', 'Rendement max', 'Rendement min', 'Partie du Budget investie');

figure('Name','Opti du risque avec controle du rendement et du risque','NumberTitle','off');
plot(mu, gain3);
hold on;
grid on;
plot(mu, gain3+var3);
plot(mu, gain3-var3);
plot(mu, sum(omega3));
title('Opti du risque et du rendement');
xlabel('Valeur de Variance maximale imposée par rapport au budget total (en %)');
ylabel('Rapport au budget investi (en %)');
legend('Rendement moyen', 'Rendement max', 'Rendement min', 'Partie du Budget investie');

end