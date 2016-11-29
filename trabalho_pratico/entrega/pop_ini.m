% Funcao para inicializar populacao
function [population] = pop_ini(nsubjects, pop_size)
    population = zeros(pop_size,nsubjects);
    for i = 1:pop_size
        population(i,:) = randperm(nsubjects);
    end
end