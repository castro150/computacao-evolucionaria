function [makespan, sequence, avg_fit, best_fit] = JSSP(filename)
    % Leitura dos dados de entrada
    input_data  = dlmread(filename);
    [norders,~] = size(input_data);
    
    % Inicializando valores e parametros do algoritmo
    generation  = 1;
    pop_size    = norders^2;
    avg_fit     = zeros(1,pop_size);
    best_fit    = zeros(1,pop_size);
    population  = pop_ini(norders, pop_size);
    
    %while(criterio_parada)
        fitness = fitness_of_population(input_data, population);
        avg_fit(generation) = mean(fitness);
        best_fit(generation) = min(fitness);
        generation = generation + 1;
    %end
end