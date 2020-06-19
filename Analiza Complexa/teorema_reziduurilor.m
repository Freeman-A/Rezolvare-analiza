function teorema_reziduurilor(F)
    fprintf("Calculam integrala curbilinie cu ajutorul teoremei reziduuriilor\n");
    fprintf("Determinam polii si ordinea lui F\n");
    Y = pol(F);
    [t, ~] = size(Y);
    s = 0;
    fprintf("Aplicam teorema reziduuriilor\n");
    fprintf("Calculam reziduurile pentru fiecare pol\n");
    for i=1:t
       a = Y(i, 1);
       b = Y(i, 2);
       s = s + rezi(F, a, b);
    end
    s = sym(s);
    s = sym(s * 2*pi*i);
    fprintf("Deci solutia integralei este %s", s);
    
end