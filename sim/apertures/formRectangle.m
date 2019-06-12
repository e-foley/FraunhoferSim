function [M] = formRectangle(canvas_size_px, rel_center, rel_dims)
    M = zeros(canvas_size_px);
    % calculate center and bounds
    center = ((canvas_size_px + 1) / 2) + (canvas_size_px - 1) * rel_center;
    top = center(1) - (canvas_size_px - 1) * rel_dims(1) / 2;
    bottom = center(1) + (canvas_size_px - 1) * rel_dims(1) / 2;
    left = center(2) - (canvas_size_px - 1) * rel_dims(2) / 2;
    right = center(2) + (canvas_size_px - 1) * rel_dims(2) / 2;
    % populate regions contained by bounds
    M(ceil(top):floor(bottom), ceil(left):floor(right)) = 1;
end
