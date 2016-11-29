% Funcao para calcular valor do fitness de todos os individuos de uma
% populacao
function [fitness] = fitness_of_population(input_data, population)
    [pop_size,~] = size(population);
    fitness = zeros(1,pop_size);
    
    for i=1:pop_size
        fitness(i) = fitness_calc(input_data, population(i,:));
    end
end