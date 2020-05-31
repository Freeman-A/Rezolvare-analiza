function a = prime_integral(F, eqn, vars)
[~, te] = size(vars); %ok
syms t 
test = diff(F, t);
temp = eqn(vars);
for i=1:te
    test = test + diff(F, vars(i)) * temp(i);
end
test = simplify(test);
disp(test);
if(test == "0")
    a = 1;
else 
    a = 0;
end



end