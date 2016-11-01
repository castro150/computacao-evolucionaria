
function plotar(fobj,lb,ub,g,P,jP)
% plota a populacao de solucoes candidatas juntamente com as curvas de
% nivel da funcao objetivo
    
    s = length(lb);

    if (s == 2),
        [x,y] = meshgrid (lb(1):1/2:ub(1), lb(2):1/2:ub(2));    
        z = eval_matrix(fobj,x,y);
        contour(x,y,z);

        hold on    
        plot(P(1,:), P(2,:), 'k*');
        title('Algoritmo Genetico Simples')
        xlabel('x_1')
        ylabel('x_2')
        grid on
        hold off
    end

    % Imprime os seguintes resultados a cada iteracao:
    % - menor valor de fitness: f(x)
    % - melhor solucao: x = [ x(1) , x(2) ]
    % - geracao atual: g
    [opt,iopt]  = min(jP);
    fprintf(1, 'f(x) = ');
    fprintf(1, '%+6.4f  ', opt);
    fprintf(1, '\t x = [');
    fprintf(1, '%+6.4f  ', P(:,iopt)');
    fprintf(1, '\b\b]; \t g = %d\n', g);

    pause(0.5);

end


function z = eval_matrix(fobj,x,y)

    [u,v] = size(x);
    z = zeros(u,v);

    for i = 1:u
        for j = 1:v
            z(i,j) = feval(fobj,[x(i,j) y(i,j)]);
        end
    end

end