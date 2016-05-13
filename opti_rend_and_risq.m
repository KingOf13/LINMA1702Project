%--------------------------------------------------------------%
% 4.2 PARTIE 3 : Optimisation de la combinaison du rendement et 
%                du risque
% 
% Parametres : 

% rho  : vecteur des rendements moyens esperes
% C    : matrice de covariance
% mu   : scalaire permettant de parametrer la combinaison
%--------------------------------------------------------------%
function [omega, cvx_optval] = opti_rend_and_risq (n, rho, C, mu)
cvx_begin
    variable omega(n, 1);
    minimize(mu * (omega' * C * omega) - (omega' * rho));
    subject to
        sum(omega) <= 1;
        omega >= 0;
cvx_end
end