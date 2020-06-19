function Y = rezi(F, z0 ,ord)
    syms x g(x)
    if(ord == 1)
        g(x) = (x - z0) * F(x);
    else
    g(x) = (1/factorial(ord - 1))*((x - z0)^(ord) * F(x))^(ord-1);
    end
    syms y
    test(y) = limit(g, x, y);
    disp(test(y));
    Y = test(z0);
end