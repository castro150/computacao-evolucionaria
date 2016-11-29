% Funcao para realizar operacao de mutacao utilizando a
% Abordagem por Lista de Movimentos
function [mutant] = mutation(F, base, vector_r1, vector_r2)
    % obtem sequencia de permutacoes para transformar vector_r2 em
    % vector_r1
    perm = diference_operator(vector_r1, vector_r2);
    [nperm ~] = size(perm);
    
    % Obtem permutacoes a serem aplicadas no vetor base
    indexes = randperm(nperm, round(F*nperm));
    
    % Aplica permutacoes no vetor base
    for i=1:length(indexes)
       permutation = perm(indexes(i),:);
       
       aux = base(permutation(1));
       base(permutation(1)) = base(permutation(2));
       base(permutation(2)) = aux;
    end
    mutant = base;
end