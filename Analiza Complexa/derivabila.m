function Y = derivabila(F)
   if ~isa(F, 'sym')
    F = sym(F);
   end
   syms e(x,y) g(x,y) t(x) g 
   syms x y real
   F_c = F(x+1i*y);
   e = real(F_c);
   g = imag(F_c);
   fprintf("Partea reala e: %s\nPartea imaginara e: %s\n", e, g);
   syms diffe(x,y) diffg(x,y) diffey(x,y) diffgy(x,y)
   diffe(x,y) = simplify(diff(e, x));
   diffey(x,y) = simplify(diff(e, y));
   diffg(x,y) = simplify(diff(g, x));
   diffgy(x,y) = simplify(diff(g, y));
   fprintf("Derivatele partiale sunt:\nReal:\n%s\n%s\nImaginar:\n%s\n%s\n",diffe, diffg, diffey, diffgy);
   if(diffe(x,y) == diffgy(x,y) && diffey(x,y) == -diffg(x,y))
           disp("Functia este olomorfa");
           disp("Functia este diferentiabila in D inclus in C");
           disp("F analitica pe D");
           Y = 1;
   else
            disp("Functia nu este olomorfa");
            Y = 0;
   end
   


end