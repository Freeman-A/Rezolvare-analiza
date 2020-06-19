function Y = get_order(F, z0, gamma)
    syms x
    F = F(x);
    if ~isa(z0, 'sym')
        z0 = sym(z0);
    end
    if(gamma == 1)
    fprintf("Verificam daca %d este pol:\n", z0);
    fprintf("Calculam lim(z->z0)F(z), daca e infinit, e pol\n");
    syms x
    if(~isnan(limit(simplify(F), x, z0)))
        Y = 0;
        fprintf("Din pacate, %s nu este pol, fiindca limita este %s\n", z0, limit(simplify(F),x, z0));
        return;
    end
    fprintf("%d este pol, verificat cu succes\n", z0);
    else
       syms x y
       e(y) = limit(F, x, y);
       disp(e);
       if(get(e, z0) ~= inf)
         Y = 0;
         fprintf("Din pacate, %s nu este pol, fiindca limita este %s\n", z0, e(z0));
        return;
       end
    end
        
    fprintf("Cautam ordinea polului %s:", z0);
    syms x e f(x) g(x);
    fprintf("\nPasul 1: Calculam prima derivata\n");
    g(x) = 1/F;
    f(x) = diff(g, x);
    if(diff(f, x) == 0)
        Y = 1;
        return;
    end
    count = 1;
    fprintf("Verficam daca %s = 0 in %s \n", f(x), sym(z0));
    while(get(f, z0) == 0)
        f(x) = diff(f, x);
        fprintf("Pasul %d: Calculam a %d -a derivata\n", count + 1, count + 1);
        fprintf("Verficam daca %s = 0 in %s \n", f(x), sym(z0));
        if(get(f, z0) == inf)
            disp(" nu este pol");
            break;
        end
        count = count + 1;
    end
    Y = count - 1;
    if(count ~= 0)
    fprintf("Ordinul polului %s este %d\n", sym(z0), count - 1);
    end
end

function Y = get(F, x)
    try
        Y = F(x);
    catch 
        Y = inf; 
    end
 
    
end

function Y = mldivide(a, b)
    if(b == 0)
        Y = inf;
    else
        Y = a\b;
    end
end


function Y = ldivide(a, b)
  if(b == 0)
      Y = inf;
      return;
  end
  Y = a \ b;
end