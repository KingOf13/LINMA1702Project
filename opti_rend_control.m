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
function omega = opti_rend_control (B, rho, C, Vmax)
cvx_begin
    variable omega(T-1, 1);
    minimize( - (omega' * rho));
    subject to
        sum(rho) >= 0;
        sum(rho) <= B;
        omega' * V <= Vmax;
cvx_end
end