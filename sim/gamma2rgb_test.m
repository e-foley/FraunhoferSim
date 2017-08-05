gamma = 0.8;
rows = 300;
lambdas = 370:790;
num_lambdas = numel(lambdas);
map = zeros(rows, num_lambdas, 3);

for i=1:num_lambdas
    rgb = lambdaToRgb(lambdas(i), gamma);
    map(:, i, :) = cat(3, rgb(1)*ones(rows, 1), rgb(2)*ones(rows, 1), rgb(3)*ones(rows, 1));
end

imshow(map);
