function Y = pol(F)
    %returneaza o matrice de n x 2 (prima coloana e polul, a doua coloana e
    %ordinea polului
    syms real
    [~, d] = numden(F);
    disp("Extragem numitorul si rezolvam ecuatia numitorului");
    syms x
    fprintf("Vrem sa rezolvam ecuatia %s = 0\n", d(x));
    fprintf("Matlab imi rezolva automat, asadar trebuie sa rezolvi singur\n");
    syms x real
    solve_d = d == 0;
    sol = unique(solve(solve_d));
    [e,~] = size(sol);
    fprintf("Polii gasiti in intervalul sunt:\n");
    syms t
    for i=1:e
          fprintf("pol(%d) = %s\n", i, simplify(sol(i)));
          sol(i) = simplify(sol(i));
          Y(i, :) = [sol(i) get_order(F, sol(i), 0)];
    end 
end