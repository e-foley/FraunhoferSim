function [ M ] = formApodization(img_size, rel_std_dev)
    M = zeros(img_size);
    center = (img_size + 1) / 2;
    for x = 1:img_size
        for y = 1:img_size
            M(x,y) = exp(-(((x-center)^2 + (y-center)^2) / (2*(rel_std_dev*img_size)^2)));
        end
    end
    % imshow(M);
end
