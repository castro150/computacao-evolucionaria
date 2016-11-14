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

vector_differences = zeros(n,N);
history = zeros(5,1);

generation = 1;
while((generation <= max_generations) && (mean(history) > 1e-3 || generation < 6))   
   for k = 1:N
      jP(k) = peaks(x(:,k)); 
   end
   history(mod(generation,5)+1,1) = max(jP) - min(jP);
   plotar(@peaks,[-3 -3],[3 3],generation,x,jP);
   
   for i=1:N
      r1 = randi(N,1);
      r2 = randi(N,1);
      r3 = randi(N,1);
      delta = randi(n,1);

      mu = rand(1);
      for j=1:n
         if((mu <= C)||(j == delta))
             vector_differences(j,i) = x(j,r1)+F*(x(j,r2)-x(j,r3));
         else
             vector_differences(j,i) = x(j,i);
         end
      end

      if(peaks(vector_differences(:,i)) <= peaks(x(:,i)))
          x_new(:,i) = vector_differences(:,i);
      else
          x_new(:,i) = x(:,i);
      end

      x(:,i) = x_new(:,i);
   end
   generation = generation+1;
end