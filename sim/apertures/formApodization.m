function [M] = formApodization(canvas_size_px, rel_std_dev)
    M = zeros(canvas_size_px);
    center = (canvas_size_px + 1) / 2;
    for x = 1:canvas_size_px
        for y = 1:canvas_size_px
            M(x,y) = exp(-(((x-center)^2 + (y-center)^2) / (2*(rel_std_dev*canvas_size_px)^2)));
        end
    end
    % imshow(M);
end
