% Funcao para calcular o makespan dos pedidos em uma determinada sequencia
function [makespan] = fitness_calc(orders, sequence)
    % reordena os pedidos de acordo com a sequencia
    orders_unordered = orders;
    for i=1:length(sequence)
        orders(i,:)=orders_unordered(sequence(i),:);
    end

    [n_orders, n_machines] = size(orders);
    aux_matrix = zeros(n_machines, n_orders);
    
    % preenche primeira linha da matriz
    aux_matrix(1,1) = orders(1,1);
    for j=2:n_orders
        aux_matrix(1,j) = aux_matrix(1,j-1) + orders(j,1);
    end
    
    % preenche restante da matriz
    for i=2:n_machines
        aux_matrix(i,1) = aux_matrix(i-1,1) + orders(1,i);
        for j=2:n_orders
            aux_matrix(i,j) = max(aux_matrix(i,j-1),aux_matrix(i-1,j)) + orders(j,i);
        end
    end
    
    % display(aux_matrix)
    makespan = aux_matrix(n_machines, n_orders);
end