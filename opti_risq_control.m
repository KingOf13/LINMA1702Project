%--------------------------------------------------------------%
% 4.2 PARTIE 2 : Optimisation du risque avec rendement sous 
%                controle
% 
% Parametres : 
% B    : scalaire representant le budget max
% rho  : vecteur des rendements moyens esperes
% C    : matrice de covariance
% Rmin : scalaire representant la limite du rendement attendu
%--------------------------------------------------------------%
function [omega, cvx_optval] = opti_risq_control (n, B, rho, C, Rmin)
cvx_begin
    variable omega(n, 1);
    minimize( omega' * C * omega);
    subject to
        sum(omega) == B;
        omega' * rho >= Rmin;
        omega >= 0;
cvx_end
end