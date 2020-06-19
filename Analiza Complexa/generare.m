function generare(U)
    if(armonica(U) == 1)
        syms real
        syms x y c g(x)
        disp("Luam f(x,0)' = diff(U(x, 0),x) si apoi il integram astfel:");
        syms z f(x) 
        syms Ut(x,y) E(x) 
        Ut(x,y) = diff(U(x,y), x) - diff(U(x,y), y);
        E(x) = Ut(x, 0);
        f(x) = int(E(x));
        e = f(z);
        fprintf("f(x,0)' = %s\n", E(x));
        fprintf("Fie g(z) = %s. Atunci derivata partiala al lui g(x,0) in z este identica cu al lui f\n", e);
        fprintf("Deci derivata partiala al lui (f - g) in z de (x,0) este 0. Cum aceasta derivata e olomorfa\n");
        fprintf("Din teorema de identitate pentru functii Olomorfe avem f continua cu g si(f - g) = c <=> f = g(z) + c\n");
        fprintf("Astfel: f(z) = %s + c, unde c este din C, adica f(z) = %s + i*k, k din R. Am terminat\n", e, e);
        fprintf("Calculam v folosind teorama Cauchy-Riemann, adica vom integra %s in y\n", diff(U,x));
        v = int(diff(U, x), y);
        fprintf("Fie t(x) o functie temporara generata din teorema Cauchy-Riemann astfel incat ");
        fprintf("v(x) = %s + t(x)\n", v);
        fprintf("Determinam constanta t(x)\n");
        g(x, y) = simplify(1/1i *(f(x) - U - v));
        fprintf("t(x) =  %s (functia constanta pentru v)\n", g(x, y));
        fprintf("Deci f(x) = %s = U(x, y) + i*V(x,y) = %s + %s\n", f, U, 1i*simplify(v + g));
        fprintf("Facand calculele avem asa:\n");
        fprintf("Deci f(x) = %s = %s\n", f(z), simplify(U + 1i*simplify(v)));
    end


end