% Obt�m dois indiv�duos para o crossover.
function [parents] = get_parents(population, fits, M)
    parent_index = zeros(1,5);
    % Inicializando com os piores indiv�duos da popula��o.
    best_parents = [find(fits==max(fits), 1), find(fits==max(fits), 1)];
    
    % Selecionando cinco indiv�duos e os dois melhores entre eles.
    for i=1:5
        % Garantindo que o indiv�duo atual ainda n�o foi avaliado.
        temp = round(1+rand(1)*(M-1));
        while ismember(temp, parent_index)
            temp = round(1+rand(1)*(M-1));
        end
        parent_index(i) = temp;
        
        % O melhor entre os dois melhores ficar� em primeiro.
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