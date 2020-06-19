function Y = index_drum(gamma, a, b, z)
   fprintf("Calculam indexul pentru punctul %d", z);
   syms x F(x)
   F(x) = 1 / (x - z);
   Y = integrala_complexa(F, gamma, a, b);
end