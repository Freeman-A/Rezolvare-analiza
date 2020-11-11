%Editat de Mihalea Andreas si Dima Darius

function [x_hat, n, err_abs, err_rel, err_rez] = Aitken(f,phi,x0,ITMAX,TOL)
x(1)=x0;
x(2)=phi(x(1));
x_hat(1:2)=x;
n=2;
err_abs(n) = eroarea_abs(n);
err_rel(n) = eroarea_rel(n);
err_rez(n) = eroarea_rez(n);
while err_abs(n)>TOL && n<=ITMAX && err_rel(n)>TOL && err_rez(n)>TOL
    
    n=n+1;
    x(n) = phi(x(n-1));
    x_hat(n)=A(x(n),x(n-1),x(n-2));
    err_abs(n + 1) = eroarea_abs(n + 1);
    err_rel(n + 1) = eroarea_rel(n + 1);    
    err_rez(n + 1) = eroarea_rez(n + 1);

end

    function output = eroarea_abs(n)
        output = abs(x_hat(n) - x_hat(n-1));
    end
    
    function output = eroarea_rel(n)
        output = abs(x_hat(n) - x_hat(n-1)) / abs(x_hat(n));
    end

    function output = eroarea_rez(n)
        output = abs(f(n));
    end
    
end