clear; clc;

f = @(x,y)(x.^2 + y.^2 -20*(cos(pi*x)+cos(pi*y) - 2));

range_min = [-10, -10];
range_max = [10, 10];

% valid_min = particleswarm(f,2, range_min, range_max);

pop = 100;

itMax = 200;
adaptIterations = 10;

c1 = 2;
c2 = 2;

average_global = zeros(adaptIterations, 2);
average_population = zeros(adaptIterations, 2);

adapt_global = zeros(itMax, 2);
adapt_pop = zeros(itMax, 2);

for j=1:adaptIterations
    x_pop = 10 - 20.*rand(pop, 2);
    v_pop = rand(pop, 2);
    gbest = x_pop(1,:);
    pbest = x_pop(:,:);
    for k=1:itMax
        adapt= f(x_pop(:,1), x_pop(:,2));
        for i=1:pop
            if adapt(i) < f(gbest(1,1), gbest(1,2))
                gbest = x_pop(i,:);
            end
            if adapt(i) < f(pbest(i,1),pbest(i,2))
                pbest(i,:) = x_pop(i,:);
            end
        end
        for i=1:pop
            v_pop(i,:) = v_pop(i,:) + c1.*rand().*(pbest(i,:)-x_pop(i,:))+ c2.*rand().*(gbest(1,:)-x_pop(i,:));
            x_pop(i,:) = x_pop(i,:)+v_pop(i,:);
        end
        adapt_global(k,:) = gbest(1,:);
        adapt_pop(k,:) = mean(pbest);
    end
    average_global(j,:) = gbest(1,:);
    average_population(j,:) = mean(pbest);
end

avg_g = mean(average_global);
avg_pop = mean(average_population);

n = linspace(0, itMax, itMax);

hold on
    plot(n, f(adapt_global(:,1), adapt_global(:,2)));
    plot(n, f(adapt_pop(:,1), adapt_pop(:,2)));
hold off
