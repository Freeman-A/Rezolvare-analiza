classdef Steffensen
    %Realizat de Mihalea Andreas si Dima Darius
    %Proprietati:
    %Date de intrare:
    %
    %
    %x0 - primul numar aproximativ
    %TOL - toleranta
    %ITMAX - iteratia maxima alocata
    %phi - functia de punct fix (OPTIONAL daca vrei sa implementezi pe
    %f, si se va inlocui cu '')
    %OPT_err - tipuri de eroare de la 0 la 2
    %f - functia pentru functia de punct fix (OPTIONAL daca ai pus pe phi in
    %argument)
    %OPT_phi - daca nu s a introdus phi ci f, se selecteaza un tip de
    %generare pentru phi de la 0 la 2.
    %m - daca OPT_phi = 1, reprezinta multiplicitatea.
    %
    %
    %Date de iesire:
    %sol - reprezinta un vector de solutii;
    %iter - numarul de iteratii;
    %
    %
    %Exemple:
    %
    %
    %Exemplul 1: Steffensen(0, 10^(-10), 20, '', 1, f, 1, 3)
    %f = @(x)(x^3-4*x^2+5*x-2)
    %Output:  
    %sol: [0 1.2000 0.8571 0.9333 1.0303 0.9841  0.9990  1.0005  0.9998  1.0000  1.0000   1.0000  1.0000  1.0000  1.0000]
    %iter: 5
    %
    %
    %Exemplul 2: Steffensen(0, 10^(-10), 20, phi, 1);
    %f = @(x)(x^3-4*x^2+5*x-2)
    %df = @(x) 3*x^2- 8*x + 5
    %phi = @(x) x - f(x) / df(x); 
    %Output:  
    %sol: [0    1.1111    1.0078    1.0165    1.0001    1.0000    1.0000    1.0000    1.0000]
    %iter: 3
    
    
    
    
    
    properties (Access = public)
       sol = 0; %vectorul de solutii
       iter = 0; %numarul de iteratii alocate pentru solutia finala
    end
    
    
    properties (Access = protected)
        x0 = 0;
        ITMAX = 0;
        TOL = 0;
        f = @(x) cos(x); %random
        okf = 0;
        df = @(x) -sin(x); %random
        phi = @(x) x; %random
        OPT_err = 1;
        OPT_phi = 0;
        m = 0; %daca exista m
        ep = 0;
    end
    
    methods (Access = public)
        function obj = Steffensen(...
            x0, ...  %x0 - primul numar aproximativ
            TOL, ... %TOL - toleranta
            ITMAX, ...     %ITMAX - iteratia maxima alocata
            phi, ...     %phi - functia de punct fix (OPTIONAL daca vrei sa implementezi pe f, si se va inlocui cu '')
            OPT_err, ...   %OPT_err - tipuri de eroare de la 0 la 2
            f, ...     %f - functia pentru functia de punct fix
            OPT_phi, ... %OPT_phi - daca nu s a introdus phi ci f, se selecteaza un tip de generare pentru phi de la 0 la 2.
            m) %m - daca OPT_phi = 1, reprezinta multiplicitatea.
            format short
            x = sym('x');
            try
            if(~exist('OPT_phi', 'var'))
                obj.OPT_phi = 0;
            else
                if(~isnumber(obj, OPT_phi))
                    error('OPT_phi is not a number, if you want to see the arguments write "help Steffensen\n"');
                else
                    obj.OPT_phi = OPT_phi;
                    if(obj.OPT_phi == 1)
                        if(~exist('m', 'var'))
                            error('If you give 1 to OPT_phi you must also declare the number, if you want to see the arguments write "help Steffensen\n"'); 
                        else
                             if(~isnumber(obj, m))
                                  error('m is not a number, if you want to see the arguments write "help Steffensen\n"');
                             else
                                  obj.m = m;
                             end
                        end
                    end
                end
            end
            catch 
                 error('Doesnt work the following functions: isnumeric or exist'); 
            end
            if(~exist('OPT_err', 'var'))
                obj.OPT_err = 0;
            else
                if(~isnumber(obj, OPT_err))
                    error('OPT_err is not a number, if you want to see the arguments write "help Steffensen\n"');
                else
                    obj.OPT_err = OPT_err;
                end
            end
            
            if(exist('f', 'var'))
               if(~isa(f, 'function_handle'))
                  not_exist(obj, 'f is not a function handle');    
               end
               obj.df = matlabFunction(diff(sym(f), x));
               obj.f = f;
               obj.okf = 1;
               phi = @(x) phi_if(obj, x);
            else
                if(exist('phi', 'var'))
                    
                else
                not_exist(obj, 'f does not exist');  
                end
            end
            
            if(~exist('ITMAX', 'var'))
                 not_exist(obj, 'ITMAX does not exist');
            else
                if(~isnumber(obj, ITMAX))
                    error('ITMAX is not a number, if you want to see the arguments write "help Steffensen\n"');
                else
                    obj.ITMAX = ITMAX;
                end
            end
            
            if(~exist('TOL', 'var'))
                 not_exist(obj, 'TOL does not exist');
            else
                if(~isnumber(obj, TOL))
                    error('TOL is not a number, if you want to see the arguments write "help Steffensen\n"');
                else
                    obj.TOL = TOL;
                end
            end
            
            ok = 0;
            if(~exist('x0', 'var'))
                not_exist(obj, 'x0 does not exist');
            else
                if(~isnumber(obj, x0))
                    error('x0 is not a number, if you want to see the arguments write "help Steffensen\n"');
                else
                    ok = 1;
                end
            end
            if(ok == 1)  
                %KERNEL
                obj.sol(1) = x0;
                obj.sol(2) = phi(obj.sol(1));
                obj.sol(3) = phi(obj.sol(2));
                i = 1;
                while obj.Select_Err(i*3)
                    obj.sol(3*i + 1) = obj.A(obj.sol(3*i),...
                    obj.sol(3*i - 1), ...
                    obj.sol(3*i - 2) ...
                    );
                    obj.sol(3*i + 2) = phi(obj.sol(3*i + 1));
                    obj.sol(3*i + 3) = phi(obj.sol(3*i + 2));
                    i = i + 1;
                end
                obj.iter = i;
            end
        end
        
        function errrel = Eroarea_Relativa(obj)
           
           errrel = zeros(size(obj.sol));
           [~, y] = size(obj.sol);
           for i = 2:y
             errrel(i) = abs(obj.sol(i) - obj.sol(i - 1)) / abs(obj.sol(i));
           end
           return;
        end
        function errabs = Eroarea_Absoluta(obj)
           errabs = zeros(size(obj.sol));
           [~, y] = size(obj.sol);
           for i = 2:y
             errabs(i) = abs(obj.sol(i) - obj.sol(i - 1));
           end
        end
        function errrez = Eroarea_Reziduala(obj)
          errrez = zeros(size(obj.sol));
          [~, y] = size(obj.sol);
          for i = 1:y                        
            errrez(i) = abs(obj.f(i));
          end
           
        end
        function output = Toleranta(obj)
             output = obj.TOL;
             return;
        end

    end
    
    
    methods (Access = private)
        
        function boolean = ErrAbs(obj, n)
            boolean = abs(obj.sol(n) - obj.sol(n-1)) > obj.TOL; 
        end
        
        function boolean = ErrRel(obj, n)
            boolean = (ErrAbs(obj, n) / abs(n)) > obj.TOL;
        end
        
        function boolean = Select_Err(obj, n)
            switch (obj.OPT_err)
                case 1
                    boolean = ErrAbs(obj, n) && n<=obj.ITMAX;
                    return;
                                        
                case 2
                    boolean = ErrRel(obj, n) && n<=obj.ITMAX;
                    return;
                    
                case 3
                    if(obj.okf == 1)
                       boolean = abs(obj.f(n)) > obj.TOL && n<=obj.ITMAX;
                    end
                    return;
                   
            end
        end
        
        function val = A...
            (~, ... %obiectul
            x, ... %n 
            y, ... %n - 1
            z) %n - 2
            val = x - (x-y)^2 /((x-y)-(y-z));
        end
        
        function nr = phi_if(obj, t)
             switch (obj.OPT_phi)
                 case 0
                     nr = obj.newton_raphson(t);
                 case 1
                     nr = obj.newton_raphsonm1(t);
                 case 2
                     nr = obj.newton_raphsonm2(t);
             end
        end
        
        function temp =  newton_raphsonm1(obj, t)
            temp = t  - obj.m * obj.f(t) / obj.df(t);
        end
        
        function temp = newton_raphsonm2(obj, t)
            miu = @(x) obj.f(x) / obj.df(x);
            x = sym('x');
            dmiu = matlabFunction(diff(sym(miu), x));
            temp = t  - miu(t) / dmiu(t);
        end
        
        function temp = newton_raphson(obj, t)
            temp = t - obj.f(t) / obj.df(t);
        end
        
        function not_exist(~, s)
           error(s); 
        end
        
        function boolean = isnumber(~, n)
            if(isnumeric(n) == 1)
                if(~isnan(n))
                    boolean = 1;
                    return;
                else 
                    boolean = 0;
                    return;
                end
            else 
                boolean = 0;
                return;
            end
        end
        
    end
    
end

