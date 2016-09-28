% Crossover com um ponto de corte.
function [children1, children2] = crossover_one_cut(parent1, parent2, pc)
    N = size(parent1); N = N(2);
    children1 = parent1;
    children2 = parent2;
    
    if rand() < pc
        cut_point = round(1+rand()*(N-2));
        children1 = [parent1(1:cut_point) parent2(cut_point+1:N)];
        children2 = [parent2(1:cut_point) parent1(cut_point+1:N)];  
    end
end