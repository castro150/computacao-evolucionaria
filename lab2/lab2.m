%População de 30 indivíduos e um máximo de 1000 iterações.
function lab2(pop_size, n_int)
    N = 8;
    values = [5 8 7 6 9 5 4 3];
    weights = [10 18 12 14 13 11 8 6];
    cap = 35;
    
    % Parâmetros de variação para analise.
    pc = 0.6;
    m_prob = 0.05;
	
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
        for i=1:pop_size
            quality(i) = fitness_ksp(population(i,:), values, weights, cap); 
        end
        best(pop_count) = max(quality);
        middle(pop_count) = mean(quality);
        pop_count = pop_count + 1;
    end
    plot(1:(n_int+1), best, '.', 1:(n_int+1), middle, '.');
end

% Roleta:
% cumProb=cumsum(vec_probs) = somatório cumulativo para os intervalos da roleta
% [~,pai1]=histc(rand(1,cumProb)) = sorteio no histograma que tende pra baixo
% como retorna 0, tem que somar 1 para criar o índice.