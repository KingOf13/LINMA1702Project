function omega = dummy_dummy_min_risk(rho, cov, max_budget)
omega = zeros(size(rho));
max = size(cov,1);
i = 1;
ind = 0;
min = Inf;
for i = 1:max
    if cov(i,i) <= min
	ind = i;
	min = cov(i,i);
    end
end
omega(ind) = max_budget;
