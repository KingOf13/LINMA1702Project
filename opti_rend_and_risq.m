%--------------------------------------------------------------%
% 4.2 PARTIE 3 : Optimisation de la combinaison du rendement et 
%                du risque
% 
% Parametres : 
% B    : scalaire representant le budget max
% rho  : vecteur des rendements moyens esperes
% C    : matrice de covariance
% mu   : scalaire permettant de parametrer la combinaison
%--------------------------------------------------------------%
function omega = opti_rend_and_risq (B, rho, C, mu)
cvx_begin
    variable omega(T-1, 1);
    minimize(mu * (omega' * V) - (omega' * rho));
    subject to
        sum(rho) >= 0;
        sum(rho) <= B;
cvx_end
end