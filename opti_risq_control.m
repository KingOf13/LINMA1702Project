%--------------------------------------------------------------%
% 4.2 PARTIE 2 : Optimisation du risque avec rendement sous 
%                controle
% 
% Parametres : 

% rho  : vecteur des rendements moyens esperes
% C    : matrice de covariance
% Rmin : scalaire representant la limite du rendement attendu
%--------------------------------------------------------------%
function [omega, cvx_optval] = opti_risq_control (n, rho, C, Rmin)
cvx_begin
    variable omega(n, 1);
    minimize( omega' * C * omega);
    subject to
        sum(omega) <= 1;
        omega' * rho >= Rmin;
        omega >= 0;
cvx_end
end