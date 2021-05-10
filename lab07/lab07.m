clear;clc;

evolution_range = 100;
population = 20;
p_cross = mean(rand(1,10));
p_mut = mean(rand(1,10));

pop = zeros(20, 22);

max_x = 0;
max_y = 0;

for i=1:evolution_range
    pop_tmp = randi(20);
    cross_amount = round(p_cross * pop_tmp);
    if mod(cross_amount,2) == 1
        cross_amount = cross_amount + 1;
    end
    mut_amount = round(p_mut * pop_tmp);
    cross = randi([1,population],cross_amount);
    mut = randi([1,population],mut_amount);
    
    cross_range = cross_amount/2;
    for j=1:cross_range
        i_index1 = cross(randi([1,cross_amount],1));
        cross(cross==i_index1) = [];
        cross_amount = cross_amount - 1;
        i_index2 = cross(randi([1,cross_amount],1));
        cross(cross==i_index2) = [];
        cross_amount = cross_amount - 1;
        [pop(i_index1,:) pop(i_index2,:)] = Crossover(pop(i_index1,:), pop(i_index2,:));
    end
    
    mut_range = mut_amount;
    for j=1:mut_range
        i_index = mut(randi([1,mut_amount],1));
        mut(mut==i_index1) = [];
        mut_amount = mut_amount - 1;
        pop(i_index,:) = Mutate(pop(i_index,:), p_mut);
    end
    
    for j=1:20
        res_x = resolve_x(pop(j,:));
        res_y = fx(res_x);
        if res_y >= max_y
            max_y = res_y;
            max_x = res_x;
        end
    end
end

pop_result = zeros(1,population);
for i=1:population
    pop_result(i) = resolve_x(pop(i,:));
end

x = linspace(-1,2, population);
y = x.*sin(10*pi.*x)+1;
hold on
plot(x, y);
plot(x, pop_result);
hold off

function y = fx(x)
    y = x.*sin(10*pi.*x)+1;
end

function x = resolve_x(X)
    X=round(X);
    x = (sum(X)/22)*3 - 1;
end