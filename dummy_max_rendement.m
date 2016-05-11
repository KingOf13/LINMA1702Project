function omega = dummy_max_rendement(rho, cov, max_budget)
[val, i] = max(rho);
omega = zero(size(rho));
omega(i)=max_budget;
