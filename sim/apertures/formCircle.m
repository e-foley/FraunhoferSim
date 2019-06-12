function [M] = formCircle(canvas_size_px, rel_radius)
    % create matrix with values ascending along columns
    A = ones(canvas_size_px, 1) * (-(canvas_size_px-1)/2:(canvas_size_px-1)/2);
    % sum of A and A' squares gives distance to center squared
    M = (A.^2) + (A'.^2) <= (canvas_size_px*rel_radius)^2;
    %imshow(M);
end
