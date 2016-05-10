function omega = dummy_max_rendement(esp, cov, max_budget)
[val, i] = max(esp);
omega = zero(size(esp));
omega(i)=max_budget;