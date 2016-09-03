function lab1(N)

    pop_count = 1;
    M = 0.1*factorial(N);
    
    population = zeros(M, N);
    fits = zeros(1, M);
    for i=1:M
        population(i,:) = randperm(N);
        fits(i) = fitness_nq(population(i,:));
    end
    best(pop_count) = min(fits);
    mn(pop_count) = mean(fits);

%TODO: corrigir critério de parada.
    while sum(fits) > 0
        parents = get_parents(population, fits, M);
        
        pop_count=pop_count+1;
%TODO: atualizar best e mn.
    end
    
end

% Obtém dois indivíduos para o crossover.
function [parents] = get_parents(population, fits, M)
    parent_index = zeros(1,5);
    % Inicializando com os piores indivíduos da população.
    best_parents = [find(fits==max(fits), 1), find(fits==max(fits), 1)];
    
    % Selecionando cinco indivíduos e os dois melhores entre eles.
    for i=1:5
        % Garantindo que o indivíduo atual ainda não foi avaliado.
        temp = round(1+rand(1)*(M-1));
        while ismember(temp, parent_index)
            temp = round(1+rand(1)*(M-1));
        end
        parent_index(i) = temp;
        
        % O melhor entre os dois melhores ficará em primeiro.
        if fits(parent_index(i)) <= fits(best_parents(1))
            % Passa o primeiro para segundo.
            best_parents(2) = best_parents(1);
            % Substitui o primeiro.
            best_parents(1) = parent_index(i);
        elseif fits(parent_index(i)) <= fits(best_parents(2))
            % Substitui o segundo.
            best_parents(2) = parent_index(i);
        end
    end
    
    parents = [population(best_parents(1),:); population(best_parents(2),:)];
end
    