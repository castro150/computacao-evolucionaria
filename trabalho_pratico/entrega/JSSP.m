function [makespan, sequence, avg_fit, best_fit] = JSSP(filename)
    % Leitura dos dados de entrada
    input_data  = dlmread(filename);
    [norders,~] = size(input_data);
    
    % Inicializando valores e parametros do algoritmo
    generation  = 1;
    pop_size    = norders^2;
    max_gen     = 500;
    avg_fit     = zeros(1,max_gen);
    best_fit    = zeros(1,max_gen);
    population  = pop_ini(norders,pop_size);
    new_pop     = zeros(pop_size,norders);
    mutant_pop  = zeros(pop_size,norders);
    min_gen     = 6;
    h_size      = 5;
    history     = zeros(h_size,1);
    
    % Parametros do algoritmo de evolucao diferencial
    C = 0.8;
    F = 0.9;
    
    % Limite de populacao
    if(pop_size > 1000)
        pop_size = 1000;
    end
    
    % Criterios de parada: maximo numero de geracoes e alteracoes
    % significativas no valor do fitness
    while((generation <= max_gen) && (mean(history) > 1e-6 || generation < min_gen))
        fitness = fitness_of_population(input_data, population);
        
        delta = randi(pop_size,1);
        for i = 1:pop_size
            % Executa operacao de mutacao algoritmo AED para problema de
            % permutacao
            r1 = randi(pop_size,1);
            r2 = randi(pop_size,1);
            r3 = randi(pop_size,1);
            mu = rand(1);
            if((mu <= C)||(i == delta))
                mutant_pop(i,:) = mutation(F, population(r1,:), population(r2,:), population(r3,:));
            else
                mutant_pop(i,:) = population(i,:);
            end

            % Operador de selecao para escolher melhor individuo
            mutant_fitness = fitness_calc(input_data, mutant_pop(i,:));
            if(fitness(i) >= mutant_fitness)
                new_pop(i,:) = mutant_pop(i,:);
                fitness(i) = mutant_fitness;
            else
                new_pop(i,:) = population(i,:);
            end

            % substitui toda a populacao existente pelos melhores
            % individuos
            population(i,:) = new_pop(i,:);
        end
        
        avg_fit(generation) = mean(fitness);
        best_fit(generation) = min(fitness);
        makespan = min(fitness);
        best_sequences = find(fitness==min(fitness));
        sequence = population(best_sequences(1),:);
        
        % Armazena dados no historico
        history(mod(generation,h_size)+1,1) = max(fitness) - min(fitness);
        
        generation = generation + 1;
    end
    
    % Limita valores de retorno para a quantidade de geracoes utilizada
    avg_fit  = avg_fit(1:(generation - 1));
    best_fit = best_fit(1:(generation - 1));
end