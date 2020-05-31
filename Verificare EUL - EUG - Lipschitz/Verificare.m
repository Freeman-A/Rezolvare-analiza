function [Lipschitz, EUL, EUG] = Verificare(F, cond, point)
  syms x t
  if(cond == 'a' && point == 'a')
      disp(feval(symengine,'discont',F, x));
       if(feval(symengine,'discont',F, x)==0)
          disp("Are existenta locala fiindca este continua");
          y = diff(F);
          if(feval(symengine,'discont',F,y)==0)
             disp("Este lipschitz si are EUL");
             Lipschitz = 1;
             EUL = 1;
          else
             disp("Nu este local lipschitz si posibil sa aiba EUL");
             Lipschitz = 0;
             EUL = 1;
             disp("Studiem unicitatea:");
             ode = diff(x(t)) == F;
             t = dsolve(ode);
             disp(t);
          end
      else
          Lipschitz = 0;
          EUL = 0;
          EUG = 0;
          return;
       end
       return;
  end
  [~, t1] = size(cond);
  ok = 0;
  a = 1;
  if (t1 == 1)
      if(feval(symengine,'discont',F,x)==0)
          ok = 1;
      else
          Lipschitz = 0;
          EUL = 0;
          EUG = 0;
          return;
      end
  end

  temp = F(x);
  if(ok == 0)
      for i=1:(t1-1)
            if(limit(temp(i), x, point(i)) ~= limit(temp(i+1), x, point(i+1)))
                 a = 0;
            end
      end
  end
  if(a == 0)
      EUL = 0;
      EUG = 0;
      Lipschitz = 0;
      disp("Nu are niciuna din toate 3 tipurile");
  end
  if(a ~= 0)
  ok = 1;
  if(ok == 1)
     disp("Verificam daca e Lipschitz sau nu:");
     g_t = diff(F);
     ok_t = 1;
     for i=1:(t1-1)
            temp = g_t(x);
            if(limit(temp(i), x, point(i)) ~= limit(temp(i+1), x, point(i)))
                 ok_t = 0;
            end
     end
     if ok_t == 1
         disp("Ecuatia este Lipschitz (II) deci EUL prin teorema Cauchy Lipschitz");
         disp("Este unic deci admite EUL. Fiindca admite EUL admite UL");
         disp("Folosind teorema UL => admite UG pe interval");
         disp("Fiindca e lipschitz => admite EG pe interval");
         Lipschitz = 1;
         EUL = 1;
         EUG = 1;
     else
         Lipschitz = 0;
         disp("Ecuatia nu este Lipschitz (II), dar inca mai e posibil sa fie EUL");
         disp("Fiindca ecuatia este continua si e definita pe o multime deschisa, din teorema Peano => EL");
         disp("Studiem unicitatea:");   
         counter = 0;
         vec = [];
         vec_s = [];
         temp = F(x);
         syms t x(t) t3(t)
         temp2 = temp(i);
         t3(t) = str2sym("");
         for i=1:1:t1
             t3(t) = sym(temp2);
             ode = diff(x, t) == t3;
             try
                 vec = [vec, dsolve(ode)];
                 vec_s = [vec_s, dsolve(ode)];
             catch
                 counter = counter + 1;
                 [~, tempvar] = size(symvar(sym(temp2)));
                 temp_var = symvar(symvar(sym(temp2)));
                 tempok = 0;
                 for k=1:tempvar
                     if("t" == temp_var(k))
                          tempok = 1;
                          break;
                     end
                 end
                 if(tempok == 0)
                        vec = [vec, 1 / temp2];
                        
                 end
             end
         end
             
     end
         ok_t = 1;
         for i=1:1:(t1-1)
             if(limit(vec(i), t, point(i)) ~= limit(vec(i+1), t, point(i)))
                 ok_t = 0;
            end
             
         end
         if(ok_t == 0)
             disp("Nu este unic deci nu e nici EUG.");
             EUG = 0;
             EUL = 0;
         else
             disp("Este unic deci admite EUL. Fiindca admite EUL admite UL");
             disp("Folosind teorema UL => admite UG pe interval");
             if(counter == t1)
                 EUG = 1;
                 disp("Admite EUG");
             else
                [~, t1] = size(vec_s);
                ok_eug = 1;
                for i=1:t1
                    if(limit(vec_s(i), x, point(i)) ~= limit(vec_s(i+1), x, point(i)))
                          ok_eug = 0;
                     end
                    
                end
                if(ok_eug == 1)
                    EUG = 1;
                    disp("Admite EUG");
                else
                    disp("Nu admite EUG");
                    EUG = 0;
                end
                    
                 
             end
             EUL = 1;
         end
     
     
  end
  end
       
      
      
      
end