function parent = parent_selection_roulette(fitness, population, pop_size)
    [~,g_size]=size(population(1,:));
    parent=zeros(pop_size,g_size);
    for i=1:pop_size
        cumProb = cumsum(fitness)/sum(fitness);
        aux = rand();
        for j=1:pop_size
            if(cumProb(j) > aux)
               if(j == 1)
                   index = 1;
               else
                   index = j - 1;
               end
               break
            end
        end
        parent(i,:)=population(index,:);
    end
end