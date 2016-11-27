function [mutant] = mutation(F, base, vector_r1, vector_r2)
    perm = diference_operator(vector_r1, vector_r2);
    [nperm ~] = size(perm);
    
    indexes = randperm(nperm, round(F*nperm));
    
    for i=1:length(indexes)
       permutation = perm(indexes(i),:);
       
       aux = base(permutation(1));
       base(permutation(1)) = base(permutation(2));
       base(permutation(2)) = aux;
    end
    mutant = base;
end