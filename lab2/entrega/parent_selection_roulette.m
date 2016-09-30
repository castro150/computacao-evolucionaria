function parent = parent_selection_roulette(fitness, population, pop_size)
    [~, g_size] = size(population(1,:));
    parent = zeros(pop_size, g_size);
    accumulation = cumsum(fitness);
    
    for i = 1:pop_size
        selected = rand() * accumulation(end);
        for j = 1:length(accumulation)
            if (accumulation(j) > selected)
                parent(i,:) = population(j,:);
                break;
            end
        end
    end
end