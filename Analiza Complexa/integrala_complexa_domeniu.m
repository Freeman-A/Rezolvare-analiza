function Y = integrala_complexa_domeniu(F, domeniu, a, b)
      if(derivabila(F) == 1)
           if(domeniu == "triunghi")
                 disp("Integrala este 0");
                 Y = 0;
                 return;
           end
           if(domeniu == "bila")
                r = input("Introduceti raza");
                
           end
          
          
          
          
          
          
      else
          Y = 0;
          disp("Functia nu e olomorfa");
          return;
      end
end