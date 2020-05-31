%ecuatii diferentiale partiale de ordinul 1

classdef Untitled
%A class to contain a lot of functions    
    methods   
%Polymorphism        
function z_t = Untitled(x, y, z, F)
%Solve equation alpha v0.1.3
%pasul 1
%=======================================================================
%Declaram si rezolvam problemele Cauchy

disp("Rezolvare ecuatii diferentiale partiale de ord 1 v0.1.3");
t = sym('t');
disp("Definim t - si este considerat gamma");
fprintf("y(0) = %s\n", y(t));
fprintf("x(0) = %s\n", x(t));
fprintf("z(0) = %s\n", z(t));

%pasul 2
%=======================================================================
%Rezolvam problemele Cauchy p(0) si q(0)

a(t) = sym('a');
a(t) = [x(t) ; y(t)];
p = sym('p');
q = sym('q');
Da = diff(a(t));
D = [p, q] * Da;
fprintf("D(t) = %s\n", D);
Db = diff(z(t));
fprintf("Db(t) = %s\n", Db);
F_temp = F(x(t), y(t), z(t), p, q);
fprintf("F(a(t), b(t), (p,q)) = %s\n", simplify(F_temp));
syms solp solq
[solp, solq] = solve(simplify(F_temp) == 0, D == Db, [p, q]);
fprintf("p(0) = %s, q(0) = %s\n", solp, solq);
save_x = x(t);
save_y = y(t);
save_z = z(t);

%pasul 3
%==============================================================
%Calculeaza si determina sistemul de ecuatii diferentiala
%==============================================================

e = sym('e');
x = sym('x');
y = sym('y');
z = sym('z');
p = sym('p');
q = sym('q');
x_diff = diff(F, p);
y_diff = diff(F, q);
z_diff = diff(F, p) * p + diff(F, q) * q;
p_diff = 0 - diff(F, x) - p * diff(F, z);
q_diff = 0 - diff(F, y) - q * diff(F, z);
disp("Sistemul de ecuatii diferentiale sunt:");
fprintf("x'= %s\ny'= %s\nz'= %s\np'= %s\nq'= %s\n", x_diff, y_diff, z_diff, p_diff, q_diff);
index = zeros(1, 5);

%=======================================================================
%Convertire x -> x(e), pentru orice e din R
%=======================================================================

x(e) = str2sym('x(e)');
y(e) = str2sym('y(e)');
z(e) = str2sym('z(e)');
p(e) = str2sym('p(e)');
q(e) = str2sym('q(e)');
ode1 = diff(x(e)) == simplify(x_diff(x(e), y(e), z(e), p(e), q(e)));
ode2 = diff(y(e)) == simplify(y_diff(x(e), y(e), z(e), p(e), q(e)));
ode3 = diff(z(e)) == simplify(z_diff(x(e), y(e), z(e), p(e), q(e)));
ode4 = diff(p(e)) == simplify(p_diff(x(e), y(e), z(e), p(e), q(e)));
ode5 = diff(q(e)) == simplify(q_diff(x(e), y(e), z(e), p(e), q(e)));
%==============================================================
%==============================================================
%==============================================================

%Rezolvarea ecuatiilor - Stadiul 1

ode = [ode1, ode2, ode3, ode4, ode5];
cond = [save_x, save_y, save_z, solp, solq];

ode_t = [];
var_t = [];

%==============================================================
%Verificare liniaritatii

%Algorimtul nu e bun

%Verificarea liniaritati
%==============================================================

if(checkliniarity_rand(x_diff) == 1) 
    index(1) = 1; 
    ode_t = [ode_t, ode1];
    var_t = [var_t, x];
end
if(checkliniarity_rand(y_diff) == 1) 
    index(2) = 1; 
    ode_t = [ode_t, ode2];
    var_t = [var_t, y];
end
if(checkliniarity_rand(z_diff) == 1) 
    index(3) = 1; 
    ode_t = [ode_t, ode3];
    var_t = [var_t, z];
end
if(checkliniarity_rand(p_diff) == 1) 
    index(4) = 1; 
    ode_t = [ode_t, ode4];
    var_t = [var_t, p];
end
if(checkliniarity_rand(q_diff) == 1) 
    index(5) = 1; 
    ode_t = [ode_t, ode5];
    var_t = [var_t, q];
end
counter = 0;
for i=1:5
    if(index(i) == 1)
       counter = counter + 1;
    end
end
%test mode on
if(counter < 5)
    %Cazul 1 = cazul nasol -> se rezolva numeric
    disp("Aceasta ecuatie partiala nu are o ecuatie liniara indepedenta");
    disp("Incerc sa rezolv prin numeric, nu merge simbolic");
    convert_function_solve_attempt_1(ode,[x(e), y(e), z(e), p(e), q(e)] ,cond);
end
if(counter == 5)
   %Cazul 2 = impecabil toate sisteme linare
   disp(var_t);
   try
   [x_sol, y_sol, z_sol, p_sol, q_sol] = dsolve(ode_t, cond);
   catch
       try
       [x_sol, y_sol, z_sol, p_sol, q_sol] = dsolve(ode_t, cond);
       catch
           disp("Eroare la program sau ecuatia nu e valabila");
           return;
       end
   end
   fprintf("x(t) = %s, y(t) = %s, z(t) = %s, p(t) = %s, q(t) = %s", x_sol, y_sol, z_sol, p_sol,q_sol);
   %Pasul 4 rezolvat
end


%==============================================================
%Functia 1
function [y_t1, y_t2, y_t3, y_t4, y_t5] = convert_function_solve_attempt_1(eqn, variabile, cond)
    %try simplifying the DAE equation
    %======================================================
    
    try
        %incercam sa reducem ordinul de la 2+ la 1
    [eqn,variabile] = reduceDifferentialOrder(eqn,variabile);
    catch
    end
    
    %======================================================
    try
    if (isLowIndexDAE(eqn,variabile) == 1)
        %increase speed by verifing if dae is lowindex or not
        %return 1 - true, 0 - false
    else
        [eqn, variabile] = reduceDAEIndex(eqn, variabile);
    end
    catch 
        [eqn,variabile] = reduceRedundancies(eqn,variabile);
        try
            if (isLowIndexDAE(eqn,variabile) == 1)
            %increase speed by verifing if dae is lowindex or not
            %return 1 - true, 0 - false
            else
        [eqn, variabile] = reduceDAEIndex(eqn, variabile);
            end
            
        catch
            disp("Eroare 0x1. Ecuatia nu e compatibila!");
            return;
        end
    end
    %======================================================
    
    try
    f = daeFunction(eqn, variabile);
    t_int = [0, 0.5];
    F_t = @(e, t1, t2) f(e,t1,t2);
    opt = odeset('RelTol', 10.0^(-7),'AbsTol',10.0^(-7));
    yp0 = [0, 0, 0, 0, 0];
    [y0,yp0] = decic(F_t,0,cond,[],yp0,[],opt);
    ode15i(@F_t, t_int, y0, yp0);
    catch
        disp("Nu merge cu ode15i. Incercam cu cu reducere dae -> ode");
        newEqs = reduceDAEToODE(eqn, variabile);
        try
            [y_t1, y_t2, y_t3, y_t4, y_t5] = dsolve(newEqs, cond);
        catch
            disp("Nu merge cu conditie incercam fara conditie");
            try
                s = Warning('symbolic:dsolve:warnmsg2', 'off');
                t_t = dsolve(newEqs);
                [y_t1, y_t2, y_t3, y_t4, y_t5] = dsolve(newEqs);
                if(t_t == null)
                    
                end
                Warning(s);
                
                disp("Daca nu apar solutiile atunci nu e rezolvat");
            catch
                t_intv = [1, 5];
                try 
                    ode45(@eqvn, t_intv, [1, 1, 1, 1, 1]); 
                    disp("Matlabul a rezolvat ecuatia grafic, nu poate rezolva simbolic!"); 
                catch
                    disp("Nu merge cu ode45. Matlabul nu poate rezolva automat acest tip de sistem"); 
                end
                disp("Nu merge cu reducere dae la ode si apoi dsolve");
            end
        end
            
    end
    
    %======================================================
end

%=======================================================================
%Functia de mai jos verifica liniaritatea
%=======================================================================

%Functia 2
function Y = checkliniarity_rand(eqnd)
    
   eqn_t = matlabFunction(eqnd);
   eqn = @(t) eqn_t(t(1), t(2), t(3), t(4), t(5));
   x1 = rand(1,5);
   x2 = rand(1,5);
   b_t = round(rand(1,1));
   Y = 1;
   if(eqn(x1) + eqn(x2) ~= eqn(x1 + x2))
       Y = 0;
       return;             
   end
   if(round(eqn(b_t * x1),2) ~= round(b_t *eqn(x1),2)) 
       Y = 0;
       return;
   end
   if(round(eqn(b_t * x2),2) ~= round(b_t * eqn(x2),2))
       Y = 0;
       return;
   end
end 

%===================================================================
%Functia 3
%===================================================================    
    function dxy = eqvn(t, y)
       dxy = zeros(5, 1);
       dxy(1) = x_diff(y(1), y(2), y(3), y(4), y(5));
       dxy(2) = y_diff(y(1), y(2), y(3), y(4), y(5));
       dxy(3) = z_diff(y(1), y(2), y(3), y(4), y(5));
       dxy(4) = p_diff(y(1), y(2), y(3), y(4), y(5));
       dxy(5) = q_diff(y(1), y(2), y(3), y(4), y(5));
    end
%===================================================================    




end
    
    end

end
%===================================================================
























