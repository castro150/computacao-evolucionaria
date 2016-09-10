%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computacao evolucionaria - lab1                                         %
% Integrantes: Davi Viana e Rafael Castro                                 %
%                                                                         %
% Algoritmo genetico que obtem uma solucao para o problema das N rainhas  %
% Exemplo de uso: lab1(10, 100) resolve o problema para 10 rainhas com    %
% uma populacao de tamanho 100                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function lab1(N, pop_size)
    pop_count = 1;
    p_mutation= 0.8;
    
    % inicializa populacao e obtem qualidade
    population = zeros(pop_size, N);
    quality = zeros(pop_size, 1);
    for i=1:pop_size
        population(i,:) = randperm(N);
        quality(i) = fitness_nq(population(i,:));
    end
    best(pop_count) = min(quality);
    middle(pop_count) = mean(quality);

    while (min(best)~=0)
        % obtem os pais e os filhos da nova geracao
        parents = get_parents(population, quality, pop_size);
        sons = CutAndCrossfill_Crossover(parents);
        
        % executa mutacao caso ocorra (probabilidade)
        if(have_mutation(p_mutation))
            sons = mutate(sons, N);
        end
        
        n_sons = 2;
        [population, quality] = get_survivors(population, quality, sons, n_sons);
        
        pop_count=pop_count+1;
        best(pop_count) = min(quality);
        middle(pop_count) = mean(quality);
        
    end
    plot(1:pop_count, best, '.', 1:pop_count, middle, '.');
end