function Y = integrala_complexa(F, gamma, a, b)
%INTEGRALA COMPLEXA VERSIUNEA V0.0.1
%======================================================================
%Made by Andreas Mihalea
%======================================================================
syms x
     fprintf("Functia integralei este: %s\n", F(x));
     fprintf("Functia domeniu este: %s\n", gamma(x));
     fprintf("Stabilim daca functia gamma introdusa este drum:\n");
     fprintf("Pasul 1: Stabilim daca functia e olomorfa\n");
     if(derivabila(gamma) == 1)
           fprintf("Pasul 2: Stabilim daca functia e marginita\n");
           fprintf("Calculam derivata si facem tabel de semne\n");
           if(marginire(gamma, a, b) == 1)
               
           syms F_r F_i real
           fprintf("Integrala complexa citita este: ");
           syms x real 
           fprintf("%s este intre [%d %d]\n", F(gamma) * diff(gamma, x), a, b);
           Int = int(F(gamma) * diff(gamma, x));
           [s, s1] = size(strfind(sym2str(Int), 'int'));
           if(s1 ~= 0 && s ~= 0)
               fprintf("Nu se poate calcula integrala respectiva\n");
               fprintf("Se incearca daca functia integrata e olomorfa\n");
               if(derivabila(F) == 1)
                   fprintf("Solutia este 0, folosind teorema Cauchy pentru functii olomorfe\n");
                   Y = 0;
                   return;
               else
                   if(gamma(a) == 0 && gamma(b) == 0)
                       disp("Integrala are un drum rectificabil inchis => I = 0");
                       disp("Functia domeniu e rectificabil");
                       Y = 0;
                   else     
                   fprintf("Functia nu este olomorfa\n");
                   fprintf("Vom aproxima prin seria Taylor\n");
                   fTaylor = taylor(F,x,'ExpansionPoint',a,'Order',b);
                   fprintf("Seria Taylor a functiei %s este %s", F, fTaylor);
                   fprintf("Deci integrala este %s", int(fTaylor, x, a, b));
                   Y = int(fTaylor, a, b);
                   return;
                   end
               end
           else
               Yt = simplify(Int);
               fprintf("Integrala nedefinita este %s\n", Yt);
               Y = Yt(b) - Yt(a);
               fprintf("Rezultatul este: %s\n", Y); 
           end
           end
     else
         fprintf("Functia nu e olomorfa\n");
     end


end