%--------------------------------------------------------------%
% 4.2 PARTIE 1 : Optimisation du rendement avec risque sous 
%                controle
% 
% Parametres : 
% B    : scalaire representant le budget max
% rho  : vecteur des rendements moyens esperes
% C    : matrice de covariance
% Vmax : scalaire representant la limite de la variance globale
%--------------------------------------------------------------%
function [omega, cvx_optval] = opti_rend_control (n, B, rho, C, Vmax)
cvx_begin
    variable omega(n, 1);
    maximize(omega' * rho);
    subject to
        sum(omega) <= B;
        omega' * C * omega <= Vmax;
        omega >= 0;
cvx_end
end