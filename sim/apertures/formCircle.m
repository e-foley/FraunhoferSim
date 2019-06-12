% Creates a circular transparent region in an image with specified canvas size.
% No anti-aliasing is applied.
%
% canvas_size_px  Dimensions of the image to create (pixels) [height,width]
% rel_radius      Radius of the circle as a ratio of the larger canvas dimension
%
% M               A 2D matrix with 1s in a center circular region and 0s
%                 elsewhere

function [M] = formCircle(canvas_size_px, rel_radius)
    M = zeros(canvas_size_px);
    center_px = (canvas_size_px + 1) / 2;
    max_dim_px = max(canvas_size_px);
    for x=1:canvas_size_px(1)
        for y=1:canvas_size_px(2)
            % Pixel is transparent (1) if its distance from the image center is
            % no greater than the circle's radius.
            M(x,y) = sum(([x,y] - center_px) .^ 2) <= (max_dim_px * rel_radius) ^ 2;
        end
    end
end
