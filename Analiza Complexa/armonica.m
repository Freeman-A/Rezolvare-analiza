function Y = armonica(F)
   syms x y
   fprintf("Verificam daca functia %s este armonica in 3 pasi simplii\n", F);
   disp("Pasul 1:");
   disp("Calculam derivatele partiale ale lui F");
   xdiff = simplify(diff(F, x));
   ydiff = simplify(diff(F, y));
   fprintf("Derivatele partiale sunt:\n%s\n%s\n", xdiff, ydiff);
   xxdiff = simplify(diff(xdiff, x));
   yydiff = simplify(diff(ydiff, y));
   disp("Pasul 2:");
   disp("Calculam derivatele partiale de ordinul 2");
   fprintf("Derivatele partiale de ord 2 sunt:\n%s\n%s\n", xxdiff, yydiff);
   disp("Pasul 3:");
   disp("Verificam daca suma derivatelor de ordinul 2 fac 0, daca nu, functia nu e armonica");
   if(xxdiff + yydiff == 0)
       Y = 1;
       fprintf("Fiindca %s + %s = 0, atunci functia este armonica", xxdiff, yydiff);
       disp("Daca functia este armonica pe un interval convex atunci exista F: C -> C, F(x) - olomorf si Re(F(x)) = f");
       return;
   else 
       fprintf("Fiindca %s + %s este diferit de 0, atunci functia NU este armonica", xxdiff, yydiff);
       Y = 0;
       return;
   end
  

end