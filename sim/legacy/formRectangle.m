function [ A ] = formRectangle( img_size, rel_center, rel_dims )
    A = zeros(img_size);
    % calculate center and bounds
    center = ((img_size + 1) / 2) + (img_size - 1) * rel_center;
    top = center(1) - (img_size - 1) * rel_dims(1) / 2;
    bottom = center(1) + (img_size - 1) * rel_dims(1) / 2;
    left = center(2) - (img_size - 1) * rel_dims(2) / 2;
    right = center(2) + (img_size - 1) * rel_dims(2) / 2;
    % populate regions contained by bounds
    A(ceil(top):floor(bottom), ceil(left):floor(right)) = 1;
end
