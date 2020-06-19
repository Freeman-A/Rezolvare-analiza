function y = conforma(F, x0)
    if(derivabila(F) == 1)
         syms e(x,y) g(x,y) x y x1 x2
         F_c(x,y) = F(x+1i*y);
         x1 = real(x0);
         x2 = imag(x0);
         syms real
         e(x,y) = real(F_c);
         g(x,y) = imag(F_c);
         syms diffe(x,y) diffg(x,y) diffey(x,y) diffgy(x,y)
         diffe(x,y) = diff(e, x);
         diffey(x,y) = diff(e, y);
         diffg(x,y) = diff(g, x);
         diffgy(x,y) = diff(g, y);
         if(diffe(x1,x2) ~= 0)
             if(diffg(x1,x2) ~= 0)
                 if(diffey(x1,x2) ~= 0)
                     if(diffgy(x1,x2) ~= 0)
                         disp("F este conforma de speta I si a II a");
                         y = 1;
                         return;
                     end
                 end
             end
         end
         
    else
        disp("F nu e derivabila");
        y = 0;
        return;
    end
    y = 0;

end