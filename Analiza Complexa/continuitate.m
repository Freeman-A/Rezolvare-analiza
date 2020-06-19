function Y = continuitate(F, cond)
      
 %cond = reprezinta puncte de continuitate 
      
 %EX: F(x) = {x, x < 1, 1, x > 1} deci punctul de verificare e 1 
      
 %Se ia doua ramuri un pct de continuitatea sau mai multe
      
 %Se foloseste asa F(x) = [x, 1] si cond = [1, 1]; si tot asa;
      
 %Exemplu F(x) = {sin(x) x<1; cos(x) x>1;} atunci se va introduce F(x) =
 %[sin(x), cos(x)] si cond = [1, 1]; R: functia nu e continua;
 
 [~, e] = size(cond);
 if(e == 0)
     Y = 1;
     disp("Functia e continua fiindca e elementara");
 else
     
     
     
 end
 

end