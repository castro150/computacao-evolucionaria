%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computacao evolucionaria - lab2                                         %
% Integrantes: Davi Viana e Rafael Castro                                 %
%                                                                         %
% Algoritmo genetico que obtem uma solucao para o problema da Mochila 0/1 %
% Exemplo de uso: lab2(30,1000) onde 1000 é a quantidade máxima de        %
% iteracoes e 30 é a quantidade de individuos por geracao.                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function lab2(pop_size, n_int)
    N = 8;
    values = [5 8 7 6 9 5 4 3];
    weights = [10 18 12 14 13 11 8 6];
    cap = 35;
    
    % Parâmetros de variação para analise.
    pc = 0.8;
    m_prob = 0.15;
	
    pop_count = 1;
    % inicializa populacao e obtem qualidade
    population = zeros(pop_size, N);
    quality = zeros(pop_size, 1);
    for i=1:pop_size
        population(i,:) = round(rand(1, N));
        quality(i) = fitness_ksp(population(i,:), values, weights, cap); 
    end
    best(pop_count) = max(quality);
    middle(pop_count) = mean(quality);
    pop_count = pop_count + 1;
    
    for i=1:n_int
        parents = parent_selection_roulette(quality, population, pop_size);
        children = zeros(pop_size, N);
        for j=1:2:(pop_size-1)
            [children(j,:), children(j+1,:)] = crossover_one_cut(parents(j,:), parents(j+1,:), pc);
        end
        children = bit_flip_mutation(children, pop_size, m_prob);
        population = children;
        for j=1:pop_size
            quality(j) = fitness_ksp(population(j,:), values, weights, cap); 
        end
        best(pop_count) = max(quality);
        middle(pop_count) = mean(quality);
        pop_count = pop_count + 1;
        
        identical = 0;
        if(i > 10)
            for j=0:10
                if(middle(i-j) == middle(i))
                    identical = identical + 1;
                end
            end
            if(identical == 10)
                break;
            end
        end
    end
    plot(1:i, best(1:i), '.', 1:i, middle(1:i), '.');
    title({'Fitness em função da geração'; sprintf('p_{mutação} = %.2f, p_{cruzamento} = %.2f', m_prob, pc)});
    xlabel('Geração');
    ylabel('Fitness');
    legend('Fitness máximo', 'Fitness médio');
end