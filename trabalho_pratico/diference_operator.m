function [perm] = diference_operator(v1, v2)
    j = 1;
    for i=1:length(v1)
        if(v1(i) ~= v2(i))
            perm(j,1) = i;
            perm(j,2) = find(v2 == v1(i));
            aux = v2(i);
            v2(i) = v2(perm(j,2));
            v2(perm(j,2)) = aux;
            j = j + 1;
        end
    end
    display(perm)
end