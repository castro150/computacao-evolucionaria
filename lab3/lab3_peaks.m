clear;
clc;

N = 100;
n = 2;
max_generations = 5000;
C = 0.8;
F = 0.9;

% Inicializa x entre -3 e 3
x = 6.*rand(n,N) - 3;
x_new = zeros(n,N);

x_mutant = zeros(n,N);
history = zeros(5,1);
jP = zeros(1, N);

generation = 1;
while((generation <= max_generations) && (mean(history) > 1e-3 || generation < 6))   
   for i=1:N
      jP(i) = peaks(x(:,i)); 
      
      r1 = randi(N,1);
      r2 = randi(N,1);
      r3 = randi(N,1);
      delta = randi(n,1);

      mu = rand(1);
      for j=1:n
         if((mu <= C)||(j == delta))
             x_mutant(j,i) = x(j,r1)+F*(x(j,r2)-x(j,r3));
         else
             x_mutant(j,i) = x(j,i);
         end
      end

      if(peaks(x_mutant(:,i)) <= peaks(x(:,i)))
          x_new(:,i) = x_mutant(:,i);
      else
          x_new(:,i) = x(:,i);
      end

      x(:,i) = x_new(:,i);
   end
   history(mod(generation,5)+1,1) = max(jP) - min(jP);
   plotar(@peaks,[-3 -3],[3 3],generation,x,jP);
   generation = generation+1;
end