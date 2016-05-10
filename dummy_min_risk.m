function omega = dummy_min_risk(esp, cov, max_budget)
omega = zeros(size(esp));
max = size(cov);
min = Inf;
ind = 0;
for i 1:max
    if cov(i,i) < min;
        min = cov (i,i);
        ind = i;
    end
end
omega(ind) = max_budget;

    