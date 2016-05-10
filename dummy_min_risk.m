function omega = dummy_min_risk(esp, cov, max_budget)
omega = zeros(size(esp));
max = size(cov,1);
i = 1;
hit = max;
for i = 1:max
    if cov(i,i) ~= 0
        esp (i) = 0;
        hit --;
    end
end
if (hit ~= 0)
    [val, i] = max(esp);
    omega(i) = max_budget;
end