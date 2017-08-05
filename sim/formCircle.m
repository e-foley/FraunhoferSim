function [ M ] = formCircle( img_size, rel_radius )
    % create matrix with values ascending along columns
    A = ones(img_size, 1) * (-(img_size-1)/2:(img_size-1)/2);
    % sum of A and A' squares gives distance to center squared
    M = (A.^2) + (A'.^2) <= (img_size*rel_radius)^2;
    %imshow(M);
end
