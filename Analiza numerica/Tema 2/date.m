f = @(x) cos(x) - x;
x0 = pi / 4;
vec = NewtonRaphson(f, x0, eps);
avec = size(vec);
j = 1;
for i = size(vec)
   if(vec(i) >= 0 && vec(i)<=pi/2)
       avec(j) = vec(i);
       j = j + 1;
   end
end
disp(avec);
fplot(f, [0, pi/2], '-r');
hold on
line([0, pi/2], [0, 0]);
hold on
plot(avec, f(avec), '-og');
legend('Graficul functiei f', 'Linia y=0', 'Punctele vectoriilor in raport cu functia');