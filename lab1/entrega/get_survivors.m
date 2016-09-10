function [population, pop_quality] = get_survivors(population,pop_quality,sons,n_sons)
    sons_quality = zeros(n_sons, 1);
    for i=1:n_sons
        sons_quality(i) = fitness_nq(sons(i,:));
    end

    pop_quality = [pop_quality;sons_quality];
    population = [population;sons];
    [q_sort,indexes] = sort(pop_quality,'descend');

    %Removendo piores indivíduos
    if (indexes(1) < indexes(2))
        population(indexes(1),:) = [];
        population(indexes(2)-1,:) = [];
        pop_quality(indexes(1)) = [];
        pop_quality(indexes(2)-1) = [];
    else
        population(indexes(1),:) = [];
        population(indexes(2),:) = [];
        pop_quality(indexes(1)) = [];
        pop_quality(indexes(2)) = [];
    end
end