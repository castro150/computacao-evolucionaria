function [makespan, sequence, avg_fit, best_fit] = JSSP(filename)
    % Leitura dos dados de entrada
    input_data  = dlmread(filename);
    [norders,~] = size(input_data);
    
    % Inicializando valores e parametros do algoritmo
    generation  = 1;
    pop_size    = norders^2;
    avg_fit     = zeros(1,pop_size);
    best_fit    = zeros(1,pop_size);
    population  = pop_ini(norders,pop_size);
    new_pop     = zeros(pop_size,norders);
    mutant_pop  = zeros(pop_size,norders);
    max_gen     = 500;
    
    % Parametros do algoritmo de evolucao diferencial
    C = 0.8;
    F = 0.9;
    
    while((generation <= max_gen))%% Pensar no history && (mean(history) > 1e-3 || generation < 6))
        fitness = fitness_of_population(input_data, population);
        
        delta = randi(pop_size,1);
        for i = 1:pop_size
            r1 = randi(pop_size,1);
            r2 = randi(pop_size,1);
            r3 = randi(pop_size,1);

            mu = rand(1);
            if((mu <= C)||(i == delta))
                mutant_pop(i,:) = mutation(F, population(r1,:), population(r2,:), population(r3,:));
            else
                mutant_pop(i,:) = population(i,:);
            end

            mutant_fitness = fitness_calc(input_data, mutant_pop(i,:));
            if(fitness(i) >= mutant_fitness)
                new_pop(i,:) = mutant_pop(i,:);
                fitness(i) = mutant_fitness;
            else
                new_pop(i,:) = population(i,:);
            end

            population(i,:) = new_pop(i,:);
        end
        
        avg_fit(generation) = mean(fitness);
        best_fit(generation) = min(fitness);
        generation = generation + 1;
    end
end