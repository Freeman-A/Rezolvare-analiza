function xaprox = NewtonRaphson(f, x0aprox, TOL, g, a, b)
% Arguments:
% f - function handle.
% x0aprox - the first aproximative solution
% TOL - represents the Tolerance
% g (OPTIONAL) - the derivate of function f
% a, b (OPTIONAL) - represents the bounderies of the interval [a, b]
% If you want to use a and b but NOT g, just write NewtonRaphson(f, x0aprox, TOL, '', a, b)



%1) Verifies if the function is correctly used && solving the optional parameters if it is necessary

%a) Verifies if the necessary parameters are inserted correctly.
if(exist('f', 'var'))
    if(~isa(f,'function_handle'))
        error('f must be a function handle, if you want to see the arguments write "help NewtonRaphson"\n');
    end
else
     error_t(0);
end


if(exist('x0aprox', 'var'))
    if(~isnumeric(x0aprox))
       error('x0aprox must be a number, if you want to see the arguments write "help NewtonRaphson"\n');
    end
else
       error_t(0);
end

if(exist('TOL', 'var'))
    if(~isnumeric(x0aprox) || TOL < 0)
       error('TOL must be a positive number, if you want to see the arguments write "help NewtonRaphson"\n');
    end
else 
    error_t(0);
end

%1) b) Solving the optional parameters and verifies if it is inserted correctly

ok = 0; %%if I didn't define a boundary
if(exist('a', 'var'))
   if(exist('b', 'var'))
       fprintf('The solutions are in the interval [%s, %s]\n', sym(a), sym(b));
       ok = 1;
   else
       error_t(1);
   end
    
end
if(exist('g', 'var'))
    if(~isa(g, 'function_handle'))
       if(g ~= '')
         error('g must be a function handle and it represents the derivate of a function f, if you want to see the arguments write "help NewtonRaphson\n"');
       else
            x = sym('x');
            temp_f(x) = sym(f);
            g = matlabFunction(simplify(diff(temp_f, x))); 
            fprintf("The derivate for the function declared in the first parameter is (%s) \n", sym(g));
       end
    end
else
    x = sym('x');
    g = matlabFunction(simplify(diff(f, x))); 
    fprintf("The derivate for the function declared in the first parameter is (%s) \n", simplify(diff(f, x)));
end


%2) The kernel of this function.

%a) Searches the solutions without boundaries.
n = 1;
xaprox(n) = x0aprox;
while abs(f(xaprox(n))) > TOL
    n = n+1;
    xaprox(n) = xaprox(n-1)- f(xaprox(n-1))/g(xaprox(n-1));
end

%b) Remove all the solutions which are not in the defined interval
if(ok == 1)
    [~, countv] = size(xaprox);
    vec = zeros(1, countv);
    h = 1;
    for i = 1:countv
         if(xaprox(i) >= a && xaprox(i) <= b)
             vec(h) = xaprox(i);
             h = h + 1;
         end
    end
    xaprox = vec;
end

%Special function which returns an error.
    function error_t(case_m)
        if(case_m == 0)
              error('You didn t use this function correctly, if you want to see the arguments write "help NewtonRaphson. Code: 0x1"\n');
        end
        if(case_m == 1)
              error('You can not declare a function with an only boundariy interval. Code: 0x2\n');
        end
    end

end