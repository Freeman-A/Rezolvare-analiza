classdef Bisectie
    %===================================================================
    %
    %Functia Bisectie
    %
    %Argumente: 
    %F - functia handle, TOL - Toleranta, a - capatul din stanga, b - capatul din dreapta a intervalului [a, b]
    %[OPTIONAL] OPT - tipul de oprire, default 2
    %Tipuri de OPT:
    %OPT = 1 -> |Xn+1 - Xn| <= TOL
    %OPT = 2 -> |Xn+1 - Xn| / |Xn| <= TOL
    %OPT = 3 -> |F(Xn)| <= TOL
    %
    %Return:
    %Index - Numarul de pasi
    %X(Index) notat cu Result - Valoarea aproximativa
    %
    %TEST MODE
    %Scrie Bisectie; pentru a afisa rezultatul de la b)
    %
    %===================================================================
    properties (Access = protected) %%date intrare
        Toleranta = realmin %Default: MINIMUM
        a = realmax %Default: MAXIMUM
        b = realmin %Default: MINIMUM
        Tehnica_Oprire_Grad = 2 %Default 2
    end
    %===================================================================%
    properties (Access = public) %%date iesire
        Index = 1 %Default: 1
        Result = realmax; %Default: MAXIMUM
    end
    %===================================================================%
    methods (Access = public)
        function ep = Bisectie(F, TOL, a, b, OPT) 
                %F - functia handle, TOL - Toleranta, a - capatul din stanga, b - capatul din dreapta a intervalului [a, b], [OPTIONAL] OPT - tipul de oprire
                %Tipuri de OPT:
                %OPT = 1 -> |Xn+1 - Xn| <= TOL
                %OPT = 2 -> |Xn+1 - Xn| / |Xn| <= TOL
                %OPT = 3 -> |F(Xn)| <= TOL
                %
                %Return:
                %Index - Numarul de pasi
                %X(Index) notat cu Result - Valoarea aproximativa
                %
                %TEST MODE
                %Scrie Bisectie; pentru a afisa rezultatul de la b)
                %
           if(exist('F', 'var') && exist('TOL', 'var') && exist('a', 'var') && exist('b', 'var'))
               if(~isa(F,'function_handle'))
                   error('F must be a function handle, if you want to see the arguments write "help Bisectie"');
               end
               if(~isnumeric(TOL) || TOL < 0)
                   error('TOL must be a real positive number, if you want to see the arguments write "help Bisectie"');
               end
               if(TOL >= 1)
                   warning('I recommend that TOL should be LOWER than 1, to extend the accuracy.');
               end
               if(~isnumeric(a))
                    error('a, must be a real number lower than b, if you want to see the arguments write "help Bisectie"');
               end
               if(~isnumeric(b))
                    error('b, must be a real number higher than a, if you want to see the arguments write "help Bisectie"');
               end
               if(a > b)
                    error('a, must be a real number lower than b, if you want to see the arguments write "help Bisectie"');
               end
               
               
                if exist('comd_op','var')
                    if(~isnumeric(OPT))
                        error('OPT must be a number between 1 and 3, if you want to see the arguments write "help Bisectie"');
                    end
                    if(OPT >=1 && OPT <=3)
                        ep.Tehnica_Oprire_Grad = OPT;
                    else
                        error('OPT must be a number between 1 and 3, if you want to see the arguments write "help Bisectie"');
                    end
                else 
                      ep.Toleranta = TOL;
                      ep.a = a;
                      ep.b = b;
                      [ep.Index, ep.Result] = calculate_return(ep, F);
                      return;
                end
              ep.Toleranta = tol;
              ep.a = a;
              ep.b = b;
             [ep.Index, ep.Result] = calculate_return(ep, F);
           else
               if(exist('F', 'var'))
                   if(~(exist('TOL', 'var')))
                           error('Error, you didnt selected the other options. IF you want to try the test mode, just run without arguments');
                   else
                       if(~(exist('a', 'var')))
                          error('Error, you didnt selected the other options. IF you want to try the test mode, just run without arguments');
                       else
                           if(~(exist('b', 'var')))
                               error('Error, you didnt selected the other options. IF you want to try the test mode, just run without arguments');
                           end                           
                       end
                   end
                   
               end
               if(nargout > 0)
                   error('The function in beta mode doesn t return nothing');
               else
               fprintf("Ai selectat test mode ul de la b): ");
               fprintf("f(x) = x^2 - 3 \n");
               ep.Toleranta = 10^(-10);
               ep.a = 1;
               ep.b = 2;
               for i=1:3
                   fprintf("Pentru metoda oprire %d:\n", i);
                   ep.Tehnica_Oprire_Grad = i;
                   f_temp = @(x) (x^2 - 3);
                   ep.Index = 1;
                   [ep.Index, ep.Result] = calculate_return(ep, f_temp);
                   disp(ep);
               end
               return;
               end
           end
             
        end
    end
    
    %===================================================================
    
    methods (Access = private) %%%Functiile temporare de calcul
        function e = condition_type(ep, f_t, x, index)
            if(ep.Tehnica_Oprire_Grad == 1)
                e = abs(ep.b - ep.a) > ep.Toleranta;
                return;
            end
            if(ep.Tehnica_Oprire_Grad == 2)
                e = (abs(ep.b - ep.a) / abs(ep.a)) > ep.Toleranta;
                return;
            end
            if(ep.Tehnica_Oprire_Grad == 3)
                e = abs(f_t(x(index))) > ep.Toleranta;
                return;
            end  
        end
        function [it, g] = calculate_return(ep, f) 
              it = ep.Index;
              x(it) = ep.a + (ep.b - ep.a) / 2;
                  
                  while condition_type(ep, f, x, it)
                        if f(ep.a)*f(x(it))<0
                        ep.b=x(it);
                        else
                        ep.a=x(it);
                        end
                     it = it + 1;
                     x(it)=(ep.a + ep.b)/2;
                  end
              g = x(it);
        end
        
    end
    
    %===================================================================
end