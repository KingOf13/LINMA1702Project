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
function omega = opti_risq_control (B, rho, c, Rmin)
cvx_begin
    variable omega(T-1, 1);
    minimize( omega' * V);
    subject to
        sum(rho) >= 0;
        sum(rho) <= B;
        omega' * rho >= Rmin;
cvx_end
end